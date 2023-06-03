import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/models/domain/class.dart';
import 'package:utmschedular/models/domain/course.dart';

class ClassScreen extends StatelessWidget {
  final Course course;

   ClassScreen({Key? key, required this.course}) :super(key: key);

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
              'Course Catalog',
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
                  course.name,
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
                      child: 
                      Text(
                        course.code,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child:
                      Text(
                        "${course.section}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  course.lecturer,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                course.schedule.isEmpty ?
                const Text(
                  'No classes scheduled for this course',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ) :
                Column(
                  children: course.schedule.map((Class schedule) => 
                      Text(
                        '${schedule.day} ${schedule.timeStart} - ${schedule.timeEnd}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      ).toList(),
                  ),
              ],
            ),
            ),
        ),
      ],
    );
  }
}