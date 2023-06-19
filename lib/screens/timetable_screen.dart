import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/widgets/timetable_container.dart';
import 'package:utmschedular/screens/testing_data.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';

class TimetableAutoFill extends StatefulWidget {
  const TimetableAutoFill({super.key});

  @override
  State<TimetableAutoFill> createState() => _TimetableAutoFillState();
}

class _TimetableAutoFillState extends State<TimetableAutoFill> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TableRow> rows = [];
  List<Container> column = [];
  Widget createTable() {
    for (int i = 0; i < 17; ++i) {
      if (i != 0) {
        rows.add(createTableColumn(i));
      } else {
        rows.add(createTableColumn(i));
      }
    }
    return Table(children: rows);
  }

  TableRow createTableColumn(int i) {
    List<String> day = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    for (int j = 0; j < 8; j++) {
      if (i == 0) {
        if (j == 0) {
          column.add(
            Container(),
          );
        } else {
          column.add(
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  day[j - 1],
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          );
        }
      } else {
        column.add(
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Hello Macaw',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        );
      }
    }
    return TableRow(children: column);
  }

  @override
  Widget build(BuildContext context) {
    //createTable();
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: "TimeTable", scaffoldKey: _scaffoldKey),
      drawer: CustomDrawer(),
      body: TimetableAutoContainer(),
    );
  }
}

class TimetableAutoContainer extends StatelessWidget {
  const TimetableAutoContainer({
    Key? key,
  }) : super(key: key);

  Widget createTable() {
    List<TableRow> rows = [];
    for (int i = 0; i < 18; ++i) {
      if (i != 0) {
        rows.add(createTableColumn(i));
      } else {
        rows.add(createTableColumn(i));
      }
    }
    return Table(children: rows);
  }

  TableRow createTableColumn(int i) {
    List<Container> column = [];
    List<String> day = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    List<String> time = ["8:00","9:00","10:00","11:00","12:00","13:00","14:00",
    "15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00",
    "24:00"];
    for (int j = 0; j < 8; j++) {
      if (i == 0) {
        if (j == 0) {
          column.add(
            Container(),
          );
        } else {
          column.add(
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  day[j - 1],
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          );
        }
      } else {
        if (j == 0) {
          column.add(
            Container(
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  time[i - 1],
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          );
        } else {
          column.add(
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Hello Macaw',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
    return TableRow(children: column);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
        toolbarHeight: 0,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            createTable(),
          ],
        ),
      )),
    );
  }
}
