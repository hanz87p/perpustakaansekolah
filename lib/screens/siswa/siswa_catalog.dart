import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import '../../data/dummy_data.dart';
import 'siswa_history.dart';
import 'siswa_profile.dart';
import 'book_detail.dart';

class SiswaCatalog extends StatefulWidget {
  const SiswaCatalog({super.key});

  @override
  State<SiswaCatalog> createState() => _SiswaCatalogState();
}

class _SiswaCatalogState extends State<SiswaCatalog> {
  String _search = '';

  void _goTo(int index, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final books = DummyData.books.where((b) =>
      b.judul.toLowerCase().contains(_search.toLowerCase())
    ).toList();

    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: 1,
            color: AppTheme.sidebarGreen,
            userName: 'Ghozi Mumtaza',
            userNis: '2024001',
            roleLabel: 'SISWA PANEL',
            items: [
              SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () => Navigator.pop(context)),
              SidebarItem(icon: Icons.menu_book, label: 'Katalog Buku', onTap: () {}),
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
                  child: const Row(
                    children: [
                      Text('Katalog Buku', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (v) => setState(() => _search = v),
                          decoration: const InputDecoration(
                            hintText: 'Cari judul buku...',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 220,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: books.length,
                            itemBuilder: (context, i) {
                              final b = books[i];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => BookDetail(book: b)),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE2E8F0),
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                          ),
                                          child: const Icon(Icons.menu_book, size: 60, color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              b.judul,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(b.penulis, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFD1FAE5),
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: Text('Stok: ${b.stok}', style: TextStyle(fontSize: 10, color: Colors.green[700])),
                                                ),
                                                Text(b.nomorInduk, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
}