import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/dummy_data.dart';

class LoanForm extends StatefulWidget {
  const LoanForm({super.key});

  @override
  State<LoanForm> createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {
  final _nomorController = TextEditingController();
  final _nisController = TextEditingController();
  String? _bookInfo;
  String? _siswaInfo;
  int? _bookId;

  final _siswaList = [
    {'nis': '2024001', 'nama': 'Ghozi Mumtaza Hanif'},
    {'nis': '2024002', 'nama': 'Budi Santoso'},
    {'nis': '2024003', 'nama': 'Siti Aminah'},
    {'nis': '2024004', 'nama': 'Andi Wijaya'},
    {'nis': '2024005', 'nama': 'Dewi Lestari'},
  ];

  void _searchBook() {
    final nomor = _nomorController.text.trim();
    final book = DummyData.books.firstWhere(
      (b) => b.nomorInduk == nomor,
      orElse: () => DummyData.books[0],
    );
    if (book.nomorInduk != nomor) {
      setState(() => _bookInfo = null);
      _showMessage('Buku tidak ditemukan!', AppTheme.dangerRed);
      return;
    }
    setState(() {
      _bookId = book.id;
      _bookInfo = '${book.judul} • ${book.penulis} • Stok: ${book.stok}';
    });
    _showMessage('Buku ditemukan!', AppTheme.primaryGreen);
  }

  void _proses() {
    if (_bookId == null) {
      _showMessage('Scan buku terlebih dahulu!', AppTheme.warningYellow);
      return;
    }
    if (_siswaInfo == null) {
      _showMessage('Pilih siswa terlebih dahulu!', AppTheme.warningYellow);
      return;
    }
    _showMessage('Peminjaman berhasil! Jatuh tempo 7 hari.', AppTheme.primaryGreen);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pop(context);
    });
  }

  void _showMessage(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color, behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peminjaman Baru'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            width: 700,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // SCAN BARCODE
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryBlue, width: 2, style: BorderStyle.solid),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.qr_code_scanner, color: AppTheme.primaryBlue),
                          SizedBox(width: 8),
                          Text('Scan Barcode / Input Nomor Induk', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nomorController,
                              decoration: const InputDecoration(hintText: 'BKU-001', filled: true, fillColor: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(onPressed: _searchBook, child: const Text('Cari')),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_bookInfo != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppTheme.primaryGreen),
                        const SizedBox(width: 12),
                        Expanded(child: Text(_bookInfo!, style: const TextStyle(fontWeight: FontWeight.w600))),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // INPUT SISWA
                const Text('Data Siswa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                TextField(
                  controller: _nisController,
                  onChanged: (v) {
                    final siswa = _siswaList.firstWhere(
                      (s) => s['nis'] == v || s['nama']!.toLowerCase().contains(v.toLowerCase()),
                      orElse: () => {'nis': '', 'nama': ''},
                    );
                    setState(() => _siswaInfo = siswa['nis']!.isEmpty ? null : '${siswa['nama']} (${siswa['nis']})');
                  },
                  decoration: const InputDecoration(hintText: 'Ketik NIS atau nama siswa...', prefixIcon: Icon(Icons.search)),
                ),
                if (_siswaInfo != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: AppTheme.primaryGreen),
                        const SizedBox(width: 8),
                        Text(_siswaInfo!, style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // TANGGAL
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(text: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                        decoration: const InputDecoration(labelText: 'Tanggal Pinjam', filled: true, fillColor: Color(0xFFF1F5F9)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(text: '${DateTime.now().add(const Duration(days: 7)).day}/${DateTime.now().add(const Duration(days: 7)).month}/${DateTime.now().add(const Duration(days: 7)).year}'),
                        decoration: const InputDecoration(labelText: 'Jatuh Tempo', filled: true, fillColor: Color(0xFFF1F5F9)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _proses,
                    icon: const Icon(Icons.upload),
                    label: const Text('Proses Peminjaman', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}