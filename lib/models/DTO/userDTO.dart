class UserDTO {
  final String fullName;
  final String loginName;
  final String description;
  final String sessionID;

  UserDTO(
      {required this.fullName,
      required this.loginName,
      required this.description,
      required this.sessionID});

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      fullName: json['full_name'],
      loginName: json['login_name'],
      description: json['description'],
      sessionID: json['session_id'],
    );
  }
}
