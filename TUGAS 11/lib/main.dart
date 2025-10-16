import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'view/home.dart'; // Import Home

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Menggunakan GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Tasbih Digital GetX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: Home(), // Mengarahkan ke halaman Home
    );
  }
}