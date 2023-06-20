import 'package:flutter/material.dart';
import 'package:utmschedular/constants/routes.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.calendar_month_rounded,
                color: Color.fromARGB(255, 70, 70, 70)),
            title: Text('Calendar', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, calendarRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.task, color: Color.fromARGB(255, 70, 70, 70)),
            title: Text('My tasks', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, taskRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.schedule_rounded,
                color: Color.fromARGB(255, 70, 70, 70)),
            title: Text('My Timetables', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, timetableRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.subject_rounded,
                color: Color.fromARGB(255, 70, 70, 70)),
            title: Text('My Courses', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, courseListRoute);
            },
          ),
        ],
      ),
    ));
  }
}
