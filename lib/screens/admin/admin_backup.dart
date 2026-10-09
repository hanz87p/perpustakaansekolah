import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';

class AdminBackup extends StatefulWidget {
  const AdminBackup({super.key});

  @override
  State<AdminBackup> createState() => _AdminBackupState();
}

class _AdminBackupState extends State<AdminBackup> {
  final List<Map<String, dynamic>> _backups = [
    {'nama': 'pustakara-backup-20260101.sql', 'ukuran': '245 KB', 'tanggal': '01 Jan 2026 10:30', 'status': 'sukses'},
    {'nama': 'pustakara-backup-20251215.sql', 'ukuran': '240 KB', 'tanggal': '15 Des 2025 14:20', 'status': 'sukses'},
  ];

  void _backup() {
    setState(() {
      _backups.insert(0, {
        'nama': 'pustakara-backup-${DateTime.now().millisecondsSinceEpoch}.sql',
        'ukuran': '250 KB',
        'tanggal': '${DateTime.now().day} ${_bulan(DateTime.now().month)} ${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}',
        'status': 'sukses',
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Backup berhasil!'), backgroundColor: AppTheme.primaryGreen),
    );
  }

  String _bulan(int m) => ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'][m - 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: 6,
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
              SidebarItem(icon: Icons.save, label: 'Backup', onTap: () {}),
              SidebarItem(icon: Icons.logout, label: 'Logout', onTap: () => Navigator.pop(context)),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Backup Database', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),

                  // Card Backup
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('💾 Backup Database', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              const Text('Backup seluruh data aplikasi untuk mengantisipasi kehilangan data.', style: TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                              if (_backups.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text('Backup terakhir: ${_backups.first['tanggal']}', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                              ],
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.warningYellow),
                          onPressed: _backup,
                          icon: const Icon(Icons.save),
                          label: const Text('Backup Sekarang'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Riwayat
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('Riwayat Backup', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        const Divider(height: 1),
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Nama File')),
                            DataColumn(label: Text('Ukuran')),
                            DataColumn(label: Text('Tanggal')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Aksi')),
                          ],
                          rows: _backups.map((b) => DataRow(cells: [
                            DataCell(Text(b['nama'], style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
                            DataCell(Text(b['ukuran'])),
                            DataCell(Text(b['tanggal'])),
                            DataCell(Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(20)),
                              child: const Text('Sukses', style: TextStyle(color: Colors.green, fontSize: 11)),
                            )),
                            DataCell(Row(
                              children: [
                                TextButton(onPressed: () {}, child: const Text('Download')),
                                TextButton(
                                  onPressed: () => setState(() => _backups.remove(b)),
                                  child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            )),
                          ])).toList(),
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