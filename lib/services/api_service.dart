import 'package:http/http.dart' as http;
import 'package:utmschedular/models/DTO/classDTO.dart';
import 'dart:convert';

import 'package:utmschedular/models/DTO/courseDTO.dart';
import 'package:utmschedular/models/DTO/userDTO.dart';

class ApiService {
  static Future<List<CourseDTO>> fetchAllRegisteredCourses(
      String matricNo) async {
    final response = await http.get(
      Uri.parse("http://web.fc.utm.my/ttms/web_man_webservice_json.cgi?"
          "entity=pelajar_subjek"
          "&no_matrik=$matricNo"),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new CourseDTO.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<String> fetchLecturerbyCourseDTO(CourseDTO course) async {
    final response = await http
        .get(Uri.parse("http://web.fc.utm.my/ttms/web_man_webservice_json.cgi"
            "?entity=subjek_pensyarah"
            "&kod_subjek=${course.kodSubjek}"
            "&sesi=${course.sesi}"
            "&semester=${course.semester}"
            "&seksyen=${course.seksyen}"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse[0]['nama'];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<List<ClassDTO>> fetchClassesbyCourseDTO(
      CourseDTO course) async {
    final response = await http.get(
      Uri.parse("http://web.fc.utm.my/ttms/web_man_webservice_json.cgi"
          "?entity=jadual_subjek"
          "&sesi=${course.sesi}"
          "&semester=${course.semester}"
          "&kod_subjek=${course.kodSubjek}"
          "&seksyen=${course.seksyen}"),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((data) {
        return new ClassDTO.fromJson(data);
      }).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<String> fetchMatricNo(String matricNo, String ic) async {
    final response = await http
        .get(Uri.parse("http://web.fc.utm.my/ttms/web_man_webservice_json.cgi"
            "?entity=authentication"
            "&login=${matricNo}"
            "&password=${ic}"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse[0]['login_name'];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<String> fetchName(String matricNo, String ic) async {
    final response = await http
        .get(Uri.parse("http://web.fc.utm.my/ttms/web_man_webservice_json.cgi"
            "?entity=authentication"
            "&login=${matricNo}"
            "&password=${ic}"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse[0]['full_name'];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<String> fetchRole(String matricNo, String ic) async {
    final response = await http
        .get(Uri.parse("http://web.fc.utm.my/ttms/web_man_webservice_json.cgi"
            "?entity=authentication"
            "&login=${matricNo}"
            "&password=${ic}"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse[0]['description'];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
