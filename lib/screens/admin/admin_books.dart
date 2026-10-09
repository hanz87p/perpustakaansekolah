import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import '../../data/dummy_data.dart';
import 'admin_categories.dart';
import 'admin_students.dart';
import 'admin_loans.dart';
import 'admin_returns.dart';
import 'admin_reports.dart';
import 'admin_backup.dart';
import 'book_form.dart';

class AdminBooks extends StatefulWidget {
  const AdminBooks({super.key});

  @override
  State<AdminBooks> createState() => _AdminBooksState();
}

class _AdminBooksState extends State<AdminBooks> {
  String _search = '';

  void _goTo(int index, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final books = DummyData.books.where((b) =>
      b.judul.toLowerCase().contains(_search.toLowerCase()) ||
      b.nomorInduk.toLowerCase().contains(_search.toLowerCase())
    ).toList();

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
              SidebarItem(icon: Icons.category, label: 'Kategori', onTap: () => _goTo(2, const AdminCategories())),
              SidebarItem(icon: Icons.people, label: 'Data Siswa', onTap: () => _goTo(3, const AdminStudents())),
              SidebarItem(icon: Icons.upload, label: 'Peminjaman', onTap: () => _goTo(4, const AdminLoans())),
              SidebarItem(icon: Icons.download, label: 'Pengembalian', onTap: () => _goTo(5, const AdminReturns())),
              SidebarItem(icon: Icons.bar_chart, label: 'Laporan', onTap: () => _goTo(6, const AdminReports())),
              SidebarItem(icon: Icons.save, label: 'Backup', onTap: () => _goTo(7, const AdminBackup())),
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
                      const Text('Data Buku', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const BookForm()));
                          if (result == true && mounted) setState(() {});
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah Buku'),
                      ),
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
                            hintText: 'Cari nomor induk / judul...',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: SingleChildScrollView(
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('No')),
                                  DataColumn(label: Text('Nomor Induk')),
                                  DataColumn(label: Text('Judul')),
                                  DataColumn(label: Text('Penulis')),
                                  DataColumn(label: Text('Kategori')),
                                  DataColumn(label: Text('Stok')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Aksi')),
                                ],
                                rows: List.generate(books.length, (i) {
                                  final b = books[i];
                                  return DataRow(cells: [
                                    DataCell(Text('${i + 1}')),
                                    DataCell(Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(color: const Color(0xFFDBEAFE), borderRadius: BorderRadius.circular(4)),
                                      child: Text(b.nomorInduk, style: const TextStyle(color: AppTheme.primaryBlue, fontSize: 12, fontFamily: 'monospace')),
                                    )),
                                    DataCell(Text(b.judul, style: const TextStyle(fontWeight: FontWeight.w600))),
                                    DataCell(Text(b.penulis)),
                                    DataCell(Text(b.kategori)),
                                    DataCell(Text('${b.stok}', textAlign: TextAlign.center)),
                                    DataCell(Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: b.stok > 0 ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(b.stok > 0 ? 'Tersedia' : 'Habis', style: TextStyle(color: b.stok > 0 ? Colors.green[700] : Colors.red[700], fontSize: 11)),
                                    )),
                                    DataCell(Row(children: [
                                      TextButton(
                                        onPressed: () async {
                                          final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => BookForm(book: b)));
                                          if (result == true && mounted) setState(() {});
                                        },
                                        child: const Text('Edit'),
                                      ),
                                      TextButton(onPressed: () {}, child: const Text('Hapus', style: TextStyle(color: Colors.red))),
                                    ])),
                                  ]);
                                }),
                              ),
                            ),
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