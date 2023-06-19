import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String? id;
  final String matricNo;
  final String fullname;
  final String IC;
  final String password;
  String? description;
  bool? isSubscribed;
  DateTime? subscriptionDueDate;

  UserModel({
    this.id,
    required this.matricNo,
    required this.fullname,
    required this.IC,
    this.description,
    required this.password,
    this.isSubscribed,
    this.subscriptionDueDate,
  });

  String get getMatricNo {
    return matricNo;
  }

  String get getIC {
    return IC;
  }

  //Map user fetched from Firebase to User Model
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullname: data["Fullname"],
        matricNo: data["MatricNo"],
        IC: data["IC"],
        password: data["Password"],
        description: data["Role"]);
  }
}
