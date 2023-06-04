import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/class.dart';
import 'package:utmschedular/models/domain/course.dart';

class ClassScreen extends StatelessWidget {
  final Course course;

  ClassScreen({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.book, size: 40),
                title: Text(
                  course.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  course.code,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.person, size: 40),
                title: Text(
                  "Lecturer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  course.lecturer,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.schedule, size: 40),
                title: Text(
                  "Schedule",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              course.schedule.isEmpty
                  ? ListTile(
                      title: Text(
                        'No classes scheduled for this course',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: course.schedule.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Icon(Icons.event, size: 30),
                          title: Text(
                            '${course.schedule[index].day}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${course.schedule[index].timeStart} - ${course.schedule[index].timeEnd}',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
