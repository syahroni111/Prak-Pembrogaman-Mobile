import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ini Halaman Home",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      // Menggunakan Container dengan warna dan padding untuk latar belakang
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 23, 52, 124), // Latar belakang gelap
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Teks Keterangan Halaman Utama
              const Text(
                'Banyak aplikasi memiliki beberapa layar untuk\nmenampilkan informasi yang berbeda. Contohnya,\nada layar produk, dan ketika pengguna mengklik\nproduk, akan muncul layar dengan detail produk\ntersebut.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 30),

              // Contoh Ikon (seperti rumah di contoh tampilan)
              const Icon(Icons.home, size: 120, color: Colors.white),

              const SizedBox(height: 50),

              // Tombol untuk menuju Halaman Tujuan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Warna Tombol
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Perintah navigasi menggunakan Named Route
                  Navigator.pushNamed(context, '/tujuan');
                },
                child: const Text(
                  "Ke Halaman Tujuan >",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
