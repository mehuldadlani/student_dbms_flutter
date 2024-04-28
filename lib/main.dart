import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/screens/authentication/auth_view.dart';
import 'package:student_dbms/screens/bottom_nav_bar/bottom_navbar_view.dart';
import 'package:student_dbms/screens/splash/splash_view.dart';
import 'package:student_dbms/screens/student/courses/student_course_view.dart';
import 'package:student_dbms/screens/student/dashboard/student_dashboard_view.dart';
import 'package:student_dbms/screens/student/exam/student_exam_view.dart';
import 'package:student_dbms/screens/student/profile/student_profile_view.dart';
import 'package:student_dbms/screens/teacher/dashboard/teacher_dashboard_view.dart';
import 'package:student_dbms/services/local_storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageService().initStorage();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['ANON_KEY']!,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => AuthViewProvider()),
        ChangeNotifierProvider(create: (context) => StudentDashboardProvider()),
        ChangeNotifierProvider(create: (context) => TeacherDashboardProvider()),
        ChangeNotifierProvider(create: (context) => StudentCourseProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (context) => StudentExamProvider()),
        ChangeNotifierProvider(create: (context) => StudentProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student DBMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashView(),
    );
  }
}
