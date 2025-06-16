// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../model/property_model.dart';
//
// class PostDetailsScreen extends StatelessWidget {
//   final Property property;
//   final VoidCallback? onFavoritePressed;
//
//   const PostDetailsScreen({
//     super.key,
//     required this.property,
//     this.onFavoritePressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(property.title),
//         actions: [
//           IconButton(
//             icon: Icon(
//               property.isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: property.isFavorite ? Colors.red : null,
//             ),
//             onPressed: onFavoritePressed,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildImageSlider(),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (property.description.isNotEmpty)
//                     Text(
//                       property.description,
//                       style: const TextStyle(fontSize: 16, height: 1.5),
//                     ),
//                   const SizedBox(height: 20),
//                   _buildDetailRow(Icons.location_on, property.location),
//                   const SizedBox(height: 15),
//                   _buildDetailRow(Icons.attach_money, property.formattedPrice),
//                   const SizedBox(height: 15),
//                   _buildFeaturesRow(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageSlider() {
//     return SizedBox(
//       height: 300,
//       child: property.images.isEmpty
//           ? _buildPlaceholderImage()
//           : PageView.builder(
//               itemCount: property.images.length,
//               itemBuilder: (context, index) {
//                 return CachedNetworkImage(
//                   imageUrl: property.images[index],
//                   placeholder: (context, url) => _buildImageLoading(),
//                   errorWidget: (context, url, error) => _buildErrorImage(),
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 );
//               },
//             ),
//     );
//   }
//
//   Widget _buildPlaceholderImage() {
//     return Container(
//       color: Colors.grey[200],
//       child: Center(
//         child: Icon(Icons.home, size: 100, color: Colors.grey[400]),
//       ),
//     );
//   }
//
//   Widget _buildImageLoading() {
//     return const Center(child: CircularProgressIndicator());
//   }
//
//   Widget _buildErrorImage() {
//     return Container(
//       color: Colors.grey[200],
//       child: const Center(
//         child: Icon(Icons.error, size: 50, color: Colors.red),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.blue, size: 24),
//         const SizedBox(width: 8),
//         Text(
//           text,
//           style: const TextStyle(fontSize: 16),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFeaturesRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         _buildFeature(Icons.bed, '${property.bedrooms} غرف'),
//         _buildFeature(Icons.bathtub, '${property.bathrooms} حمام'),
//         _buildFeature(Icons.square_foot, '${property.area.toInt()} م²'),
//       ],
//     );
//   }
//
//   Widget _buildFeature(IconData icon, String text) {
//     return Column(
//       children: [
//         Icon(icon, size: 30, color: Colors.blue),
//         const SizedBox(height: 4),
//         Text(text),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../model/property_model.dart';



class PostDetailsScreen extends StatelessWidget {

  final Property property;

  final VoidCallback? onFavoritePressed;



  const PostDetailsScreen({

    super.key,

    required this.property,

    this.onFavoritePressed,

  });



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(property.title),

        actions: [

          IconButton(

            icon: Icon(

              property.isFavorite ? Icons.favorite : Icons.favorite_border,

              color: property.isFavorite ? Colors.red : null,

            ),

            onPressed: onFavoritePressed,

          ),

        ],

      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            _buildImageSlider(),

            Padding(

              padding: const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  if (property.description.isNotEmpty)

                    Text(

                      property.description,

                      style: const TextStyle(fontSize: 16, height: 1.5),

                    ),

                  const SizedBox(height: 20),

                  _buildDetailRow(Icons.location_on, property.location),

                  const SizedBox(height: 15),

                  _buildDetailRow(Icons.attach_money, property.formattedPrice),

                  const SizedBox(height: 15),

                  _buildFeaturesRow(),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }



  Widget _buildImageSlider() {

    final List<String> validImages = property.images.where((img) => img.isNotEmpty).toList();



    return SizedBox(

      height: 300,

      child: validImages.isEmpty

          ? _buildPlaceholderImage()

          : PageView.builder(

        itemCount: validImages.length,

        itemBuilder: (context, index) {

          return CachedNetworkImage(

            imageUrl: validImages[index],

            placeholder: (context, url) => _buildImageLoading(),

            errorWidget: (context, url, error) => _buildErrorImage(),

            fit: BoxFit.cover,

            width: double.infinity,

          );

        },

      ),

    );

  }



  Widget _buildPlaceholderImage() {

    return Container(

      width: double.infinity,

      color: Colors.grey[200],

      child: Center(

        child: Icon(Icons.home, size: 100, color: Colors.grey[400]),

      ),

    );

  }



  Widget _buildImageLoading() {

    return const Center(child: CircularProgressIndicator());

  }



  Widget _buildErrorImage() {

    return Container(

      color: Colors.grey[200],

      child: const Center(

        child: Icon(Icons.broken_image, size: 50, color: Colors.red),

      ),

    );

  }



  Widget _buildDetailRow(IconData icon, String text) {

    return Row(

      children: [

        Icon(icon, color: Colors.blue, size: 24),

        const SizedBox(width: 8),

        Expanded(

          child: Text(

            text,

            style: const TextStyle(fontSize: 16),

            overflow: TextOverflow.ellipsis,

          ),

        ),

      ],

    );

  }



  Widget _buildFeaturesRow() {

    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [

        _buildFeature(Icons.bed, '${property.bedrooms} غرف'),

        _buildFeature(Icons.bathtub, '${property.bathrooms} حمام'),

        _buildFeature(Icons.square_foot, '${property.area.toInt()} م²'),

      ],

    );

  }



  Widget _buildFeature(IconData icon, String text) {

    return Column(

      children: [

        Icon(icon, size: 30, color: Colors.blue),

        const SizedBox(height: 4),

        Text(text),

      ],

    );

  }

}