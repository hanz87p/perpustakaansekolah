class User {
  final int id;
  final String name;
  final String nisNip;
  final String role;
  final String? kelas;
  final String? noHp;

  User({
    required this.id,
    required this.name,
    required this.nisNip,
    required this.role,
    this.kelas,
    this.noHp,
  });
}