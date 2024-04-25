import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_widgets/easy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/screens/authentication/auth_view.dart';
import 'package:student_dbms/screens/teacher/dashboard/teacher_dashboard_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../student/dashboard/student_dashboard_view.dart';

part 'splash_provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashProvider(),
      child: Consumer<SplashProvider>(
        builder: (context, viewModel, child) {
          return AnimatedSplashScreen(
            splash: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.wWise),
              child: Text(
                'S T U D E N T  D B M S',
                style: TextStyle(
                  fontSize: 30.hWise,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            nextScreen: viewModel.session != null
                ? (viewModel.checkStudent()
                    ? StudentDashboardView()
                    : TeacherDashboardView())
                : AuthView(),
            splashTransition: SplashTransition.sizeTransition,
            backgroundColor: Colors.white,
            duration: 1000,
          );
        },
      ),
    );
  }
}
