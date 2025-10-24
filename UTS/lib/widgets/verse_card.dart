// lib/widgets/verse_card.dart
import 'package:flutter/material.dart';
import '../models/verse_model.dart';

class VerseCard extends StatelessWidget {
  final VerseModel verse;

  const VerseCard({Key? key, required this.verse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFDF7F2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${verse.surah} : ${verse.ayah}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    )),
                Text('Juz ${verse.juz}',
                    style:
                        const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              verse.arabic,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'ScheherazadeNew', // kalau punya font arabic
                height: 1.8,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              verse.translation,
              style: const TextStyle(fontSize: 14.5),
            ),
            const SizedBox(height: 8),
            Text(
              'Tafsir: ${verse.tafsir}',
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
