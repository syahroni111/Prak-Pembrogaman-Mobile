import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart'; // [cite: 143]

void main() {
  runApp(const MyApp());
}

// 1. Kelas Utama sebagai Stateful Widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState(); // [cite: 154]
}

// 2. Kelas State untuk mengelola data
class MyAppState extends State<MyApp> {
  // State untuk mengontrol Circular Progress Bar
  late ValueNotifier<double> _valueNotifier; // [cite: 155]

  // State untuk menyimpan nilai hitungan tasbih
  late double counter; // [cite: 156]

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(
      0.0,
    ); // Inisialisasi notifier dengan nilai 0.0 [cite: 157]
    counter = 0.0; // Inisialisasi counter dengan nilai 0.0 [cite: 156]
  }

  @override
  void dispose() {
    _valueNotifier
        .dispose(); // Membersihkan notifier saat widget dihapus [cite: 158]
    super.dispose();
  }

  // 3. Method untuk menambah hitungan
  void incrementCounter() {
    // [cite: 161]
    setState(() {
      if (counter < 33) {
        // Batasi hitungan maksimal 33 [cite: 163]
        counter++; // [cite: 164]
        // Hitung persentase untuk progress bar: (nilai saat ini / maksimal) * 100
        _valueNotifier.value = (counter / 33) * 100; // [cite: 165, 166]
      }
    });
  }

  // 4. Method untuk mereset hitungan
  void resetCounter() {
    // [cite: 174]
    setState(() {
      counter = 0.0; // Reset counter ke 0 [cite: 179]
      _valueNotifier.value = 0.0; // Reset progress bar ke 0 [cite: 180]
    });
  }

  // 5. Method build untuk membangun UI
  @override
  Widget build(BuildContext context) {
    // Mengatur status bar menjadi transparan
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ), // [cite: 193]
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false, // [cite: 195]
      theme: ThemeData(
        // Menggunakan seed color yang mirip warna hijau pada contoh
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 119, 210, 145),
        ), // [cite: 198]
        useMaterial3: true,
      ),
      home: Scaffold(
        // Latar belakang hijau sesuai contoh
        backgroundColor: const Color.fromARGB(
          255,
          119,
          210,
          145,
        ), // [cite: 201]
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Pusatkan secara vertikal
              children: [
                // Teks Counter di atas progress bar
                Text(
                  '${(counter.round())}', // Menampilkan nilai counter saat ini [cite: 219]
                  style: const TextStyle(fontSize: 50), // [cite: 221]
                ),

                // Circular Progress Bar
                SimpleCircularProgressBar(
                  progressColors: [
                    Colors.amberAccent.shade400,
                  ], // Warna progress bar [cite: 225]
                  size: 300, // Ukuran progress bar [cite: 226]
                  progressStrokeWidth: 20, // Tebal garis progress [cite: 227]
                  backStrokeWidth: 10, // Tebal garis latar belakang [cite: 229]
                  mergeMode: true, // [cite: 231]
                  maxValue:
                      100, // Nilai maksimal (untuk persentase) [cite: 233]
                  animationDuration: 0, // Animasi dinonaktifkan [cite: 235]
                  valueNotifier:
                      _valueNotifier, // Dikontrol oleh state _valueNotifier [cite: 237]
                  onGetText: (value) {
                    // Teks besar di tengah lingkaran (Menampilkan counter)
                    return Text(
                      '${(value.toInt() ~/ 3).round()}', // Menghitung kembali nilai dari persentase
                      style: const TextStyle(fontSize: 178), // [cite: 244]
                    );
                  },
                ),

                const SizedBox(height: 50), // Jarak [cite: 266]
                // Tombol Tambah (berbentuk InkWell dengan icon fingerprint)
                ClipRRect(
                  // [cite: 267]
                  borderRadius: const BorderRadius.all(
                    Radius.circular(58),
                  ), // [cite: 268]
                  child: InkWell(
                    // Menggunakan InkWell untuk interaksi [cite: 268]
                    onTap:
                        incrementCounter, // Panggil method tambah [cite: 269]
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ), // [cite: 271]
                      child: const Icon(
                        Icons.fingerprint, // Icon [cite: 273]
                        size: 125, // Ukuran icon [cite: 274]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Floating Action Button untuk Reset
        floatingActionButton: FloatingActionButton(
          // [cite: 275]
          onPressed: resetCounter, // Panggil method reset [cite: 276]
          child: const Icon(Icons.refresh_outlined), // [cite: 277]
        ),
      ),
    );
  }
}
