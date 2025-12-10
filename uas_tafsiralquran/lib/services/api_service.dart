// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/theme_model.dart';
import '../models/verse_model.dart';

const String _baseUrl = 'https://tafsirtematik-api.vercel.app';

class ApiService {
  final http.Client client;

  ApiService({required this.client});

  // 1. Ambil Daftar Tema (GET /themes)
  Future<List<ThemeModel>> getThemes() async {
    // Kita panggil endpoint /themes di Vercel
    final url = Uri.parse('$_baseUrl/themes');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((e) => ThemeModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Gagal mengambil data tema. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getThemes: $e');
      throw Exception(
          'Gagal terhubung ke server. Pastikan koneksi internet aktif.');
    }
  }

  // 2. Ambil Ayat berdasarkan ID Tema (HARUS DILAKUKAN DI SISI KLIEN)
  // Karena Vercel hanya menyajikan file statis, kita ambil semua ayat
  // lalu filter berdasarkan themeId.
  Future<List<VerseModel>> getVersesByTheme(int themeId) async {
    final url = Uri.parse('$_baseUrl/verses'); // Panggil endpoint /verses

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        // --- CLIENT-SIDE FILTERING ---
        final allVerses = jsonList
            .map((e) => VerseModel.fromJson(e as Map<String, dynamic>))
            .toList();

        // Filter ayat yang themeId-nya sesuai
        return allVerses.where((verse) => verse.themeId == themeId).toList();
      } else {
        throw Exception(
            'Gagal mengambil data ayat. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getVersesByTheme: $e');
      throw Exception('Gagal terhubung ke server.');
    }
  }

// 3. Fungsi Login (Simulasi Sukses)
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulasi delay
    // Selalu anggap sukses, tidak peduli apa inputnya
    return true;
  }

// 4. Fungsi Register (Simulasi Sukses)
  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000)); // Simulasi delay
    // Selalu anggap sukses, tidak peduli apa inputnya
    return true;
  }

  // Fungsi searchThemes tidak perlu diubah karena tidak digunakan di UI (home_page.dart)
}
