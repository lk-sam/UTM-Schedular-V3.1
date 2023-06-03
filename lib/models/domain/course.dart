import 'package:utmschedular/models/DTO/courseDTO.dart';

import 'class.dart';

class Course {
  final String name;
  final String code;
  final int section;
  final String lecturer;
   List<Class> schedule;

  Course({
    required this.name,
    required this.code,
    required this.section,
    required this.lecturer,
    required this.schedule,
  });

  void addClass(Class newClass) {
    schedule.add(newClass);
  }

  void removeClass(Class newClass) {
    schedule.remove(newClass);
  }

  Course copyWith({
    String? name,
    String? code,
    int? section,
    String? lecturer,
    List<Class>? schedule,
  }) {
    return Course(
      name: name ?? this.name,
      code: code ?? this.code,
      section: section ?? this.section,
      lecturer: lecturer ?? this.lecturer,
      schedule: schedule ?? this.schedule,
    );
  }

  static Course fromDTO(CourseDTO courseDTO, List<Class> classes, String? lecturer) {
    return Course(
      name: courseDTO.namaSubjek,
      code: courseDTO.kodSubjek,
      section: courseDTO.seksyen,
      lecturer: lecturer ?? "Unknown", // As the DTO doesn't have this info
      schedule: classes, 
    );
  }
}