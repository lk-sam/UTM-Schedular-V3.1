
import 'package:utmschedular/models/domain/course.dart';

class Timetable {
  final String id;
  final String title;
  final String description;
  final List<Course> courses;

  Timetable({
    required this.id,
    required this.title,
    required this.description,
    required this.courses,
  });

}