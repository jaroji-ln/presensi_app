class Presensi {
  final int id;
  final String nik;
  final String tanggal;
  final String jamMasuk;
  final String jamKeluar;
  final String lokasiMasuk;
  final String lokasiKeluar;
  final String status;

  Presensi({
    required this.id,
    required this.nik,
    required this.tanggal,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.lokasiMasuk,
    required this.lokasiKeluar,
    required this.status,
  });

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      id: json['id'],
      nik: json['nik'],
      tanggal: json['tanggal'],
      jamMasuk: json['jam_masuk'],
      jamKeluar: json['jam_keluar'],
      lokasiMasuk: json['lokasi_masuk'],
      lokasiKeluar: json['lokasi_keluar'],
      status: json['status'],
    );
  }
}
