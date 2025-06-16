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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'] ?? '',
      subtitle: json['description'] ?? '',
      image: json['imageUrl'] ?? 'assets/images/banner.png',
      price: json['price'] ?? '',
    );
  }
}
