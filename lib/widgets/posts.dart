import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/property_provider.dart';
import '../widgets/property_card.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PropertyProvider>(context);

    return RefreshIndicator(
      onRefresh: () => provider.fetchProperties(),
      child: _buildContent(context, provider),
    );
  }

  Widget _buildContent(BuildContext context, PropertyProvider provider) {
    if (provider.isLoading) return _buildLoadingView();
    if (provider.error.isNotEmpty)
      return _buildErrorView(context, provider.error);
    if (provider.properties.isEmpty) return _buildEmptyView();

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: provider.properties.length,
      itemBuilder: (context, index) {
        final property = provider.properties[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PropertyCard(
            property: property,
            onFavoritePressed: () => provider.toggleFavorite(property.id),
          ),
        );
      },
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('حدث خطأ: $error'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<PropertyProvider>().fetchProperties(),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 50, color: Colors.grey),
          SizedBox(height: 16),
          Text('لا توجد عقارات متاحة حالياً'),
        ],
      ),
    );
  }
}
