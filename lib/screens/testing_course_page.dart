import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utmschedular/models/DTO/classDTO.dart';
import 'package:utmschedular/models/DTO/courseDTO.dart';
import 'package:utmschedular/models/domain/class.dart';
import 'package:utmschedular/models/domain/course.dart';
import 'package:utmschedular/services/api_service.dart';
import 'package:utmschedular/widgets/course_card.dart';
import 'package:utmschedular/utils/utils.dart';
import 'package:utmschedular/widgets/course_container.dart';
import 'package:utmschedular/components/custom_appBar.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});
  
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late Future<List<Course>> futureCourses;
 
  Future<String> getMatricNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('matricNo') ?? '';
  }

  @override
  void initState() {
    super.initState();
    futureCourses = getMatricNo().then((matricNo) => getConvertedCourses(matricNo));
  }

// Fetches courses based on the provided matric number
Future<List<Course>> getConvertedCourses(String matricNo) async {
  List<CourseDTO> courseDTOs = await ApiService.fetchAllRegisteredCourses(matricNo);

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

    if (currentDTO.sesi == previousDTO.sesi && currentDTO.semester == previousDTO.semester) {
      filteredCourseDTOs.add(currentDTO);
    }
  }

  List<Course> courses = [];
  for (CourseDTO courseDTO in filteredCourseDTOs) {
    List<ClassDTO> classDTOs = await ApiService.fetchClassesbyCourseDTO(courseDTO);
    List<Class> classes = ClassConverter.convertFromDTOs(classDTOs);
    String lecturer = await ApiService.fetchLecturerbyCourseDTO(courseDTO);
    courses.add(Course.fromDTO(courseDTO, classes, lecturer));
  }

  return courses;
}

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF81163F),
        title: Text('Current Courses'),
      ),
      body: Column(
        children: <Widget>[
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
