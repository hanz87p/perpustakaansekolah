import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _lama = TextEditingController();
  final _baru = TextEditingController();
  final _konfirmasi = TextEditingController();
  bool _obscure1 = true, _obscure2 = true, _obscure3 = true;

  void _save() {
    if (_lama.text.isEmpty || _baru.text.isEmpty || _konfirmasi.text.isEmpty) {
      _msg('Semua field wajib diisi!', AppTheme.dangerRed);
      return;
    }
    if (_baru.text.length < 6) {
      _msg('Password minimal 6 karakter!', AppTheme.dangerRed);
      return;
    }
    if (_baru.text != _konfirmasi.text) {
      _msg('Konfirmasi tidak cocok!', AppTheme.dangerRed);
      return;
    }
    _msg('Password berhasil diubah!', AppTheme.primaryGreen);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pop(context);
    });
  }

  void _msg(String msg, Color c) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: c));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Password'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _lama,
                  obscureText: _obscure1,
                  decoration: InputDecoration(
                    labelText: 'Password Lama',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure1 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscure1 = !_obscure1),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _baru,
                  obscureText: _obscure2,
                  decoration: InputDecoration(
                    labelText: 'Password Baru',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure2 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscure2 = !_obscure2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _konfirmasi,
                  obscureText: _obscure3,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure3 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscure3 = !_obscure3),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save),
                    label: const Text('Ganti Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}