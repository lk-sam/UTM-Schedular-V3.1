import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/course.dart';
import 'package:utmschedular/widgets/course_card.dart';

class CourseContainer extends StatelessWidget {

  final List<Course> courses;

  const CourseContainer({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return CourseCard(course: courses[index]);
      },
    );
  }
}