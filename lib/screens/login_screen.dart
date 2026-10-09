import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'admin/admin_dashboard.dart';
import 'siswa/siswa_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nisController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = 'siswa';
  bool _obscure = true;

  final Map<String, Map<String, String>> _users = {
    '198501012010011001': {'password': 'admin123', 'role': 'admin', 'name': 'Admin Perpustakaan'},
    '2024001': {'password': 'siswa123', 'role': 'siswa', 'name': 'Ghozi Mumtaza Hanif'},
    '2024002': {'password': 'siswa123', 'role': 'siswa', 'name': 'Budi Santoso'},
    '2024003': {'password': 'siswa123', 'role': 'siswa', 'name': 'Siti Aminah'},
    '2024004': {'password': 'siswa123', 'role': 'siswa', 'name': 'Andi Wijaya'},
    '2024005': {'password': 'siswa123', 'role': 'siswa', 'name': 'Dewi Lestari'},
  };

  void _login() {
    final nis = _nisController.text.trim();
    final pass = _passwordController.text.trim();

    if (nis.isEmpty || pass.isEmpty) {
      _showMessage('Isi NIS/NIP dan Password terlebih dahulu!', AppTheme.dangerRed);
      return;
    }

    if (!_users.containsKey(nis)) {
      _showMessage('NIS/NIP tidak terdaftar!', AppTheme.dangerRed);
      return;
    }

    final user = _users[nis]!;

    if (user['role'] != _role) {
      _showMessage('Role tidak sesuai! Akun ini adalah ${user['role']}.', AppTheme.warningYellow);
      return;
    }

    if (user['password'] != pass) {
      _showMessage('Password salah!', AppTheme.dangerRed);
      return;
    }

    _showMessage('Selamat datang, ${user['name']}!', AppTheme.primaryGreen);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      if (_role == 'admin') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SiswaDashboard()));
      }
    });
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  void dispose() {
    _nisController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2563EB), Color(0xFFF1F5F9)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 420,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 30, offset: const Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), shape: BoxShape.circle),
                      child: const Icon(Icons.menu_book, size: 48, color: AppTheme.primaryBlue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Pustakara', textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                  const SizedBox(height: 4),
                  const Text('Sistem Informasi Perpustakaan', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                  const SizedBox(height: 2),
                  const Text('SMK Negeri 5 Surakarta', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(child: _roleButton('Admin / Petugas', 'admin')),
                      const SizedBox(width: 8),
                      Expanded(child: _roleButton('Siswa', 'siswa')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _nisController,
                    decoration: InputDecoration(
                      labelText: 'NIS / NIP',
                      prefixIcon: const Icon(Icons.person_outline),
                      hintText: _role == 'admin' ? 'Masukkan NIP...' : 'Masukkan NIS...',
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    onSubmitted: (_) => _login(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: 'Masukkan password...',
                      suffixIcon: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (v) {}, activeColor: AppTheme.primaryBlue),
                      const Text('Ingat Saya', style: TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                      const Spacer(),
                      TextButton(onPressed: () {}, child: const Text('Lupa Password?', style: TextStyle(fontSize: 13, color: AppTheme.primaryBlue))),
                    ],
                  ),
                  const SizedBox(height: 8),

                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Masuk', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('💡 Akun Demo:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                        SizedBox(height: 4),
                        Text('Admin → 198501012010011001 / admin123', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                        Text('Siswa → 2024001 / siswa123', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text('© 2026 Pustakara — SMK Negeri 5 Surakarta', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleButton(String label, String value) {
    final isActive = _role == value;
    return GestureDetector(
      onTap: () => setState(() => _role = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryBlue : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: isActive ? Colors.white : AppTheme.textMuted, fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }
}