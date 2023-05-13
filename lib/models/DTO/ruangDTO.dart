class Ruang {
  final String kodRuang;
  final String namaRuang;
  final String namaRuangSingkatan;

  Ruang({
    required this.kodRuang,
    required this.namaRuang,
    required this.namaRuangSingkatan,
  });

  factory Ruang.fromJson(Map<String, dynamic> json) {
    return Ruang(
      kodRuang: json['kod_ruang'] ?? "Unknown",
      namaRuang: json['nama_ruang'] ?? "Unknown",
      namaRuangSingkatan: json['nama_ruang_singkatan'] ?? "Unknown",
    );
  }
}