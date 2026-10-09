import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';

class AdminStudents extends StatelessWidget {
  const AdminStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final students = [
      {'nis': '2024001', 'nama': 'Ghozi Mumtaza Hanif', 'kelas': 'XII RPL C', 'hp': '081234567001'},
      {'nis': '2024002', 'nama': 'Budi Santoso', 'kelas': 'XII RPL C', 'hp': '081234567002'},
      {'nis': '2024003', 'nama': 'Siti Aminah', 'kelas': 'XI RPL A', 'hp': '081234567003'},
      {'nis': '2024004', 'nama': 'Andi Wijaya', 'kelas': 'XI RPL B', 'hp': '081234567004'},
      {'nis': '2024005', 'nama': 'Dewi Lestari', 'kelas': 'X RPL A', 'hp': '081234567005'},
    ];

    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: 2,
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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Text('Data Siswa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Tambah Siswa')),
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
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('NIS')),
                            DataColumn(label: Text('Nama')),
                            DataColumn(label: Text('Kelas')),
                            DataColumn(label: Text('No HP')),
                            DataColumn(label: Text('Aksi')),
                          ],
                          rows: List.generate(students.length, (i) {
                            final s = students[i];
                            return DataRow(cells: [
                              DataCell(Text('${i + 1}')),
                              DataCell(Text(s['nis']!, style: const TextStyle(color: AppTheme.primaryBlue, fontFamily: 'monospace'))),
                              DataCell(Text(s['nama']!, style: const TextStyle(fontWeight: FontWeight.w600))),
                              DataCell(Text(s['kelas']!)),
                              DataCell(Text(s['hp']!)),
                              DataCell(Row(children: [
                                TextButton(onPressed: () {}, child: const Text('Edit')),
                                TextButton(onPressed: () {}, child: const Text('Hapus', style: TextStyle(color: Colors.red))),
                              ])),
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