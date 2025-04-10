import 'package:akary/resoruses/color_manger.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // شفافية خفيفة
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 40,
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          isDense: true, // لتقليل الارتفاع الداخلي
                          contentPadding:
                              EdgeInsets.zero, // إزالة الحشو الداخلي
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14, // حجم خط مناسب
                        ),
                      ),
                    ),
                    if (searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () => searchController.clear(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Image.asset('assets/images/banner.png',),
    );
  }
}
