import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String matricNo;
  final String fullname;
  final String IC;
  final String description;
  bool isSubscribed;
  DateTime? subscriptionDueDate;

  User({
    required this.matricNo,
    required this.fullname,
    required this.IC,
    required this.description,
    required this.isSubscribed,
    this.subscriptionDueDate,
  });

  String get getMatricNo {
    return matricNo;
  }

  String get getIC {
    return IC;
  }
}


