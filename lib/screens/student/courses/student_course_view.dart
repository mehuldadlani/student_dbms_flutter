import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/models/course.dart';
import 'package:student_dbms/models/faculty.dart';
import 'package:student_dbms/models/student_course_faculty.dart';
import 'package:student_dbms/utils/globals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'student_course_provider.dart';

class StudentCourseView extends StatefulWidget {
  const StudentCourseView({super.key});

  @override
  State<StudentCourseView> createState() => _StudentCourseViewState();
}

class _StudentCourseViewState extends State<StudentCourseView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentCourseProvider(),
      child: Consumer<StudentCourseProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Courses 📔',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(provider.session!.user.email ?? ''),
                    const SizedBox(height: 20),
                    if (provider._isBusy ==
                        true) // Check if the data is being fetched
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.courses.length,
                        itemBuilder: (context, index) {
                          final course = provider.courses[index];
                          final faculty = provider.faculties[index];
                          return CourseContainer(
                            course: course,
                            faculty: faculty,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CourseContainer extends StatelessWidget {
  final CourseModel course;
  final FacultyModel faculty;

  const CourseContainer({
    super.key,
    required this.course,
    required this.faculty,
  });

  @override
  Widget build(BuildContext context) {
    log(course.description);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          // Navigate to exam details screen
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Credit: ${course.credit}'),
              Text('Department: ${course.departmentName}'),
              Text('Faculty: ${faculty.name}'),
            ],
          ),
        ),
      ),
    );
  }
}
