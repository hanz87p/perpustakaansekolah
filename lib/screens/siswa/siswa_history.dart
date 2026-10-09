import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import '../../data/dummy_data.dart';
import 'siswa_catalog.dart';
import 'siswa_profile.dart';

class SiswaHistory extends StatelessWidget {
  const SiswaHistory({super.key});

  void _goTo(BuildContext context, int index, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final loans = DummyData.loans;

    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: 2,
            color: AppTheme.sidebarGreen,
            userName: 'Ghozi Mumtaza',
            userNis: '2024001',
            roleLabel: 'SISWA PANEL',
            items: [
              SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () => Navigator.pop(context)),
              SidebarItem(icon: Icons.menu_book, label: 'Katalog Buku', onTap: () => _goTo(context, 1, const SiswaCatalog())),
              SidebarItem(icon: Icons.history, label: 'Riwayat Saya', onTap: () {}),
              SidebarItem(icon: Icons.person, label: 'Profil', onTap: () => _goTo(context, 3, const SiswaProfile())),
              SidebarItem(icon: Icons.logout, label: 'Logout', onTap: () => Navigator.pop(context)),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: const Text('Riwayat Peminjaman Saya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Kode')),
                            DataColumn(label: Text('Judul Buku')),
                            DataColumn(label: Text('Tgl Pinjam')),
                            DataColumn(label: Text('Jatuh Tempo')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Denda')),
                          ],
                          rows: List.generate(loans.length, (i) {
                            final l = loans[i];
                            return DataRow(cells: [
                              DataCell(Text('${i + 1}')),
                              DataCell(Text(l.kodePinjam, style: const TextStyle(fontSize: 11, fontFamily: 'monospace'))),
                              DataCell(Text(l.judulBuku, style: const TextStyle(fontWeight: FontWeight.w600))),
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
                              DataCell(Text(l.denda > 0 ? 'Rp ${l.denda}' : '-')),
                            ]);
                          }),
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