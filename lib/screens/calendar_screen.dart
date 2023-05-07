import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _HomePageState();
}

class _HomePageState extends State<CalendarPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "calendar", 
        scaffoldKey: _scaffoldKey
        ),
        drawer: CustomDrawer(),
        body: const Center(
          child: Text('Calendar Page'),
        ),
    );
  }
}