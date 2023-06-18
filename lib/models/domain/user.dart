import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String? id;
  final String matricNo;
  final String fullname;
  final String IC;
  String? description;
  bool? isSubscribed;
  DateTime? subscriptionDueDate;

  User({
    this.id,
    required this.matricNo,
    required this.fullname,
    required this.IC,
    this.description,
    this.isSubscribed,
    this.subscriptionDueDate,
  });

  String get getMatricNo {
    return matricNo;
  }

  String get getIC {
    return IC;
  }

}
