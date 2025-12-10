// lib/screens/home_page.dart (MODIFIKASI)

import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import ApiService
import '../models/theme_model.dart';
import '../widgets/theme_card.dart';
import 'package:http/http.dart' as http; // Import http client

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Inisialisasi Service
  final ApiService _apiService = ApiService(client: http.Client());

  // Future dan Data State
  late Future<List<ThemeModel>> _themesFuture;
  List<ThemeModel> _allThemes = [];
  List<ThemeModel> _filteredThemes = [];
  final TextEditingController _searchC = TextEditingController();

  // Animation State
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  // Error Message State
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    // Panggil API di initState
    _themesFuture = _fetchThemes();
    _searchC.addListener(_onSearch);
  }

  // Fungsi pengambilan data API
  Future<List<ThemeModel>> _fetchThemes() async {
    try {
      final themes = await _apiService.getThemes(); // Panggil Service Layer
      _allThemes = themes;
      _filteredThemes = List.from(themes);
      _errorMessage = '';
      if (_allThemes.isNotEmpty) _animController.forward(from: 0.0);
      return _filteredThemes;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _allThemes = [];
      _filteredThemes = [];
      rethrow;
    }
  }

  // Fungsi Pencarian/Filter (menggunakan data lokal yang sudah didapat)
  void _onSearch() {
    final q = _searchC.text.toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filteredThemes = List.from(_allThemes);
      } else {
        // Melakukan filter di sisi klien
        _filteredThemes = _allThemes
            .where((t) =>
                t.name.toLowerCase().contains(q) ||
                t.description.toLowerCase().contains(q))
            .toList();
      }
      if (_filteredThemes.isNotEmpty) _animController.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    _searchC.removeListener(_onSearch);
    _searchC.dispose();
    _animController.dispose();
    super.dispose();
  }

  // Implementasi Asynchronous UI (Loading, Error, Success, Empty)
  Widget _buildBody() {
    return FutureBuilder<List<ThemeModel>>(
      future: _themesFuture,
      builder: (context, snapshot) {
        // 1. Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(), // Indikator Loading
                SizedBox(height: 16),
                Text('Memuat tema dari server...',
                    style: TextStyle(color: Colors.black54, fontSize: 14)),
              ],
            ),
          );
        }

        // 2. Error State (Termasuk koneksi terputus)
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_off, size: 64, color: Colors.red.shade300),
                const SizedBox(height: 16),
                Text(
                  'Gagal memuat data!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Coba muat ulang data
                    setState(() {
                      _themesFuture = _fetchThemes();
                      _searchC.clear();
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        // Ambil data yang sudah di-filter (Success/Search State)
        final listToShow = _filteredThemes;

        // 3a. Data Empty State (Hasil Pencarian Kosong)
        if (listToShow.isEmpty && _searchC.text.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                const Text(
                  'Tema tidak ditemukan',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text('Coba kata kunci lain',
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade500)),
              ],
            ),
          );
        }

        // 3b. Data Empty State (API mengembalikan data kosong)
        if (listToShow.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.category_outlined,
                    size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                const Text(
                  'Tidak ada tema tersedia',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }

        // 4. Success State (Menampilkan Daftar Tema)
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: listToShow.length,
            itemBuilder: (context, i) {
              final t = listToShow[i];
              return ThemeCard(
                theme: t,
                onTap: () =>
                    Navigator.pushNamed(context, '/theme-detail', arguments: t),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ... (kode build method dan UI tetap sama)
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Tafsir Tematik',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.3),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            tooltip: 'Pengaturan',
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // Bagian Pencarian (tetap sama)
          Container(
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cari tema Al-Quran',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchC,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                      hintText: 'Misal: rezeki, sabar, akhlak',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: theme.primaryColor.withOpacity(0.3),
                            width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      suffixIcon: _searchC.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear,
                                  color: Colors.grey.shade600, size: 20),
                              onPressed: () {
                                _searchC.clear();
                                FocusScope.of(context).unfocus();
                              },
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Header "Tema Populer" / "Hasil Pencarian"
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, size: 20, color: theme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  _searchC.text.isEmpty ? 'Tema Populer' : 'Hasil Pencarian',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const Spacer(),
                // Tampilkan jumlah tema yang ter-filter
                if (_filteredThemes.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_filteredThemes.length} tema',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Expanded Body dengan FutureBuilder
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }
}
