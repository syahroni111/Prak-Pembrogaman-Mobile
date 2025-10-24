// lib/screens/theme_detail_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/theme_model.dart';
import '../models/verse_model.dart';
import '../widgets/verse_card.dart';

class ThemeDetailPage extends StatefulWidget {
  final ThemeModel theme;
  const ThemeDetailPage({Key? key, required this.theme}) : super(key: key);
  static const routeName = '/theme-detail';

  @override
  State<ThemeDetailPage> createState() => _ThemeDetailPageState();
}

class _ThemeDetailPageState extends State<ThemeDetailPage> {
  List<VerseModel> _verses = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadVerses();
  }

  Future<void> _loadVerses() async {
    try {
      final raw = await rootBundle.loadString('assets/db.json');
      final json = jsonDecode(raw);
      final all = (json['verses'] as List<dynamic>);
      final list = all.where((e) {
        final v = e as Map<String, dynamic>;
        return (v['themeId']?.toString() ?? '') == widget.theme.id.toString();
      }).toList();
      _verses = list
          .map((e) => VerseModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Load verses error: $e');
      _verses = [];
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    return Scaffold(
      appBar: AppBar(title: Text('Tema: ${theme.name}')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(theme.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          const Text('Ayat terkait',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _verses.isEmpty
                    ? const Center(child: Text('Belum ada ayat untuk tema ini'))
                    : ListView.separated(
                        itemCount: _verses.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final v = _verses[index];
                          return VerseCard(verse: v);
                        },
                      ),
          ),
        ]),
      ),
    );
  }
}
