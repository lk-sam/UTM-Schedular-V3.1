import 'package:flutter/material.dart';
import 'package:utmschedular/constants/routes.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Calendar'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, calendarRoute);
                },
              ),
              ListTile(
                title: Text('My tasks'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, taskRoute);
                },
              ),
              ListTile(
                title: Text('My Timetables'),
                 onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, timetableRoute);
                },
              ),
            ],
          ),
        );
  }
}
