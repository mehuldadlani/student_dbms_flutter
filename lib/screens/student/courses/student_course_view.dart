import 'dart:developer';

import 'package:easy_widgets/easy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/models/course.dart';
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
                padding: EdgeInsets.symmetric(
                  vertical: 20.hWise,
                  horizontal: 20.wWise,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello 👋',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    10.hGap,
                    Text(provider.session!.user.email ?? ''),
                    20.hGap,
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.courses.length,
                        itemBuilder: (context, index) {
                          final course = provider.courses[index];
                          return CourseContainer(course: course);
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

  const CourseContainer({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    log(course.description);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            Text('Faculty: ${course.faculty}'),
          ],
        ),
      ),
    );
  }
}
