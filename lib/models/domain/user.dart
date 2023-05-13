
class User {
  final String matricNo;
  final String username;
  bool isSubscribed;
  DateTime? subscriptionDueDate;

  User({
    required this.matricNo,
    required this.username,
    required this.isSubscribed,
    this.subscriptionDueDate,
  });
}