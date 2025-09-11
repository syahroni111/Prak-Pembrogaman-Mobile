import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemutar Musik',
      theme: ThemeData.dark(), // gunakan tema gelap
      home: Scaffold(
        appBar: AppBar(title: Text('Pemutar Musik')),
        body: Center(child: Text('Musik DJ', style: TextStyle(fontSize: 30))),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          color: const Color.fromARGB(135, 77, 73, 73),
          child: Row(
            children: [
              // Tombol Shuffle
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.shuffle,
                    color: const Color.fromARGB(255, 255, 0, 0),
                  ),
                  onPressed: () {},
                ),
              ),
              // Tombol Previous
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    color: const Color.fromARGB(255, 255, 0, 0),
                  ),
                  onPressed: () {},
                ),
              ),
              // Tombol Play (lebih besar, pakai Flexible flex: 2)
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle_fill,
                    color: const Color.fromARGB(255, 255, 0, 0),
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ),
              // Tombol Next
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    color: const Color.fromARGB(255, 255, 0, 0),
                  ),
                  onPressed: () {},
                ),
              ),
              // Tombol Repeat
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.repeat,
                    color: const Color.fromARGB(255, 255, 0, 0),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
