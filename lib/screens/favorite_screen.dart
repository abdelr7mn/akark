import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/property_provider.dart';
import '../widgets/property_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteList = context
        .watch<PropertyProvider>()
        .properties
        .where((p) => p.isFavorite)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
      ),
      body: favoriteList.isEmpty
          ? const Center(
              child: Text(
                'لا توجد عناصر في المفضلة حالياً',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final property = favoriteList[index];
                return PropertyCard(
                  property: property,
                  onFavoritePressed: () {
                    Provider.of<PropertyProvider>(context, listen: false)
                        .toggleFavorite(property.id);
                  },
                );
              },
            ),
    );
  }
}
