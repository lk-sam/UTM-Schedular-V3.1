import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/constants/routes.dart';
import 'package:utmschedular/widgets/course_container.dart';
import 'package:utmschedular/screens/testing_data.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "TimeTable", 
        scaffoldKey: _scaffoldKey
        ),
        drawer: CustomDrawer(),
        body: Center(
          child:CourseContainer(courses: courses)
    ),
    );
  }
}