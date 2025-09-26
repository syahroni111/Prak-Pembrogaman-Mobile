import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'tujuan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengatur warna status bar menjadi transparan
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigasi Argumen Game',
      theme: ThemeData(
        // Tema warna biru sesuai contoh
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0081c9)),
        useMaterial3: true,
      ),
      initialRoute: '/', // Rute awal aplikasi
      routes: {
        '/': (context) => const Home(),
        Tujuan.routeName: (context) => const Tujuan(),
      },
    );
  }
}
