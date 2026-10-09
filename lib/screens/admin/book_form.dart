import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/book.dart';

class BookForm extends StatefulWidget {
  final Book? book;
  const BookForm({super.key, this.book});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomor, _judul, _penulis, _penerbit, _tahun, _stok, _rak;
  String _kategori = 'Pelajaran';

  final _kategoriList = ['Fiksi', 'Non-Fiksi', 'Pelajaran', 'Komik', 'Novel'];

  @override
  void initState() {
    super.initState();
    final b = widget.book;
    _nomor = TextEditingController(text: b?.nomorInduk ?? '');
    _judul = TextEditingController(text: b?.judul ?? '');
    _penulis = TextEditingController(text: b?.penulis ?? '');
    _penerbit = TextEditingController(text: b?.penerbit ?? '');
    _tahun = TextEditingController(text: b?.tahunTerbit.toString() ?? '');
    _stok = TextEditingController(text: b?.stok.toString() ?? '1');
    _rak = TextEditingController(text: b?.rak ?? '');
    if (b != null) _kategori = b.kategori;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.book == null ? 'Buku berhasil ditambahkan!' : 'Buku berhasil diupdate!'),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Tambah Buku' : 'Edit Buku'),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: _field(_nomor, 'Nomor Induk', 'BKU-001', required: true)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _kategori,
                          decoration: const InputDecoration(labelText: 'Kategori'),
                          items: _kategoriList.map((k) => DropdownMenuItem(value: k, child: Text(k))).toList(),
                          onChanged: (v) => setState(() => _kategori = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _field(_judul, 'Judul Buku', 'Laskar Pelangi', required: true),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _field(_penulis, 'Penulis', 'Andrea Hirata', required: true)),
                      const SizedBox(width: 16),
                      Expanded(child: _field(_penerbit, 'Penerbit', 'Bentang Pustaka', required: true)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _field(_tahun, 'Tahun Terbit', '2020', keyboard: TextInputType.number)),
                      const SizedBox(width: 16),
                      Expanded(child: _field(_stok, 'Stok', '5', keyboard: TextInputType.number, required: true)),
                      const SizedBox(width: 16),
                      Expanded(child: _field(_rak, 'Rak', 'A-01')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: AppTheme.textMuted, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Upload cover akan tersedia setelah integrasi backend.',
                            style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(onPressed: _save, child: const Text('Simpan')),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label, String hint, {bool required = false, TextInputType? keyboard}) {
    return TextFormField(
      controller: c,
      keyboardType: keyboard,
      decoration: InputDecoration(labelText: label, hintText: hint),
      validator: required ? (v) => (v == null || v.isEmpty) ? '$label wajib diisi' : null : null,
    );
  }
}