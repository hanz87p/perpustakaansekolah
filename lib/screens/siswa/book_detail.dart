import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/book.dart';

class BookDetail extends StatelessWidget {
  final Book book;
  const BookDetail({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover
                Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.menu_book, size: 80, color: Colors.white),
                ),
                const SizedBox(width: 32),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.judul, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('oleh ${book.penulis}', style: const TextStyle(color: AppTheme.textMuted, fontSize: 16)),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: book.stok > 0 ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          book.stok > 0 ? '✅ Tersedia (${book.stok} buku)' : '❌ Stok Habis',
                          style: TextStyle(
                            color: book.stok > 0 ? Colors.green[700] : Colors.red[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      _row('Nomor Induk', book.nomorInduk, isMono: true),
                      _row('Penerbit', book.penerbit),
                      _row('Tahun Terbit', '${book.tahunTerbit}'),
                      _row('Kategori', book.kategori),
                      _row('Rak', book.rak),
                      const Divider(),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBEAFE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.info, color: AppTheme.primaryBlue),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Cara Peminjaman: Datang ke perpustakaan, tunjukkan Kartu Pelajar atau sebutkan NIS ke petugas.',
                                style: TextStyle(fontSize: 13, color: AppTheme.textDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isMono = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(label, style: const TextStyle(color: AppTheme.textMuted))),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: isMono ? 'monospace' : null,
                color: isMono ? AppTheme.primaryBlue : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}