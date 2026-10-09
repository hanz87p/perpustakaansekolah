import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';

class AdminCategories extends StatefulWidget {
  const AdminCategories({super.key});

  @override
  State<AdminCategories> createState() => _AdminCategoriesState();
}

class _AdminCategoriesState extends State<AdminCategories> {
  final List<Map<String, dynamic>> _categories = [
    {'id': 1, 'nama': 'Fiksi', 'jumlah': 2},
    {'id': 2, 'nama': 'Non-Fiksi', 'jumlah': 2},
    {'id': 3, 'nama': 'Pelajaran', 'jumlah': 3},
    {'id': 4, 'nama': 'Komik', 'jumlah': 2},
    {'id': 5, 'nama': 'Novel', 'jumlah': 1},
  ];

  void _showForm({Map<String, dynamic>? category}) {
    final controller = TextEditingController(text: category?['nama'] ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(category == null ? 'Tambah Kategori' : 'Edit Kategori'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nama Kategori',
            hintText: 'Contoh: Fiksi, Pelajaran...',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final nama = controller.text.trim();
              if (nama.isEmpty) return;
              setState(() {
                if (category == null) {
                  _categories.add({'id': _categories.length + 1, 'nama': nama, 'jumlah': 0});
                } else {
                  category['nama'] = nama;
                }
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kategori "$nama" disimpan'), backgroundColor: AppTheme.primaryGreen),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _delete(Map<String, dynamic> cat) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Kategori?'),
        content: Text('Yakin hapus "${cat['nama']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerRed),
            onPressed: () {
              setState(() => _categories.remove(cat));
              Navigator.pop(ctx);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: 1,
            color: AppTheme.sidebarBlue,
            userName: 'Admin Perpustakaan',
            userNis: '198501012010011001',
            roleLabel: 'ADMIN PANEL',
            items: [
              SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () => Navigator.pop(context)),
              SidebarItem(icon: Icons.menu_book, label: 'Data Buku', onTap: () {}),
              SidebarItem(icon: Icons.category, label: 'Kategori', onTap: () {}),
              SidebarItem(icon: Icons.people, label: 'Data Siswa', onTap: () {}),
              SidebarItem(icon: Icons.upload, label: 'Peminjaman', onTap: () {}),
              SidebarItem(icon: Icons.download, label: 'Pengembalian', onTap: () {}),
              SidebarItem(icon: Icons.bar_chart, label: 'Laporan', onTap: () {}),
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
                    children: [
                      const Text('Kategori Buku', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () => _showForm(),
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah Kategori'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: ListView.separated(
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final c = _categories[i];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
                              child: Text('${i + 1}', style: const TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold)),
                            ),
                            title: Text(c['nama'], style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('${c['jumlah']} buku'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(icon: const Icon(Icons.edit, color: AppTheme.primaryBlue), onPressed: () => _showForm(category: c)),
                                IconButton(icon: const Icon(Icons.delete, color: AppTheme.dangerRed), onPressed: () => _delete(c)),
                              ],
                            ),
                          );
                        },
                      ),
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
}