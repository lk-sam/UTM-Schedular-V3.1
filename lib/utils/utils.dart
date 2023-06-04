// utils.dart
import 'package:utmschedular/models/domain/class.dart';
import 'package:utmschedular/models/DTO/classDTO.dart';
import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';
enum Days { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday }
enum Times { Time8AM, Time9AM, Time10AM, Time11AM, Time12PM, Time1PM, Time2PM, Time3PM, Time4PM, Time5PM }

class ClassConverter {
  static List<Class> convertFromDTOs(List<ClassDTO> classDTOs) {
    classDTOs.sort((a, b) => a.hari != b.hari ? a.hari.compareTo(b.hari) : a.masa.compareTo(b.masa));
    List<Class> classes = [];
    for (int i = 0; i < classDTOs.length; i++) {
      int startMasa = classDTOs[i].masa;
      int endMasa = startMasa;
      int currentDay = classDTOs[i].hari;
      while (i+1 < classDTOs.length && classDTOs[i+1].hari == currentDay && classDTOs[i+1].masa == classDTOs[i].masa + 1) {
        endMasa = classDTOs[++i].masa;
      }
      classes.add(Class(
        day: Days.values[currentDay - 1].toString().split('.')[1],
        timeStart: Times.values[startMasa - 2].toString().split('.')[1],
        timeEnd: Times.values[endMasa - 1].toString().split('.')[1],
        location: classDTOs[i].ruang.namaRuang,  
      ));
    }
    return classes;
  }
}




//Calendar event
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 1, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 1, kToday.month, kToday.day);
