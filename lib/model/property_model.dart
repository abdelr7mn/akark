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
      area: (json['area'] as num?)?.toDouble() ?? (json['size'] as num?)?.toDouble() ?? 0.0,
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



// import 'package:easy_localization/easy_localization.dart';
// import 'package:intl/intl.dart';
//
// class Property {
//   final int id;
//   final String title;
//   final String description;
//   final double price;
//   final String location;
//   final List<String> images;
//   final int bedrooms;
//   final int bathrooms;
//   final double area;
//   bool isFavorite;
//
//   Property({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.location,
//     required this.images,
//     required this.bedrooms,
//     required this.bathrooms,
//     required this.area,
//     this.isFavorite = false,
//   });
//
//   factory Property.fromJson(Map<String, dynamic> json) {
//     // معالجة السعر
//     double parsePrice(dynamic price) {
//       if (price is num) return price.toDouble();
//       if (price is String) {
//         return double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
//       }
//       return 0.0;
//     }
//
//     // معالجة الموقع
//     String parseLocation(dynamic location) {
//       if (location == null || location.toString().trim().isEmpty) {
//         return 'موقع غير محدد';
//       }
//       return location.toString();
//     }
//
//     // معالجة الصور
//     List<String> parseImages(dynamic imagesData) {
//       try {
//         if (imagesData is List && imagesData.isNotEmpty) {
//           return imagesData
//               .map((img) => formatImageUrl(img.toString()))
//               .toList();
//         }
//         if (imagesData is String && imagesData.isNotEmpty) {
//           return [formatImageUrl(imagesData)];
//         }
//         return [getPlaceholderImage()];
//       } catch (e) {
//         return [getPlaceholderImage()];
//       }
//     }
//
//     return Property(
//       id: json['id'] ?? 0,
//       title: json['title']?.toString() ?? 'عقار جديد',
//       description: json['description']?.toString() ?? 'لا يوجد وصف متاح',
//       price: parsePrice(json['price']),
//       location:
//           parseLocation(json['location'] ?? json['address'] ?? json['city']),
//       images: parseImages(json['images'] ?? json['imageUrl']),
//       bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 0,
//       bathrooms: (json['bathrooms'] as num?)?.toInt() ?? 0,
//       area: (json['area'] as num?)?.toDouble() ?? 0.0,
//     );
//   }
//
//   static String formatImageUrl(String url) {
//     if (url.startsWith('http')) return url;
//     if (url.startsWith('/')) return 'https://aqqaraak.runasp.net$url';
//     return 'https://aqqaraak.runasp.net/$url';
//   }
//
//   static String getPlaceholderImage() {
//     return 'https://aqqaraak.runasp.net/images/placeholder.jpg';
//   }
//
//   String get formattedPrice {
//     if (price <= 0) return 'السعر غير متوفر';
//
//     final formatter = NumberFormat.currency(
//       locale: 'ar_EG',
//       symbol: 'جنيه',
//       decimalDigits: 0,
//     );
//
//     return formatter.format(price);
//   }
// }
// // import 'package:intl/intl.dart';
// //
// // import 'package:easy_localization/easy_localization.dart';
// //
// // class Property {
// //   final int id;
// //   final String title;
// //   final String description;
// //   final double price;
// //   final String location;
// //   final String street;
// //   final String neighborhood;
// //   final List<String> images;
// //   final int bedrooms;
// //   final int bathrooms;
// //   final double area;
// //   bool isFavorite;
// //
// //   Property({
// //     required this.id,
// //     required this.title,
// //     required this.description,
// //     required this.price,
// //     required this.location,
// //     required this.street,
// //     required this.neighborhood,
// //     required this.images,
// //     required this.bedrooms,
// //     required this.bathrooms,
// //     required this.area,
// //     this.isFavorite = false,
// //   });
// //
// //   factory Property.fromJson(Map<String, dynamic> json) {
// //     return Property(
// //       id: json['id'] ?? 0,
// //       title: json['title']?.toString().trim() ?? 'عقار جديد',
// //       description: json['description']?.toString().trim() ?? 'لا يوجد وصف متاح',
// //       price: _parsePrice(json['price']),
// //       location: json['location']?.toString().trim() ?? 'موقع غير محدد',
// //       street: json['street']?.toString().trim() ?? 'شارع غير محدد',
// //       neighborhood: json['neighborhood']?.toString().trim() ?? 'حي غير محدد',
// //       images: _parseImages(json['images'] ?? json['image']),
// //       bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 0,
// //       bathrooms: (json['bathrooms'] as num?)?.toInt() ?? 0,
// //       area: (json['area'] as num?)?.toDouble() ?? 0.0,
// //     );
// //   }
// //
// //   static double _parsePrice(dynamic price) {
// //     if (price == null) return 0.0;
// //     if (price is num) return price.toDouble();
// //     if (price is String) {
// //       return double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
// //     }
// //     return 0.0;
// //   }
// //
// //   static List<String> _parseImages(dynamic images) {
// //     if (images is List) {
// //       return images.whereType<String>().where((img) => img.isNotEmpty).toList();
// //     }
// //     if (images is String && images.isNotEmpty) {
// //       return [images];
// //     }
// //     return [];
// //   }
// //
// //   String get formattedPrice {
// //     if (price <= 0) return 'السعر غير محدد';
// //     return NumberFormat.currency(
// //       locale: 'ar_EG',
// //       symbol: 'جنيه',
// //       decimalDigits: 0,
// //     ).format(price);
// //   }
// //
// //   String get fullAddress {
// //     return '$street، $neighborhood، $location';
// //   }
// //
// //   String get featuresSummary {
// //     return '${bedrooms} غرف | ${bathrooms} حمام | ${area.toInt()} م²';
// //   }
// //
// //   static getPlaceholderImage() {}
// // }