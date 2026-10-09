import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/dummy_data.dart';

class ReturnForm extends StatefulWidget {
  const ReturnForm({super.key});

  @override
  State<ReturnForm> createState() => _ReturnFormState();
}

class _ReturnFormState extends State<ReturnForm> {
  final _nomorController = TextEditingController();
  Map<String, dynamic>? _loanData;

  void _search() {
    final nomor = _nomorController.text.trim();
    if (nomor.isEmpty) {
      _showMessage('Masukkan nomor induk!', AppTheme.warningYellow);
      return;
    }

    final loan = DummyData.loans.firstWhere(
      (l) => l.nomorInduk == nomor && l.status == 'dipinjam',
      orElse: () => DummyData.loans[0],
    );

    if (loan.nomorInduk != nomor || loan.status != 'dipinjam') {
      setState(() => _loanData = null);
      _showMessage('Buku tidak sedang dipinjam!', AppTheme.dangerRed);
      return;
    }

    final hariTerlambat = DateTime.now().difference(loan.tanggalJatuhTempo).inDays;
    final denda = hariTerlambat > 0 ? hariTerlambat * 1000 : 0;

    setState(() {
      _loanData = {
        'kode': loan.kodePinjam,
        'nama': loan.namaSiswa,
        'nis': loan.nisSiswa,
        'judul': loan.judulBuku,
        'pinjam': loan.tanggalPinjam,
        'jatuhTempo': loan.tanggalJatuhTempo,
        'terlambat': hariTerlambat > 0 ? hariTerlambat : 0,
        'denda': denda,
      };
    });
  }

  void _proses() {
    if (_loanData == null) return;
    _showMessage('Buku berhasil dikembalikan!', AppTheme.primaryGreen);
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
        title: const Text('Pengembalian Buku'),
        backgroundColor: AppTheme.primaryGreen,
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
                // SCAN
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryGreen, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.qr_code_scanner, color: AppTheme.primaryGreen),
                          SizedBox(width: 8),
                          Text('Scan Barcode Buku', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
                            onPressed: _search,
                            child: const Text('Cari'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // DETAIL
                if (_loanData != null) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        _row('Kode Peminjaman', _loanData!['kode']),
                        _row('Nama Siswa', _loanData!['nama']),
                        _row('NIS', _loanData!['nis']),
                        _row('Judul Buku', _loanData!['judul']),
                        _row('Tanggal Pinjam', '${_loanData!['pinjam'].day}/${_loanData!['pinjam'].month}/${_loanData!['pinjam'].year}'),
                        _row('Jatuh Tempo', '${_loanData!['jatuhTempo'].day}/${_loanData!['jatuhTempo'].month}/${_loanData!['jatuhTempo'].year}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // DENDA
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _loanData!['denda'] > 0 ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _loanData!['denda'] > 0 ? Icons.warning : Icons.check_circle,
                          color: _loanData!['denda'] > 0 ? AppTheme.dangerRed : AppTheme.primaryGreen,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _loanData!['denda'] > 0 ? '⚠️ Terlambat ${_loanData!['terlambat']} hari' : '✅ Tidak ada denda',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _loanData!['denda'] > 0 ? AppTheme.dangerRed : AppTheme.primaryGreen,
                                ),
                              ),
                              if (_loanData!['denda'] > 0)
                                Text('Denda: Rp ${_loanData!['denda']}', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
                      onPressed: _proses,
                      icon: const Icon(Icons.check),
                      label: const Text('Proses Pengembalian', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13))),
          const Text(': '),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}