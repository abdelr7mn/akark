import 'package:akary/provider/post_provider.dart';
import 'package:akary/resoruses/color_manger.dart';
import 'package:akary/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<PostProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text(
          'Favorites',
          style: TextStyle(color: ColorManager.white),
        ),
        centerTitle: true,
      ),
      body:
          favorites.isEmpty
              ? const Center(child: Text('NO Things added'))
              : GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (_, index) {
                  return PostCard(post: favorites[index]);
                },
              ),
    );
  }
}
