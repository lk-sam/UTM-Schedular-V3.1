import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/timetable.dart';
import 'package:utmschedular/widgets/course_screen.dart';

class TimetableCard extends StatelessWidget {
  final Timetable timetable;

  const TimetableCard({Key? key, required this.timetable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Timetable ID: ${timetable.id}'),
                const SizedBox(height: 16),
                Text('Timetable Title: ${timetable.title}'),
                const SizedBox(height: 16),
                Text('Timetable Desciption: ${timetable.description}'),
                // SizedBox(height: 16),
                // Text('List of courses: ${timetable.courses}'),
              ],
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 2 / 3,
                      child: CourseScreen(timetable: timetable),
                    );
                  });
            },
          ),
        ));
  }
}
