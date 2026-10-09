import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import 'siswa_catalog.dart';
import 'siswa_history.dart';
import 'siswa_profile.dart';

class SiswaDashboard extends StatefulWidget {
  const SiswaDashboard({super.key});

  @override
  State<SiswaDashboard> createState() => _SiswaDashboardState();
}

class _SiswaDashboardState extends State<SiswaDashboard> {
  int _selected = 0;

  void _goTo(int index, Widget page) {
    setState(() => _selected = index);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: _selected,
            color: AppTheme.sidebarGreen,
            userName: 'Ghozi Mumtaza',
            userNis: '2024001',
            roleLabel: 'SISWA PANEL',
            items: [
              SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () {}),
              SidebarItem(icon: Icons.menu_book, label: 'Katalog Buku', onTap: () => _goTo(1, const SiswaCatalog())),
              SidebarItem(icon: Icons.history, label: 'Riwayat Saya', onTap: () => _goTo(2, const SiswaHistory())),
              SidebarItem(icon: Icons.person, label: 'Profil', onTap: () => _goTo(3, const SiswaProfile())),
              SidebarItem(icon: Icons.logout, label: 'Logout', onTap: () => Navigator.pop(context)),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: Row(
                    children: const [
                      Text('Dashboard Siswa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Spacer(),
                      CircleAvatar(backgroundColor: AppTheme.primaryGreen, child: Text('G', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [AppTheme.primaryGreen, AppTheme.sidebarGreen]),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Halo, Ghozi! 👋', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text('Temukan buku favoritmu di sini.', style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text('Menu Cepat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: _quickCard(Icons.menu_book, 'Katalog Buku', 'Lihat semua buku', () => _goTo(1, const SiswaCatalog()))),
                            const SizedBox(width: 16),
                            Expanded(child: _quickCard(Icons.history, 'Riwayat Saya', 'Cek peminjaman', () => _goTo(2, const SiswaHistory()))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickCard(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppTheme.primaryGreen.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: AppTheme.primaryGreen),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}