import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screen_arguments.dart';
import 'tujuan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  // Variabel untuk menyimpan data game yang diambil dari API
  var title, thumbnail, short_description, description;
  var genre, platform, release, cover, gameid, publisher;

  @override
  void initState() {
    super.initState();
    // Panggil game default saat halaman pertama kali dibuat
    getGame('475'); // ID Game Forza Motorsport 6: Apex
  }

  // Method untuk mengambil detail 1 game dari API
  Future getGame(String gameid) async {
    http.Response response = await http.get(
      Uri.parse('https://www.freetogame.com/api/game?id=$gameid'),
    );
    var results = jsonDecode(response.body);

    // Memperbarui UI dengan data yang diterima
    setState(() {
      this.gameid = gameid;
      title = results['title'];
      thumbnail = results['thumbnail'];
      short_description = results['short_description'];
      description = results['description'];
      genre = results['genre'];
      platform = results['platform'];
      publisher = results['publisher'];
      release = results['release_date'];
      // Mengambil gambar cover dari array screenshots (jika ada)
      cover = results['screenshots'][0]['image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0081c9), // Warna latar biru
      body: SafeArea(
        child: Center(
          child:
              gameid ==
                  null // Cek jika data masih dimuat
              ? const CircularProgressIndicator() // Tampilkan loading
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 1. Membuat objek ScreenArguments dari data game
                        final args = ScreenArguments(
                          cover,
                          title,
                          description,
                          short_description,
                        );

                        // 2. Navigasi ke halaman tujuan sambil mengirim objek argumen
                        Navigator.pushNamed(
                          context,
                          Tujuan.routeName,
                          arguments: args,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            // Thumbnail Image
                            Image.network(thumbnail),
                            const SizedBox(height: 15),
                            // Title
                            Text(title, style: const TextStyle(fontSize: 24)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Genre: $genre"),
                                    Text("Platform: $platform"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Publisher: $publisher"),
                                    Text("Release: $release"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
