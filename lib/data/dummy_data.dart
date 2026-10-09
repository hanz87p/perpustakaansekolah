import '../models/book.dart';
import '../models/loan.dart';

class DummyData {
  static List<Book> books = [
    Book(id: 1, nomorInduk: 'BKU-001', judul: 'Laskar Pelangi', penulis: 'Andrea Hirata', penerbit: 'Bentang Pustaka', tahunTerbit: 2005, stok: 5, kategori: 'Novel', rak: 'A-01'),
    Book(id: 2, nomorInduk: 'BKU-002', judul: 'Bumi Manusia', penulis: 'Pramoedya A.T.', penerbit: 'Hasta Mitra', tahunTerbit: 1980, stok: 3, kategori: 'Novel', rak: 'A-02'),
    Book(id: 3, nomorInduk: 'BKU-003', judul: 'Pemrograman PHP untuk Pemula', penulis: 'Abdul Kadir', penerbit: 'Andi Publisher', tahunTerbit: 2020, stok: 4, kategori: 'Pelajaran', rak: 'B-01'),
    Book(id: 4, nomorInduk: 'BKU-004', judul: 'Laravel Framework Lanjutan', penulis: 'Rizky Pratama', penerbit: 'Elex Media', tahunTerbit: 2022, stok: 2, kategori: 'Pelajaran', rak: 'B-02'),
    Book(id: 5, nomorInduk: 'BKU-005', judul: 'Naruto Vol. 1', penulis: 'Masashi Kishimoto', penerbit: 'Elex Media', tahunTerbit: 2003, stok: 6, kategori: 'Komik', rak: 'C-01'),
    Book(id: 6, nomorInduk: 'BKU-006', judul: 'One Piece Vol. 1', penulis: 'Eiichiro Oda', penerbit: 'Elex Media', tahunTerbit: 2000, stok: 4, kategori: 'Komik', rak: 'C-02'),
    Book(id: 7, nomorInduk: 'BKU-007', judul: 'Sapiens', penulis: 'Yuval N. Harari', penerbit: 'KPG', tahunTerbit: 2017, stok: 3, kategori: 'Non-Fiksi', rak: 'D-01'),
    Book(id: 8, nomorInduk: 'BKU-008', judul: 'Filosofi Teras', penulis: 'Henry Manampiring', penerbit: 'Kompas', tahunTerbit: 2018, stok: 5, kategori: 'Non-Fiksi', rak: 'D-02'),
    Book(id: 9, nomorInduk: 'BKU-009', judul: 'Harry Potter dan Batu Bertuah', penulis: 'J.K. Rowling', penerbit: 'Gramedia', tahunTerbit: 1997, stok: 4, kategori: 'Fiksi', rak: 'E-01'),
    Book(id: 10, nomorInduk: 'BKU-010', judul: 'Matematika Kelas XII', penulis: 'Tim Kemendikbud', penerbit: 'Kemendikbud', tahunTerbit: 2020, stok: 10, kategori: 'Pelajaran', rak: 'B-03'),
  ];

  static List<Loan> loans = [
    Loan(id: 1, kodePinjam: 'PJM-20260101-0001', namaSiswa: 'Ghozi Mumtaza Hanif', nisSiswa: '2024001', judulBuku: 'Laskar Pelangi', nomorInduk: 'BKU-001', tanggalPinjam: DateTime.now().subtract(const Duration(days: 3)), tanggalJatuhTempo: DateTime.now().add(const Duration(days: 4)), status: 'dipinjam', denda: 0),
    Loan(id: 2, kodePinjam: 'PJM-20260101-0002', namaSiswa: 'Budi Santoso', nisSiswa: '2024002', judulBuku: 'Bumi Manusia', nomorInduk: 'BKU-002', tanggalPinjam: DateTime.now().subtract(const Duration(days: 10)), tanggalJatuhTempo: DateTime.now().subtract(const Duration(days: 3)), status: 'dipinjam', denda: 3000),
    Loan(id: 3, kodePinjam: 'PJM-20260101-0003', namaSiswa: 'Siti Aminah', nisSiswa: '2024003', judulBuku: 'Naruto Vol. 1', nomorInduk: 'BKU-005', tanggalPinjam: DateTime.now().subtract(const Duration(days: 15)), tanggalJatuhTempo: DateTime.now().subtract(const Duration(days: 8)), tanggalKembali: DateTime.now().subtract(const Duration(days: 7)), status: 'dikembalikan', denda: 1000),
  ];
}