import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import 'admin_books.dart';
import 'admin_categories.dart';
import 'admin_students.dart';
import 'admin_loans.dart';
import 'admin_reports.dart';
import 'admin_backup.dart';
import 'return_form.dart';

class AdminReturns extends StatelessWidget {
  const AdminReturns({super.key});

  void _goTo(BuildContext context, int index, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

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
              SidebarItem(icon: Icons.menu_book, label: 'Data Buku', onTap: () => _goTo(context, 1, const AdminBooks())),
              SidebarItem(icon: Icons.category, label: 'Kategori', onTap: () => _goTo(context, 2, const AdminCategories())),
              SidebarItem(icon: Icons.people, label: 'Data Siswa', onTap: () => _goTo(context, 3, const AdminStudents())),
              SidebarItem(icon: Icons.upload, label: 'Peminjaman', onTap: () => _goTo(context, 4, const AdminLoans())),
              SidebarItem(icon: Icons.download, label: 'Pengembalian', onTap: () {}),
              SidebarItem(icon: Icons.bar_chart, label: 'Laporan', onTap: () => _goTo(context, 6, const AdminReports())),
              SidebarItem(icon: Icons.save, label: 'Backup', onTap: () => _goTo(context, 7, const AdminBackup())),
              SidebarItem(icon: Icons.logout, label: 'Logout', onTap: () => Navigator.pop(context)),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pengembalian Buku', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Container(
                    width: 700,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.assignment_return, size: 64, color: AppTheme.primaryGreen),
                        const SizedBox(height: 16),
                        const Text('Form Pengembalian Buku', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text(
                          'Scan barcode buku untuk memproses pengembalian. Sistem otomatis menghitung denda jika terlambat.',
                          style: TextStyle(color: AppTheme.textMuted),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const ReturnForm()));
                            },
                            icon: const Icon(Icons.qr_code_scanner),
                            label: const Text('Buka Form Pengembalian', style: TextStyle(fontSize: 16)),
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