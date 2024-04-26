import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/screens/authentication/auth_view.dart';
import 'package:student_dbms/screens/splash/splash_view.dart';
import 'package:student_dbms/screens/student/dashboard/student_dashboard_view.dart';
import 'package:student_dbms/screens/teacher/dashboard/teacher_dashboard_view.dart';
import 'package:student_dbms/services/local_storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageService().initStorage();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: 'https://dejrdvtubpvdqlozzobx.supabase.co',
    anonKey: dotenv.env['ANON_KEY']!,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => AuthViewProvider()),
        ChangeNotifierProvider(create: (context) => StudentDashboardProvider()),
        ChangeNotifierProvider(create: (context) => TeacherDashboardProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

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
