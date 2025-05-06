import 'package:flutter/material.dart';
import 'posts.dart';

class Itemlistview extends StatelessWidget {
  const Itemlistview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Posts(),
        );
      },  
    );
  }
}
