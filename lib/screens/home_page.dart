import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/property_provider.dart';
import '../widgets/property_card.dart';
import 'PostDetailsScreen.dart';

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
    final provider = Provider.of<PropertyProvider>(context, listen: false);
    await provider.fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('العقارات المتاحة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _buildBody(propertyProvider),
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
                  builder: (context) => PostDetailsScreen(
                    property: property,
                    onFavoritePressed: () {
                      Provider.of<PropertyProvider>(context, listen: false)
                          .toggleFavorite(property.id);
                    },
                  ),
                ),
              );
            },
            child: PropertyCard(
              property: property,
              onFavoritePressed: () {
                Provider.of<PropertyProvider>(context, listen: false)
                    .toggleFavorite(property.id);
              },
            ),
          );
        },
      ),
    );
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../model/property_model.dart';
// import '../provider/property_provider.dart';
// import '../widgets/property_card.dart';
// import 'PostDetailsScreen.dart';
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<PropertyProvider>().fetchProperties();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<PropertyProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('العقارات المتاحة'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: _showSearch,
//           ),
//         ],
//       ),
//       body: _buildBody(provider),
//     );
//   }
//
//   Widget _buildBody(PropertyProvider provider) {
//     if (provider.isLoading && provider.properties.isEmpty) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (provider.error.isNotEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(provider.error),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => provider.fetchProperties(),
//               child: const Text('إعادة المحاولة'),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return RefreshIndicator(
//       onRefresh: () => provider.fetchProperties(),
//       child: ListView.builder(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         itemCount: provider.properties.length,
//         itemBuilder: (context, index) {
//           final property = provider.properties[index];
//           return PropertyCard(
//             property: property,
//             onTap: () => _navigateToDetails(context, property),
//             onFavoritePressed: () => provider.toggleFavorite(property.id),
//           );
//         },
//       ),
//     );
//   }
//
//   void _navigateToDetails(BuildContext context, Property property) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => PropertyDetailsScreen(property: property),
//       ),
//     );
//   }
//
//   void _showSearch() {
//     showSearch(
//       context: context,
//       delegate: PropertySearchDelegate(
//         context.read<PropertyProvider>().properties,
//       ),
//     );
//   }
// }
//
// class PropertySearchDelegate extends SearchDelegate {
//   final List<Property> properties;
//
//   PropertySearchDelegate(this.properties);
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () => query = '',
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () => close(context, null),
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) => _buildSearchResults();
//
//   @override
//   Widget buildSuggestions(BuildContext context) => _buildSearchResults();
//
//   Widget _buildSearchResults() {
//     final results = properties.where((property) =>
//     property.title.toLowerCase().contains(query.toLowerCase()) ||
//         property.location.toLowerCase().contains(query.toLowerCase()) ||
//         property.street.toLowerCase().contains(query.toLowerCase()));
//
//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final property = results.elementAt(index);
//         return PropertyCard(
//           property: property,
//           onTap: () {
//             close(context, null);
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => PropertyDetailsScreen(property: property),
//               ),
//             );
//           },
//           onFavoritePressed: () {},
//         );
//       },
//     );
//   }
// }