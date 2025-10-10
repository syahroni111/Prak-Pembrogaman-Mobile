import 'dart:convert';
import 'package:modul10/model/game.dart';
import 'package:http/http.dart' as http;

// Fungsi untuk mengambil daftar game (Tahap 1)
Future<List<Game>> fetchGames() async {
  final response = await http.get(
    Uri.parse('https://www.freetogame.com/api/games'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((item) => Game.fromJson(item)).toList();
  } else {
    throw Exception('Gagal mengambil data game');
  }
}

// Fungsi untuk mengambil detail game berdasarkan ID (Tahap 2)
Future<Map<String, dynamic>> fetchDataFromAPI(int idGame) async {
  final response = await http.get(
    Uri.parse('https://www.freetogame.com/api/game?id=$idGame'),
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    if (jsonData is Map<String, dynamic>) {
      return jsonData;
    } else {
      throw Exception('Data dari API tidak sesuai dengan yang diharapkan');
    }
  } else {
    throw Exception('Gagal mengambil data dari API');
  }
}
