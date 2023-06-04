import 'package:cloud_firestore/cloud_firestore.dart';

class UserDTO {
  final String? id;
  final String? password;
  final String fullName;
  final String loginName;
  final String? description;
  final String? sessionID;

  UserDTO(
      {this.id,
      this.password,
      required this.fullName,
      required this.loginName,
      this.description,
      this.sessionID});

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      fullName: json['full_name'],
      loginName: json['login_name'],
      description: json['description'],
      sessionID: json['session_id'],
    );
  }

  factory UserDTO.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserDTO(
      id: document.id,
      fullName: data["fullname"],
      loginName: data["matric no"],
      password: data["password"],
    );
  }

  String getMatricNo() {
    return loginName;
  }

  String? getPassword() {
    return password;
  }
}
