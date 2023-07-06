import 'package:cloud_firestore/cloud_firestore.dart';

class UserDTO {
  final String? id;
  final String? password;
  final String? ic;
  final String fullName;
  final String loginName;
  final String description;
  final String? sessionID;

  UserDTO(
      {this.id,
      this.password,
      this.ic,
      required this.fullName,
      required this.loginName,
      required this.description,
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
        fullName: data["Fullname"],
        loginName: data["MatricNo"],
        password: data["Password"],
        ic: data["IC"],
        description: data["Role"]);
  }

  String getMatricNo() {
    return loginName;
  }

  String? getPassword() {
    return password;
  }

  String getFullName() {
    return fullName;
  }

  String getRole() {
    return description;
  }
}
