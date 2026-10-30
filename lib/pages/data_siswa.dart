class Siswa {
  String nama;
  String nis;
  String kelas;
  String jenisKelamin;
  String alamat;

  Siswa({
    required this.nama,
    required this.nis,
    required this.kelas,
    required this.jenisKelamin,
    required this.alamat,
  });
}

class DataSiswa {
  static final List<Siswa> daftar = [];
}