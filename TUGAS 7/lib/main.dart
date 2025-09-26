import 'package:flutter/material.dart';
import 'home.dart';
import 'tujuan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Navigasi Tugas',
      // Menentukan halaman awal aplikasi
      initialRoute: '/',
      // Mendaftarkan semua halaman (routes)
      routes: {
        '/': (context) => const HomePage(),
        '/tujuan': (context) => const TujuanPage(),
      },
    );
  }
}
