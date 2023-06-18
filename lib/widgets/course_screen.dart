import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/models/domain/class.dart';
import 'package:utmschedular/models/domain/course.dart';

import '../models/domain/timetable.dart';

class CourseScreen extends StatelessWidget {
  final Timetable timetable;

  CourseScreen({Key? key, required this.timetable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.book),
            SizedBox(width: 16),
            Text(
              'Timetable Info',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timetable.id ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        timetable.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: Text(
                        timetable.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                timetable.courses.isEmpty
                    ? const Text(
                        'No classes scheduled for this course',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Column(
                        children: timetable.courses
                            .map((Course course) => Text(
                                  course.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                            .toList(),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
