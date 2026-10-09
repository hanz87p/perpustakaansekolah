import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import 'siswa_catalog.dart';
import 'siswa_history.dart';

class SiswaProfile extends StatelessWidget {
  const SiswaProfile({super.key});

  void _goTo(BuildContext context, int index, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: 3,
            color: AppTheme.sidebarGreen,
            userName: 'Ghozi Mumtaza',
            userNis: '2024001',
            roleLabel: 'SISWA PANEL',
            items: [
              SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () => Navigator.pop(context)),
              SidebarItem(icon: Icons.menu_book, label: 'Katalog Buku', onTap: () => _goTo(context, 1, const SiswaCatalog())),
              SidebarItem(icon: Icons.history, label: 'Riwayat Saya', onTap: () => _goTo(context, 2, const SiswaHistory())),
              SidebarItem(icon: Icons.person, label: 'Profil', onTap: () {}),
              SidebarItem(icon: Icons.logout, label: 'Logout', onTap: () => Navigator.pop(context)),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Profil Saya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Container(
                    width: 600,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        const CircleAvatar(radius: 50, backgroundColor: AppTheme.primaryGreen, child: Text('G', style: TextStyle(fontSize: 40, color: Colors.white))),
                        const SizedBox(height: 16),
                        const Text('Ghozi Mumtaza Hanif', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const Text('NIS: 2024001', style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 24),
                        TextField(decoration: const InputDecoration(labelText: 'Nama Lengkap'), controller: TextEditingController(text: 'Ghozi Mumtaza Hanif')),
                        const SizedBox(height: 16),
                        TextField(decoration: const InputDecoration(labelText: 'Kelas'), controller: TextEditingController(text: 'XII RPL C')),
                        const SizedBox(height: 16),
                        TextField(decoration: const InputDecoration(labelText: 'No HP'), controller: TextEditingController(text: '081234567001')),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('✅ Profil disimpan!'), backgroundColor: AppTheme.primaryGreen),
                              );
                            },
                            child: const Text('Simpan Perubahan'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}