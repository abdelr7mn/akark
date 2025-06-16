import 'package:akary/provider/post_provider.dart';
import 'package:akary/provider/property_provider.dart';
import 'package:akary/resoruses/color_manger.dart';
import 'package:akary/screens/favorite_screen.dart';
import 'package:akary/screens/home_page.dart';
import 'package:akary/screens/login_screen.dart';
import 'package:akary/screens/profile_page.dart';
import 'package:akary/screens/register_screen.dart';
import 'package:akary/screens/setting_screen.dart';
import 'package:akary/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PostProvider()),
          ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ],
        child: MyApp(initialToken: token),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String? initialToken;

  const MyApp({super.key, this.initialToken});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  void initState() {
    super.initState();

    if (widget.initialToken != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final propertyProvider = Provider.of<PropertyProvider>(context, listen: false);
        propertyProvider.setAuthToken(widget.initialToken!);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainScreen(),
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const FavoritesPage(),
    const ProfilePage(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: tr('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            label: tr('favorite'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: tr('profile'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: tr('setting'),
          ),
        ],
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.grey2,
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

