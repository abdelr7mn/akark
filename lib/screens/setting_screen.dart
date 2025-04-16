import 'package:akary/resoruses/color_manger.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text(
          'Setting',
          style: TextStyle(color: ColorManager.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Username',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'email@example.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Lang '),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // أضف الأكشن هنا
            },
          ),

          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text(' Dark Mood'),
            trailing: Switch(value: false, onChanged: (val) {}),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log out ', style: TextStyle(color: Colors.red)),
            onTap: () {
              // تسجيل الخروج
            },
          ),
        ],
      ),
    );
  }
}
