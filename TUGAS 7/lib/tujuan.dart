import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ini Halaman Tujuan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      // Menggunakan Container dengan warna dan padding untuk latar belakang
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFFC0392B), // Latar belakang merah/oranye
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Teks Keterangan Halaman Tujuan
              const Text(
                'Untuk berpindah ke halaman baru, gunakan metode\nNavigator.push(). Metode push() akan menambahkan\nRoute ke dalam tumpukan Route yang dikelola oleh\nNavigator. Route ini dapat dibuat secara kustom atau\nmenggunakan MaterialPageRoute, yang memiliki\nanimasi transisi sesuai dengan platform yang digunakan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 30),

              // Contoh Ikon (seperti pohon kelapa di contoh tampilan)
              const Icon(Icons.beach_access, size: 120, color: Colors.white),

              const SizedBox(height: 50),

              // Tombol untuk kembali ke Halaman Home
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna Tombol
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
                  // Perintah navigasi untuk menutup halaman saat ini dan kembali
                  Navigator.pop(context);
                },
                child: const Text(
                  "< Kembali ke home",
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
