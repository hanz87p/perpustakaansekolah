import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sidebar.dart';
import '../../widgets/stat_card.dart';
import 'admin_books.dart';
import 'admin_categories.dart';
import 'admin_students.dart';
import 'admin_loans.dart';
import 'admin_returns.dart';
import 'admin_reports.dart';
import 'admin_backup.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selected = 0;

  void _goTo(int index, Widget page) {
    setState(() => _selected = index);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: _selected,
            color: AppTheme.sidebarBlue,
            userName: 'Admin Perpustakaan',
            userNis: '198501012010011001',
            roleLabel: 'ADMIN PANEL',
            items: [
              SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () {}),
              SidebarItem(icon: Icons.menu_book, label: 'Data Buku', onTap: () => _goTo(1, const AdminBooks())),
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
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Selamat datang, Admin! 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Ringkasan aktivitas perpustakaan hari ini.', style: TextStyle(color: Colors.grey[600])),
                        const SizedBox(height: 24),
                        GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 2.2,
                          children: const [
                            StatCard(icon: Icons.menu_book, label: 'Total Buku', value: '10', subtitle: '46 stok', color: AppTheme.primaryBlue),
                            StatCard(icon: Icons.access_time, label: 'Dipinjam', value: '2', subtitle: 'Transaksi aktif', color: AppTheme.warningYellow),
                            StatCard(icon: Icons.warning, label: 'Terlambat', value: '1', subtitle: 'Perlu ditindak', color: AppTheme.dangerRed),
                            StatCard(icon: Icons.people, label: 'Total Siswa', value: '5', subtitle: 'Anggota aktif', color: Colors.purple),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('📊 Grafik Peminjaman', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 20),
                              Text('Grafik akan ditampilkan di sini.', style: TextStyle(color: Colors.grey)),
                            ],
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: const [
          Text('Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.notifications_outlined, color: Colors.grey),
          SizedBox(width: 16),
          CircleAvatar(backgroundColor: AppTheme.primaryBlue, child: Text('A', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}