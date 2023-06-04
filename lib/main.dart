import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:utmschedular/constants/routes.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:utmschedular/screens/calendar_screen.dart';
import 'package:utmschedular/screens/edit_course_page.dart';
import 'package:utmschedular/screens/home_screen.dart';
import 'package:utmschedular/screens/task_screen.dart';
import 'package:utmschedular/screens/timetable_screen.dart';
import 'package:utmschedular/screens/testing_course_page.dart';
import 'package:utmschedular/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<TaskService>(
      create: (context) => TaskService(),
      child: MaterialApp(
        title: 'UTM Scheduler',
        theme: ThemeData(
          primaryColor: const Color(0xFF81163F),
        ),
        home: const LoginPage(),
        routes: {
          calendarRoute: (context) => const CalendarPage(),
          timetableRoute: (context) => const ExampleTimetable(),
          taskRoute: (context) => TaskOverviewPage(taskService: Provider.of<TaskService>(context, listen: false)),
          editCourseRoute: (context) => EditCoursePage(),
          courseListRoute: (context) => CourseScreen(),
        },
      ),
    );
  }
}


class MyBlankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF81163F),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  // Open the drawer
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                // Add your profile/settings functionality here
                print('Profile/Settings button pressed');
              },
            ),
          ],
        ),
        body: EditCoursePage(),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Calendar'),
                onTap: () {
                  print('Drawer Calendar tapped');
                },
              ),
              ListTile(
                title: Text('My tasks'),
                onTap: () {
                  print('Drawer My task tapped');
                },
              ),
              ListTile(
                title: Text('My Timetables'),
                onTap: () {
                  print('Drawer My Timetable tapped');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
