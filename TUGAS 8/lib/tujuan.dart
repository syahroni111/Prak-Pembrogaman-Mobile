import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen_arguments.dart';

class Tujuan extends StatelessWidget {
  const Tujuan({super.key});

  static const routeName = '/extractArguments'; // Nama route tujuan

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    // Mengambil argumen yang dikirim dari Home
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF94A29), // Latar belakang merah/oranye
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Bagian Detail Game ---
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F8FB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Cover Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(args.cover, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 15),
                      // Title
                      Text(
                        args.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Description
                      Text(
                        args.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- Tombol Kembali ---
                const SizedBox(height: 25),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0081c9), // Warna biru tombol
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 15,
                              color: Color(0xFFF4F8FB),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Kembali ke game',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFF4F8FB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25), // Padding bawah
              ],
            ),
          ),
        ),
      ),
    );
  }
}
