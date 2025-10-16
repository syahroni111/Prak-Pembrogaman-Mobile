import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:get/get.dart'; // Import GetX
import '../viewmodel/tasbih_controller.dart'; // Import Controller

// Inisialisasi Controller
final TasbihController controller = Get.put(TasbihController()); //

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 119, 210, 145),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  '${controller.counter.value.round()}', // Akses nilai reaktif dengan .value
                  style: const TextStyle(fontSize: 250),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: LinearProgressIndicator(
                    // value diikat ke nilai progress controller (dibagi 100 karena value 0-1)
                    value: controller.progress.value / 100,
                    backgroundColor: Colors.white54,
                    color: Colors.amberAccent.shade400,
                    minHeight: 15,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 75),
              // Tombol Tambah (Fingerprint)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: InkWell(
                  onTap: controller
                      .incrementCounter, // Panggil method di controller
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Icon(Icons.fingerprint, size: 100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Tombol Reset (Floating Action Button)
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Aksi masih kosong
        backgroundColor: Colors.white,
        child: const Icon(Icons.refresh_outlined, color: Colors.black),
      ),
    );
  }
}
