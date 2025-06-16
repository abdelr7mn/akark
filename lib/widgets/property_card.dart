// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../model/property_model.dart';
//
// class PropertyCard extends StatelessWidget {
//   final Property property;
//   final VoidCallback? onFavoritePressed;
//
//   const PropertyCard({
//     required this.property,
//     this.onFavoritePressed,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       clipBehavior: Clip.antiAlias,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildImageSection(),
//           _buildDetailsSection(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildImageSection() {
//     return Stack(
//       children: [
//         SizedBox(
//           height: 180,
//           width: double.infinity,
//           child: CachedNetworkImage(
//             imageUrl: property.images.isNotEmpty
//                 ? property.images.first
//                 : Property.getPlaceholderImage(),
//             placeholder: (_, __) => _buildImagePlaceholder(),
//             errorWidget: (_, __, ___) => _buildImagePlaceholder(),
//             fit: BoxFit.cover,
//           ),
//         ),
//         Positioned(
//           top: 8,
//           right: 8,
//           child: IconButton(
//             icon: Icon(
//               property.isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: property.isFavorite ? Colors.red : Colors.white,
//             ),
//             onPressed: onFavoritePressed,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDetailsSection() {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             property.title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 8),
//           _buildLocationRow(),
//           const SizedBox(height: 8),
//           _buildPriceAndFeaturesRow(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildImagePlaceholder() {
//     return Container(
//       color: Colors.grey[200],
//       child: const Center(
//         child: Icon(Icons.home, size: 50, color: Colors.grey),
//       ),
//     );
//   }
//
//   Widget _buildLocationRow() {
//     return Row(
//       children: [
//         const Icon(Icons.location_on, size: 16, color: Colors.blue),
//         const SizedBox(width: 4),
//         Expanded(
//           child: Text(
//             property.location,
//             style: const TextStyle(fontSize: 14),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPriceAndFeaturesRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           property.formattedPrice,
//           style: const TextStyle(
//             color: Colors.green,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         Row(
//           children: [
//             _buildFeatureItem(Icons.bed, '${property.bedrooms}'),
//             const SizedBox(width: 8),
//             _buildFeatureItem(Icons.bathtub, '${property.bathrooms}'),
//             const SizedBox(width: 8),
//             _buildFeatureItem(Icons.square_foot, '${property.area.toInt()} م²'),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFeatureItem(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.blue),
//         const SizedBox(width: 2),
//         Text(text, style: const TextStyle(fontSize: 12)),
//       ],
//     );
//   }
// }
//
//
//
//

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/property_model.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onFavoritePressed;

  const PropertyCard({
    required this.property,
    this.onFavoritePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          _buildDetailsSection(),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    final String imageUrl = (property.images.isNotEmpty && property.images.first.isNotEmpty)
        ? property.images.first
        : Property.getPlaceholderImage();

    return Stack(
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (_, __) => _buildImagePlaceholder(),
            errorWidget: (_, __, ___) => _buildImagePlaceholder(),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              property.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: property.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: onFavoritePressed,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          _buildLocationRow(),
          const SizedBox(height: 8),
          _buildPriceAndFeaturesRow(),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 16, color: Colors.blue),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            property.location,
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndFeaturesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          property.formattedPrice,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            _buildFeatureItem(Icons.bed, '${property.bedrooms}'),
            const SizedBox(width: 8),
            _buildFeatureItem(Icons.bathtub, '${property.bathrooms}'),
            const SizedBox(width: 8),
            _buildFeatureItem(Icons.square_foot, '${property.area.toInt()} م²'),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blue),
        const SizedBox(width: 2),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
