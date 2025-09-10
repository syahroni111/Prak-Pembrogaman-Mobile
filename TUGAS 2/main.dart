import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row and Column',
      home: Scaffold(
        appBar: AppBar(title: Text('Row and Column')),
        body: Center(
          // Grid 2x2 menggunakan kombinasi Row & Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakBiruJempol(
                    color: const Color.fromARGB(255, 254, 74, 74),
                    label: "Pertama",
                  ),
                  SizedBox(width: 20),
                  KotakBiruJempol(
                    color: const Color.fromARGB(255, 221, 64, 238),
                    label: "Kedua",
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakBiruJempol(
                    color: const Color.fromARGB(255, 51, 98, 238),
                    label: "Ketiga",
                  ),
                  SizedBox(width: 20),
                  KotakBiruJempol(
                    color: const Color.fromARGB(255, 15, 182, 182),
                    label: "Keempat",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KotakBiruJempol extends StatelessWidget {
  final Color color;
  final String label;

  KotakBiruJempol({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.back_hand, // ganti ikon tangan
            color: const Color.fromARGB(255, 255, 229, 196),
            size: 40,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
