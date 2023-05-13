import 'package:flutter/material.dart';
import 'package:utmschedular/models/DTO/classDTO.dart';
import 'package:utmschedular/models/DTO/courseDTO.dart';
import 'package:utmschedular/models/domain/class.dart';
import 'package:utmschedular/models/domain/course.dart';
import 'package:utmschedular/services/api_service.dart';
import 'package:utmschedular/widgets/course_card.dart';
import 'package:utmschedular/utils/utils.dart';
import 'package:utmschedular/widgets/course_container.dart';
class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});
  
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late Future<List<Course>> futureCourses = Future.value([]);
  String matricNo = ''; // A variable to store the matric number

  @override
  void initState() {
    super.initState();
  }

  // Fetches courses based on the provided matric number
  Future<List<Course>> getConvertedCourses(String matricNo) async {
    List<CourseDTO> courseDTOs = await ApiService.fetchAllRegisteredCourses(matricNo);

    List<Course> courses = [];
    for (CourseDTO courseDTO in courseDTOs) {
      List<ClassDTO> classDTOs = await ApiService.fetchClassesbyCourseDTO(courseDTO);
      List<Class> classes = ClassConverter.convertFromDTOs(classDTOs);
      String lecturer = await ApiService.fetchLecturerbyCourseDTO(courseDTO);
      courses.add(Course.fromDTO(courseDTO, classes, lecturer));
    }
    return courses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Enter your matric number",
            ),
            onChanged: (value) {
              setState(() {
                matricNo = value; // Update the matric number whenever the user types something
              });
            },
          ),
          ElevatedButton(
            child: Text("Fetch Data"),
            onPressed: () {
              setState(() {
                futureCourses = getConvertedCourses(matricNo); // Fetch courses when the button is pressed
              });
            },
          ),
          FutureBuilder<List<Course>>(
            future: futureCourses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data');
              } else {
                return Expanded(
                  child: CourseContainer(courses: snapshot.data!),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
