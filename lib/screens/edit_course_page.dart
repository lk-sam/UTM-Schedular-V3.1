import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/widgets/class_schedule.dart';
import 'package:utmschedular/widgets/course_catalog.dart';

class EditCoursePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "", 
        scaffoldKey: _scaffoldKey
        ),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CourseCatalog(),
              SizedBox(height: 16),
              ClassSchedule(),
            ],
          ),
        ),
      ),
    );
  }
}
