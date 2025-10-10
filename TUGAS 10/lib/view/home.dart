import 'package:flutter/material.dart';
import 'package:modul10/model/game.dart';
import 'package:modul10/viewmodel/fetchgame.dart';

// Widget untuk membuat tampilan setiap item game
Widget _listItem(String urlCover, String judul, String genre) {
  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      tileColor: Colors.blue.shade50,
      leading: SizedBox(
        width: 75,
        height: 75,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(urlCover, scale: 3, fit: BoxFit.cover),
        ),
      ),
      title: Text(judul),
      subtitle: Text(genre),
      trailing: const Icon(Icons.more_vert),
      isThreeLine: false,
      titleAlignment: ListTileTitleAlignment.center,
    ),
  );
}

// Fungsi untuk membuat Search Bar
Widget _searchBar() {
  return TextField(
    cursorColor: Colors.blue,
    decoration: InputDecoration(
      fillColor: Colors.blue.shade50,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      prefixIcon: const Icon(
        Icons.search_outlined,
        color: Colors.blue,
        size: 30,
      ),
      hintText: 'Cari game',
      hintStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.7)),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  // late Future<List<Game>> gameList; // Variabel ini tidak digunakan jika FutureBuilder langsung memanggil loadGames()

  @override
  void initState() {
    super.initState();
    // gameList = loadGames(); // Jika menggunakan FutureBuilder yang memanggil fungsi secara langsung, baris ini tidak perlu
  }

  Future<List<Game>> loadGames() async {
    return fetchGames(); // Mengambil data game dari API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              _searchBar(), // Kolom pencarian
              const SizedBox(height: 10),
              FutureBuilder<List<Game>>(
                future: loadGames(), // Memanggil API secara asinkron
                builder: (context, snapshot) {
                  // State Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  // State Error
                  else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  // State Data Tersedia
                  else if (snapshot.hasData) {
                    final games = snapshot.data!.take(25).toList();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: games.length,
                        itemBuilder: (context, index) {
                          final game = games[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigasi ke halaman detail dan mengirim ID game
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: game.id,
                              );
                            },
                            child: _listItem(
                              game.thumbnail,
                              game.title,
                              game.genre,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  // State Lain (misal data kosong)
                  else {
                    return const Text('Tidak ada data game.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
