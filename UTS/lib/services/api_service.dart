// lib/services/api_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/theme_model.dart';
import '../models/verse_model.dart';

class ApiService {
  // baca file lokal JSON (db.json)
  static Future<Map<String, dynamic>> _loadJson() async {
    final data = await rootBundle.loadString('assets/db.json');
    return jsonDecode(data);
  }

  // ambil daftar tema
  static Future<List<ThemeModel>> getThemes() async {
    try {
      final json = await _loadJson();
      final list = json['themes'] as List;
      return list.map((e) => ThemeModel.fromJson(e)).toList();
    } catch (e) {
      print('Error load themes: $e');
      return [];
    }
  }

  // ambil semua ayat berdasarkan id tema
  static Future<List<VerseModel>> getVersesByTheme(int themeId) async {
    try {
      final json = await _loadJson();
      final list = json['verses'] as List;
      final filtered = list.where((v) => v['themeId'] == themeId).toList();
      return filtered.map((e) => VerseModel.fromJson(e)).toList();
    } catch (e) {
      print('Error load verses: $e');
      return [];
    }
  }

  // contoh tambahan untuk baca semua ayat (jika nanti perlu)
  static Future<List<VerseModel>> getAllVerses() async {
    try {
      final json = await _loadJson();
      final list = json['verses'] as List;
      return list.map((e) => VerseModel.fromJson(e)).toList();
    } catch (e) {
      print('Error load all verses: $e');
      return [];
    }
  }
}
