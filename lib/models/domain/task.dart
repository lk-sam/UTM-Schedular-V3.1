
class Task {
  final String title;
  final DateTime dueDateTime;
  final String venue;
  final String category;
  final String tag;
  final bool isRepeated;

  Task({
    required this.title,
    required this.dueDateTime,
    required this.venue,
    required this.category,
    required this.tag,
    this.isRepeated = false,
  });

}