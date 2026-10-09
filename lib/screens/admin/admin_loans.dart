import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import '../../data/dummy_data.dart';
import 'admin_books.dart';
import 'admin_categories.dart';
import 'admin_students.dart';
import 'admin_returns.dart';
import 'admin_reports.dart';
import 'admin_backup.dart';
import 'loan_form.dart';

class AdminLoans extends StatelessWidget {
  const AdminLoans({super.key});

  void _goTo(BuildContext context, int index, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: 4,
            color: AppTheme.sidebarBlue,
            userName: 'Admin Perpustakaan',
            userNis: '198501012010011001',
            roleLabel: 'ADMIN PANEL',
            items: [
              SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () => Navigator.pop(context)),
              SidebarItem(icon: Icons.menu_book, label: 'Data Buku', onTap: () => _goTo(context, 1, const AdminBooks())),
              SidebarItem(icon: Icons.category, label: 'Kategori', onTap: () => _goTo(context, 2, const AdminCategories())),
              SidebarItem(icon: Icons.people, label: 'Data Siswa', onTap: () => _goTo(context, 3, const AdminStudents())),
              SidebarItem(icon: Icons.upload, label: 'Peminjaman', onTap: () {}),
              SidebarItem(icon: Icons.download, label: 'Pengembalian', onTap: () => _goTo(context, 5, const AdminReturns())),
              SidebarItem(icon: Icons.bar_chart, label: 'Laporan', onTap: () => _goTo(context, 6, const AdminReports())),
              SidebarItem(icon: Icons.save, label: 'Backup', onTap: () => _goTo(context, 7, const AdminBackup())),
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
                      const Text('Transaksi Peminjaman', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const LoanForm()));
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Peminjaman Baru'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Kode')),
                            DataColumn(label: Text('Siswa')),
                            DataColumn(label: Text('Buku')),
                            DataColumn(label: Text('Tgl Pinjam')),
                            DataColumn(label: Text('Jatuh Tempo')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: DummyData.loans.map((l) => DataRow(cells: [
                            DataCell(Text(l.kodePinjam, style: const TextStyle(fontSize: 11, fontFamily: 'monospace'))),
                            DataCell(Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(l.namaSiswa, style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text(l.nisSiswa, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            )),
                            DataCell(Text(l.judulBuku)),
                            DataCell(Text('${l.tanggalPinjam.day}/${l.tanggalPinjam.month}/${l.tanggalPinjam.year}')),
                            DataCell(Text('${l.tanggalJatuhTempo.day}/${l.tanggalJatuhTempo.month}/${l.tanggalJatuhTempo.year}')),
                            DataCell(Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: l.status == 'dikembalikan' ? const Color(0xFFD1FAE5) : const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(l.status, style: TextStyle(fontSize: 11, color: l.status == 'dikembalikan' ? Colors.green[700] : Colors.orange[700])),
                            )),
                          ])).toList(),
                        ),
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