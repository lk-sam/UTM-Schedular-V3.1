import 'package:utmschedular/models/DTO/ruangDTO.dart';

class ClassDTO {
  final String kodSubjek;
  final String idJws;
  final int seksyen;
  final int masa;
  final int hari;
  final Ruang ruang;

  ClassDTO({
    required this.kodSubjek,
    required this.idJws,
    required this.seksyen,
    required this.masa,
    required this.hari,
    required this.ruang,
  });

  factory ClassDTO.fromJson(Map<String, dynamic> json) {
    return ClassDTO(
      kodSubjek: json['kod_subjek'],
      idJws: json['id_jws'] ,
      seksyen: json['seksyen'] ,
      masa: json['masa'] ,
      hari: json['hari']  ,
      ruang: Ruang.fromJson(json['ruang']),
    );
  }
}