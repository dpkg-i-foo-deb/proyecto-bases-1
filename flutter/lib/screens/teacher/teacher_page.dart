import 'package:exams_quizzes_alike/exceptions/course_exception.dart';
import 'package:exams_quizzes_alike/models/course.dart';
import 'package:exams_quizzes_alike/network/course_requests.dart';
import 'package:exams_quizzes_alike/screens/teacher/components/course_item.dart';
import 'package:flutter/material.dart';

import '../../models/teacher.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key, required this.teacher}) : super(key: key);
  final Teacher teacher;

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<Course> courses = List.empty();

  @override
  void initState() {
    super.initState();

    getCoursesFuture();
  }

  getCoursesFuture() async {
    courses = await getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
          future: getCourses(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color.fromARGB(255, 191, 238, 183),
                      Color.fromARGB(255, 215, 244, 210),
                    ])),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CourseItem(
                            courses[index].courseCode!,
                            courses[index].courseDescription!,
                            courses[index].teacherLogin)
                        .buildItem(context);
                  },
                ));
          }),
    ));
  }

  Future<List<Course>> getCourses() async {
    try {
      return CourseRequests().getCoursesByTeacher(widget.teacher);
    } on CourseException {
      //TODO do something if the teacher has no courses
      rethrow;
    }
  }
}
