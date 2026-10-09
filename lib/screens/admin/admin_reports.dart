import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import '../../data/dummy_data.dart';

class AdminReports extends StatelessWidget {
  const AdminReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: 5,
            color: AppTheme.sidebarBlue,
            userName: 'Admin Perpustakaan',
            userNis: '198501012010011001',
            roleLabel: 'ADMIN PANEL',
            items: [
              SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () => Navigator.pop(context)),
              SidebarItem(icon: Icons.menu_book, label: 'Data Buku', onTap: () {}),
              SidebarItem(icon: Icons.people, label: 'Data Siswa', onTap: () {}),
              SidebarItem(icon: Icons.upload, label: 'Peminjaman', onTap: () {}),
              SidebarItem(icon: Icons.download, label: 'Pengembalian', onTap: () {}),
              SidebarItem(icon: Icons.bar_chart, label: 'Laporan', onTap: () {}),
              SidebarItem(icon: Icons.logout, label: 'Logout', onTap: () => Navigator.pop(context)),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Laporan Transaksi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerRed),
                        onPressed: () {},
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text('Cetak PDF'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
                        onPressed: () {},
                        icon: const Icon(Icons.file_download),
                        label: const Text('Export Excel'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Kode')),
                            DataColumn(label: Text('Siswa')),
                            DataColumn(label: Text('Buku')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Denda')),
                          ],
                          rows: List.generate(DummyData.loans.length, (i) {
                            final l = DummyData.loans[i];
                            return DataRow(cells: [
                              DataCell(Text('${i + 1}')),
                              DataCell(Text(l.kodePinjam, style: const TextStyle(fontSize: 11, fontFamily: 'monospace'))),
                              DataCell(Text(l.namaSiswa)),
                              DataCell(Text(l.judulBuku)),
                              DataCell(Text(l.status)),
                              DataCell(Text('Rp ${l.denda}')),
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
    );
  }
}