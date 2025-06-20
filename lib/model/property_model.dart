import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class Property {
  final int id;
  final String title;
  final String description;
  final double price;
  final String location;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  final double area;
  bool isFavorite;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.images,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    this.isFavorite = false,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    // معالجة السعر
    double parsePrice(dynamic price) {
      if (price is num) return price.toDouble();
      if (price is String) {
        return double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
      }
      return 0.0;
    }

    // معالجة الموقع
    String parseLocation(dynamic location) {
      if (location == null || location.toString().trim().isEmpty) {
        return 'موقع غير محدد';
      }
      return location.toString();
    }

    // معالجة الصور
    List<String> parseImages(dynamic imagesData) {
      try {
        if (imagesData is List && imagesData.isNotEmpty) {
          return imagesData
              .map((img) => formatImageUrl(img.toString()))
              .toList();
        }
        if (imagesData is String && imagesData.isNotEmpty) {
          return [formatImageUrl(imagesData)];
        }
        return [getPlaceholderImage()];
      } catch (e) {
        return [getPlaceholderImage()];
      }
    }

    return Property(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? 'عقار جديد',
      description: json['description']?.toString() ?? 'لا يوجد وصف متاح',
      price: parsePrice(json['price']),
      location:
          parseLocation(json['location'] ?? json['address'] ?? json['city']),
      images: parseImages(
        json['images'] ?? json['photoUrl'] ?? json['image'] ?? '',
      ),
      bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 0,
      bathrooms: (json['bathrooms'] as num?)?.toInt() ?? 0,
      area: (json['area'] as num?)?.toDouble() ??
          (json['size'] as num?)?.toDouble() ??
          0.0,
    );
  }

  static String formatImageUrl(String url) {
    if (url.startsWith('http')) return url;
    if (url.startsWith('/')) return 'https://aqqaraak.runasp.net$url';
    return 'https://aqqaraak.runasp.net/$url';
  }

  static String getPlaceholderImage() {
    return 'https://aqqaraak.runasp.net/images/placeholder.jpg';
  }

  String get formattedPrice {
    if (price <= 0) return 'السعر غير متوفر';

    final formatter = NumberFormat.currency(
      locale: 'ar_EG',
      symbol: 'جنيه',
      decimalDigits: 0,
    );

    return formatter.format(price);
  }
}
