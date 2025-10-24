// lib/screens/login_page.dart
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  bool _loading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() => _loading = false);
    // simple mock auth — go to home
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FlutterLogo(size: 96),
                  const SizedBox(height: 20),
                  const Text('Tafsir Tematik', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Masuk untuk mengakses fitur aplikasi', textAlign: TextAlign.center),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _emailC,
                    decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => (v == null || v.isEmpty) ? 'Email wajib diisi' : null,
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _passC,
                    decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                    obscureText: true,
                    validator: (v) => (v == null || v.length < 4) ? 'Password minimal 4 karakter' : null,
                  ),
                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _login,
                      child: _loading ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Login'),
                    ),
                  ),

                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    child: const Text('Masuk sebagai tamu'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
