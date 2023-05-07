import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/constants/routes.dart';


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
          child: ElevatedButton(
            onPressed: () {
               Navigator.pushNamed(context, editCourseRoute);
               }, 
            child: Text('Edit Course'),
        ),
    ),
    );
  }
}