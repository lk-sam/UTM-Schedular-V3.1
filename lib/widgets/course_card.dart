import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/course.dart';
import 'package:utmschedular/widgets/class_screen.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Course Name: ${course.name}'),
              SizedBox(height: 16),
              Text('Course Code: ${course.code}'),
              SizedBox(height: 16),
              Text('Section No: ${course.section}'),
              SizedBox(height: 16),
              Text('Lecturer: ${course.lecturer}'),
            ],
          ),
          onTap: () {
           showModalBottomSheet(
            context : context,
            isScrollControlled: true,
             builder: (context) {
              return FractionallySizedBox(
                heightFactor: 2/3,
                child: ClassScreen(course: course),
              );
             });
          },
        ),
      ),
    );
  }
}
