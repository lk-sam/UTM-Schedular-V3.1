import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utmschedular/constants/routes.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:utmschedular/screens/calendar_screen.dart';
import 'package:utmschedular/screens/change_pass_screen.dart';
import 'package:utmschedular/screens/edit_course_page.dart';
import 'package:utmschedular/screens/home_screen.dart';
import 'package:utmschedular/screens/profile_screen.dart';
import 'package:utmschedular/screens/task_screen.dart';
import 'package:utmschedular/screens/timetable_screen.dart';
import 'package:utmschedular/screens/testing_course_page.dart';
import 'package:utmschedular/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final matricNo = prefs.getString('matricNo');

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  runApp(
    Provider<TaskService>(
      create: (_) => TaskService(),
      child: MyApp(matricNo: matricNo),
    ),
  );

  Hive.close();
}

class MyApp extends StatelessWidget {
  final String? matricNo;
  const MyApp({this.matricNo});

  @override
  Widget build(BuildContext context) {
    print(matricNo);
    final taskService = Provider.of<TaskService>(context, listen: false);
    return MaterialApp(
      title: 'UTM Scheduler',
      theme: ThemeData(
        primaryColor: const Color(0xFF81163F),
      ),
      home: matricNo == null
          ? LoginPage()
          : TaskOverviewPage(taskService: taskService),
      routes: {
        calendarRoute: (context) => const CalendarPage(),
        timetableRoute: (context) => const ExampleTimetable(),
        taskRoute: (context) => TaskOverviewPage(taskService: taskService),
        editCourseRoute: (context) => EditCoursePage(),
        courseListRoute: (context) => CourseScreen(),
        changePassRoute: (context) => ChangePasswordScreen(),
      },
    );
  }
}
