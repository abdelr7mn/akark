import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/property_provider.dart';
import '../widgets/property_card.dart';
import 'favorite_screen.dart';
import 'PostDetailsScreen.dart';
import '../resoruses/color_manger.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    await context.read<PropertyProvider>().fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PropertyProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.grey3,
        title: const Text(
          'العقارات المتاحة',
          style: TextStyle(color: ColorManager.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'المفضلة',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'تحديث',
            onPressed: _loadData,
          ),
        ],
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(PropertyProvider provider) {
    if (provider.isLoading && provider.properties.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.error),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadData,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: provider.properties.length,
        itemBuilder: (context, index) {
          final property = provider.properties[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostDetailsScreen(
                    property: property,
                    onFavoritePressed: () {
                      context
                          .read<PropertyProvider>()
                          .toggleFavorite(property.id);
                    },
                  ),
                ),
              );
            },
            child: PropertyCard(
              property: property,
              onFavoritePressed: () {
                context.read<PropertyProvider>().toggleFavorite(property.id);
              },
            ),
          );
        },
      ),
    );
  }
}
