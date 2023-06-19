import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/widgets/timetable_container.dart';
import 'package:utmschedular/screens/testing_data.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/DTO/classDTO.dart';
import '../models/DTO/courseDTO.dart';
import '../models/domain/class.dart';
import '../models/domain/course.dart';
import '../services/api_service.dart';
import '../services/firebase_service.dart';
import '../utils/utils.dart';

class TimetableAutoFill extends StatefulWidget {
  const TimetableAutoFill({super.key});

  @override
  State<TimetableAutoFill> createState() => _TimetableAutoFillState();
}

class _TimetableAutoFillState extends State<TimetableAutoFill> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<List<Course>> futureCourses;

  Future<String> getMatricNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('matricNo') ?? '';
  }

  @override
  void initState() {
    super.initState();
    futureCourses =
        getMatricNo().then((matricNo) => getConvertedCourses(matricNo));
  }

// Fetches courses based on the provided matric number
  Future<List<Course>> getConvertedCourses(String matricNo) async {
    List<CourseDTO> courseDTOs =
        await ApiService.fetchAllRegisteredCourses(matricNo);

    // Filter the courseDTOs based on the latest session and semester
    courseDTOs.sort((a, b) {
      // Compare the session first
      int sessionComparison = b.sesi.compareTo(a.sesi);
      if (sessionComparison != 0) {
        return sessionComparison;
      }

      // Compare the semester if the session is the same
      return b.semester.compareTo(a.semester);
    });
    List<CourseDTO> filteredCourseDTOs = [courseDTOs.first];

    for (int i = 1; i < courseDTOs.length; i++) {
      CourseDTO currentDTO = courseDTOs[i];
      CourseDTO previousDTO = filteredCourseDTOs.last;

      if (currentDTO.sesi == previousDTO.sesi &&
          currentDTO.semester == previousDTO.semester) {
        filteredCourseDTOs.add(currentDTO);
      }
    }

    List<Course> courses = [];
    for (CourseDTO courseDTO in filteredCourseDTOs) {
      List<ClassDTO> classDTOs =
          await ApiService.fetchClassesbyCourseDTO(courseDTO);
      List<Class> classes = ClassConverter.convertFromDTOs(classDTOs);
      String lecturer = await ApiService.fetchLecturerbyCourseDTO(courseDTO);
      courses.add(Course.fromDTO(courseDTO, classes, lecturer));
    }

    return courses;
  }

  @override
  Widget build(BuildContext context) {
    //createTable();
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: "TimeTable", scaffoldKey: _scaffoldKey),
      drawer: CustomDrawer(),
      body: TimetableAutoContainer(futureCourses: futureCourses),
    );
  }
}

class TimetableAutoContainer extends StatelessWidget {
  final Future<List<Course>> futureCourses;

  const TimetableAutoContainer({
    Key? key,
    required this.futureCourses,
  }) : super(key: key);

  Widget createTable({required List<Course> courses}) {
    List<TableRow> rows = [];
    for (int i = 0; i < 10; ++i) {
      rows.add(createTableColumn(i, courses));
    }
    return Table(children: rows);
  }

  TableRow createTableColumn(int i, List<Course> courses) {
    List<Container> column = [];
    List<String> day = ["Sunday", "Monday", "Tueday", "Wednesday", "Thursday"];
    List<String> time = [
      "8:00",
      "9:00",
      "10:00",
      "11:00",
      "12:00",
      "13:00",
      "14:00",
      "15:00",
      "16:00",
      "17:00",
    ];
    List<String> classTime = [
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
    ];
    int counter = 0;
    int changeToClassTimeInt(String classTime) {
      if (classTime == "8")
        return 1;
      else if (classTime == "9")
        return 2;
      else if (classTime == "10")
        return 3;
      else if (classTime == "11")
        return 4;
      else if (classTime == "12")
        return 5;
      else if (classTime == "13")
        return 6;
      else if (classTime == "14")
        return 7;
      else if (classTime == "15")
        return 8;
      else if (classTime == "16")
        return 9;
      else if (classTime == "17")
        return 10;
      else
        return -1;
    }

    int changeToClassDayInt(String classDay) {
      if (classDay == "Sunday")
        return 1;
      else if (classDay == "Monday")
        return 2;
      else if (classDay == "Tuesday")
        return 3;
      else if (classDay == "Wednesday")
        return 4;
      else if (classDay == "Thursday")
        return 5;
      else
        return -1;
    }

    String insertClass(currentTime, currentDay) {
      bool position = false;
      for (int i = 0; i < courses.length; i++) {
        for (int j = 0; j < courses[i].schedule.length; j++) {
          String classTime = courses[i].schedule[j].timeStart;
          String classTimeRange = classTime.substring(classTime.length - 2);
          String modifiedText = classTime.substring(4);
          String content = modifiedText.replaceRange(
              modifiedText.length - 2, modifiedText.length, '');
          print(content); //2
          String classTimeString = "";
          classTimeRange == "AM"
              ? classTimeString = content
              : classTimeString = (int.parse(content) + 12).toString(); //14
          String classDayString = courses[i].schedule[j].day; //monday
          int classTimeInt = changeToClassTimeInt(classTimeString);
          int classDayInt = changeToClassDayInt(classDayString);
          if (classTimeInt == currentTime && classDayInt == currentDay) {
            return courses[i].name;
          }

          classTime = courses[i].schedule[j].timeEnd;
          classTimeRange = classTime.substring(classTime.length - 2);
          modifiedText = classTime.substring(4);
          content = modifiedText.replaceRange(
              modifiedText.length - 2, modifiedText.length, '');
          print(content); //2
          classTimeString = "";
          classTimeRange == "AM"
              ? classTimeString = content
              : classTimeString = (int.parse(content) + 12).toString(); //14
          classDayString = courses[i].schedule[j].day; //monday
          classTimeInt = changeToClassTimeInt(classTimeString);
          classDayInt = changeToClassDayInt(classDayString);
          if (classTimeInt == currentTime && classDayInt == currentDay) {
            return courses[i].name;
          }
        }
      }
      return "-";
    }

    for (int j = 0; j < 6; j++) {
      if (i == 0) {
        if (j == 0) {
          column.add(
            Container(),
          );
        } else {
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
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Wrap(
                    children: [
                      Text(
                        insertClass(i, j),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )),
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
          child: Card(
              elevation: 10,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListView(
                    children: [
                      FutureBuilder<List<Course>>(
                        future: futureCourses,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return Text('No data');
                          } else {
                            return Column(children: [
                              createTable(courses: snapshot.data!),
                            ]);
                          }
                        },
                      ),
                    ],
                  )))),
    );
  }
}
