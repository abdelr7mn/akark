import 'package:akary/model/post_model.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final List<PostModel> _posts = [
    PostModel(
      title: 'شقة في التجمع',
      subtitle: '3 غرف - 2 حمام',
      image: 'assets/images/banner.png',
      price: '950,000 جنيه',
    ),
    PostModel(
      title: 'شقة في المعادي',
      subtitle: '2 غرف - 1 حمام',
      image: 'assets/images/banner.png',
      price: '850,000 جنيه',
    ),
  ];

  List<PostModel> get posts => _posts;

  List<PostModel> get favorites =>
      _posts.where((post) => post.isFavorite).toList();

  void toggleFavorite(PostModel post) {
    post.isFavorite = !post.isFavorite;
    notifyListeners();
  }
}
