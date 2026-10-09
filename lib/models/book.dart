class Book {
  final int id;
  final String nomorInduk;
  final String judul;
  final String penulis;
  final String penerbit;
  final int tahunTerbit;
  final int stok;
  final String kategori;
  final String rak;

  Book({
    required this.id,
    required this.nomorInduk,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.tahunTerbit,
    required this.stok,
    required this.kategori,
    required this.rak,
  });
}