class Loan {
  final int id;
  final String kodePinjam;
  final String namaSiswa;
  final String nisSiswa;
  final String judulBuku;
  final String nomorInduk;
  final DateTime tanggalPinjam;
  final DateTime tanggalJatuhTempo;
  final DateTime? tanggalKembali;
  final String status;
  final int denda;

  Loan({
    required this.id,
    required this.kodePinjam,
    required this.namaSiswa,
    required this.nisSiswa,
    required this.judulBuku,
    required this.nomorInduk,
    required this.tanggalPinjam,
    required this.tanggalJatuhTempo,
    this.tanggalKembali,
    required this.status,
    required this.denda,
  });
}