class PostModel {
  final String title;
  final String subtitle;
  final String image;
  final String price;
  bool isFavorite;

  PostModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
    this.isFavorite = false,
  });
}
