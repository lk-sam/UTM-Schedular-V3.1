
class Class {
  final String day;
  final String timeStart;
  final String timeEnd;
  final String location;

  Class({
    required this.day,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
  });

  get startTime => null;

  Class copyWith({
    String? day,
    String? timeStart,
    String? timeEnd,
    String? location,
  }) {
    return Class(
      day: day ?? this.day,
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
      location: location ?? this.location,
    );
  }
}