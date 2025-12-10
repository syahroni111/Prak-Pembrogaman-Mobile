// lib/main.dart
import 'package:flutter/material.dart';
import 'models/theme_model.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/settings_page.dart';
import 'screens/theme_detail_page.dart';
import 'screens/splash_page.dart';
import 'screens/register_page.dart';

void main() {
  runApp(const TafsirTematikApp());
}

class TafsirTematikApp extends StatelessWidget {
  const TafsirTematikApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tafsir Tematik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF8F3F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF795548),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF795548),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (c) => const SplashPage(),
        LoginPage.routeName: (c) => const LoginPage(),
        RegisterPage.routeName: (c) => const RegisterPage(), // tambahkan ini
        HomePage.routeName: (c) => const HomePage(),
        SettingsPage.routeName: (c) => const SettingsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/theme-detail') {
          final theme = settings.arguments as ThemeModel;
          return MaterialPageRoute(
              builder: (_) => ThemeDetailPage(theme: theme));
        }
        return null;
      },
    );
  }
}
