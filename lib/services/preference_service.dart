import 'package:shared_preferences/shared_preferences.dart';

Future<String> getMatricNo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? matricNo = prefs.getString('matricNo');
  return matricNo ?? ''; // returns the stored matricNo if it exists, else an empty string
}