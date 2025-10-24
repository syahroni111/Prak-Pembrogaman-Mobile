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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        SwitchListTile(
          title: const Text('Mode Gelap'),
          value: _dark,
          onChanged: (v) => setState(() => _dark = v),
        ),
        ListTile(
          title: const Text('Bahasa'),
          subtitle: Text(_lang),
          onTap: () async {
            final selected = await showDialog<String>(
              context: context,
              builder: (_) =>
                  SimpleDialog(title: const Text('Pilih bahasa'), children: [
                SimpleDialogOption(
                    onPressed: () => Navigator.pop(context, 'Indonesia'),
                    child: const Text('Indonesia')),
                SimpleDialogOption(
                    onPressed: () => Navigator.pop(context, 'English'),
                    child: const Text('English')),
              ]),
            );
            if (selected != null) setState(() => _lang = selected);
          },
        ),
        ListTile(
          title: const Text('Ukuran font'),
          subtitle: Text('${_fontSize.toInt()}'),
          trailing: SizedBox(
              width: 160,
              child: Slider(
                  min: 12,
                  max: 24,
                  value: _fontSize,
                  onChanged: (v) => setState(() => _fontSize = v))),
        ),
        const SizedBox(height: 12),
        ListTile(
          leading: const Icon(Icons.delete_forever),
          title: const Text('Hapus data lokal (mock)'),
          onTap: () {
            showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Konfirmasi'),
                content: const Text('Hapus data lokal? (Mock)'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Batal')),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Hapus')),
                ],
              ),
            ).then((confirmed) {
              if (confirmed ?? false)
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data lokal dihapus (mock)')));
            });
          },
        ),
        const SizedBox(height: 18),
        ElevatedButton.icon(
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ]),
    );
  }
}
