// lib/screens/settings_page.dart
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _dark = false;
  double _fontSize = 16;
  String _lang = 'Indonesia';

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.3),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _buildSectionHeader('Tampilan', Icons.palette_outlined),
          _buildSettingCard(
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              title: const Text(
                'Mode Gelap',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              subtitle: Text(
                'Aktifkan tema gelap',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _dark ? Icons.dark_mode : Icons.light_mode,
                  color: theme.primaryColor,
                  size: 22,
                ),
              ),
              value: _dark,
              activeColor: theme.primaryColor,
              onChanged: (v) => setState(() => _dark = v),
            ),
          ),
          const SizedBox(height: 4),
          _buildSettingCard(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.text_fields, color: theme.primaryColor, size: 22),
              ),
              title: const Text(
                'Ukuran Font',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'Ukuran: ${_fontSize.toInt()}',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: theme.primaryColor,
                      inactiveTrackColor: theme.primaryColor.withOpacity(0.2),
                      thumbColor: theme.primaryColor,
                      overlayColor: theme.primaryColor.withOpacity(0.2),
                      valueIndicatorColor: theme.primaryColor,
                    ),
                    child: Slider(
                      min: 12,
                      max: 24,
                      divisions: 12,
                      value: _fontSize,
                      label: _fontSize.toInt().toString(),
                      onChanged: (v) => setState(() => _fontSize = v),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildSectionHeader('Bahasa & Wilayah', Icons.language_outlined),
          _buildSettingCard(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.translate, color: theme.primaryColor, size: 22),
              ),
              title: const Text(
                'Bahasa',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              subtitle: Text(
                _lang,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
              onTap: () async {
                final selected = await showDialog<String>(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text(
                      'Pilih Bahasa',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLanguageOption(context, 'Indonesia', _lang == 'Indonesia'),
                        _buildLanguageOption(context, 'English', _lang == 'English'),
                      ],
                    ),
                  ),
                );
                if (selected != null) setState(() => _lang = selected);
              },
            ),
          ),
          _buildSectionHeader('Data & Penyimpanan', Icons.storage_outlined),
          _buildSettingCard(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
              ),
              title: const Text(
                'Hapus Data Lokal',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              subtitle: Text(
                'Hapus cache dan data tersimpan',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
              onTap: () {
                showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Konfirmasi',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ],
                    ),
                    content: const Text(
                      'Apakah Anda yakin ingin menghapus semua data lokal? Tindakan ini tidak dapat dibatalkan.',
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          'Batal',
                          style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Hapus', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('Data lokal berhasil dihapus'),
                          ],
                        ),
                        backgroundColor: Colors.green.shade600,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  }
                });
              },
            ),
          ),
          _buildSectionHeader('Akun', Icons.person_outline),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text(
                      'Keluar dari Akun',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    content: const Text(
                      'Apakah Anda yakin ingin keluar?',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          'Batal',
                          style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Keluar', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed ?? false) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                });
              },
              icon: const Icon(Icons.logout, size: 20),
              label: const Text(
                'Keluar dari Akun',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 2,
                shadowColor: theme.primaryColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Versi 1.0.0',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String lang, bool selected) {
    return InkWell(
      onTap: () => Navigator.pop(context, lang),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: selected ? Theme.of(context).primaryColor : Colors.grey.shade400,
              size: 22,
            ),
            const SizedBox(width: 16),
            Text(
              lang,
              style: TextStyle(
                fontSize: 15,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? Theme.of(context).primaryColor : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}