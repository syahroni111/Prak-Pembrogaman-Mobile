import 'package:get/get.dart';

class TasbihController extends GetxController {
  // Variabel reaktif (observable) dengan .obs
  var counter = 0.0.obs; //
  var progress = 0.0.obs; //
  
  final double maxCount = 33; // Batas hitungan tasbih

  // Method untuk menambah hitungan
  void incrementCounter() {
    if (counter.value < maxCount) {
      counter.value++; // Akses nilai dengan .value
      // Hitung progress dalam persentase
      progress.value = (counter.value / maxCount) * 100; //
    }
  }

  // Method untuk mereset hitungan
  void resetCounter() {
    counter.value = 0; //
    progress.value = 0; //
  }
}