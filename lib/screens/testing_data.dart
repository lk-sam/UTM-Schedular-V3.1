import 'package:utmschedular/models/domain/class.dart';
import 'package:utmschedular/models/domain/course.dart';
import 'package:utmschedular/models/domain/timetable.dart';

final List<Class> classesMath = [
  Class(day: 'Monday', timeStart: '08:00', timeEnd: '10:00', location: 'Room 101'),
  Class(day: 'Wednesday', timeStart: '13:00', timeEnd: '15:00', location: 'Room 102'),
];

final List<Class> classesPhysics = [
  Class(day: 'Tuesday', timeStart: '09:00', timeEnd: '11:00', location: 'Room 201'),
  Class(day: 'Thursday', timeStart: '14:00', timeEnd: '16:00', location: 'Room 202'),
];

final List<Class> classesChemistry = [
  Class(day: 'Wednesday', timeStart: '10:00', timeEnd: '12:00', location: 'Room 301'),
  Class(day: 'Friday', timeStart: '15:00', timeEnd: '17:00', location: 'Room 302'),
];

final List<Course> courses = [
  Course(name: 'Mathematics', code: 'MTH101', section: 1, lecturer: 'Dr. John Doe', schedule: classesMath),
  Course(name: 'Physics', code: 'PHY101', section: 2, lecturer: 'Dr. Jane Doe', schedule: classesPhysics),
  Course(name: 'Chemistry', code: 'CHM101', section: 1, lecturer: 'Dr. Mary Smith', schedule: classesChemistry),
];

final Timetable timetable1 = Timetable(
  id: '1',
  title: 'Semester 1',
  description: 'First semester timetable',
  courses: [courses[0], courses[1]],
);

final Timetable timetable2 = Timetable(
  id: '2',
  title: 'Semester 2',
  description: 'Second semester timetable',
  courses: [courses[1], courses[2]],
);

final List<Timetable> timetables = [timetable1, timetable2];