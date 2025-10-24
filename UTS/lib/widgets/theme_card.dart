// lib/widgets/theme_card.dart
import 'package:flutter/material.dart';
import '../models/theme_model.dart';

class ThemeCard extends StatelessWidget {
  final ThemeModel theme;
  final VoidCallback onTap;

  const ThemeCard({
    Key? key,
    required this.theme,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              const Icon(Icons.menu_book, color: Colors.brown, size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      theme.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      theme.description,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.brown),
            ],
          ),
        ),
      ),
    );
  }
}
