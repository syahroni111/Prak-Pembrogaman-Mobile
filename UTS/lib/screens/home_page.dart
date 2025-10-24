// lib/screens/home_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/theme_model.dart';
import '../widgets/theme_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ThemeModel> _themes = [];
  List<ThemeModel> _filtered = [];
  final TextEditingController _searchC = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchC.addListener(_onSearch);
  }

  Future<void> _loadData() async {
    try {
      final raw = await rootBundle.loadString('assets/db.json');
      final json = jsonDecode(raw);
      final list = (json['themes'] as List<dynamic>);
      _themes = list
          .map((e) => ThemeModel.fromJson(e as Map<String, dynamic>))
          .toList();
      _filtered = List.from(_themes);
    } catch (e) {
      // fallback: empty list
      _themes = [];
      _filtered = [];
      debugPrint('Load db error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onSearch() {
    final q = _searchC.text.toLowerCase();
    setState(() {
      if (q.isEmpty)
        _filtered = List.from(_themes);
      else
        _filtered = _themes
            .where((t) =>
                t.name.toLowerCase().contains(q) ||
                t.description.toLowerCase().contains(q))
            .toList();
    });
  }

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_filtered.isEmpty)
      return const Center(child: Text('Tema tidak ditemukan'));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _filtered.length,
      itemBuilder: (context, i) {
        final t = _filtered[i];
        return ThemeCard(
          theme: t,
          onTap: () =>
              Navigator.pushNamed(context, '/theme-detail', arguments: t),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tafsir Tematik'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Cari tema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchC,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Misal: rezeki, sabar, akhlak',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(height: 16),
          const Text('Tema Populer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Expanded(child: _buildBody()),
        ]),
      ),
    );
  }
}
