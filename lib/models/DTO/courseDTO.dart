class CourseDTO {
  final int tahunKursus;
  final int seksyen;
  final String kodSubjek;
  final String namaSubjek;
  final String status;
  final String sesi;
  final int semester;
  final String kodKursus;

  CourseDTO({
    required this.tahunKursus,
    required this.seksyen,
    required this.kodSubjek,
    required this.namaSubjek,
    required this.status,
    required this.sesi,
    required this.semester,
    required this.kodKursus,
  });

  factory CourseDTO.fromJson(Map<String, dynamic> json) {
  return CourseDTO(
    tahunKursus: json['tahun_kursus'],
    seksyen: json['seksyen'],
    kodSubjek: json['kod_subjek'],
    namaSubjek: json['nama_subjek'],
    status: json['status'],
    sesi: json['sesi'],
    semester: json['semester'],
    kodKursus: json['kod_kursus'],
  );
}

}