import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("التفاصيل ")),
      body: Column(
        children: [
          Image.asset(
            'assets/images/banner.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "تفاصيل كاملة عن العقار هنا...",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
