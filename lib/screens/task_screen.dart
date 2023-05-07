import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';


class TaskOverviewPage extends StatefulWidget {
  const TaskOverviewPage({super.key});

  @override
  State<TaskOverviewPage> createState() => _HomePageState();
}

class _HomePageState extends State<TaskOverviewPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "Task Overview", 
        scaffoldKey: _scaffoldKey
        ),
        drawer: CustomDrawer(),
        body: const Center(
          child: Text('Task Overview Page'),
        ),
    );
  }
}