import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:student_dbms/services/local_storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../student/dashboard/student_dashboard_view.dart';
import '../teacher/dashboard/teacher_dashboard_view.dart';

part 'bottom_navbar_provider.dart';

class BottomNavbarView extends StatelessWidget {
  BottomNavbarView({super.key});

  final List<Widget> _studentScreens = [
    const StudentDashboardView(),
  ];

  final List<Widget> _teacherScreens = [
    const TeacherDashboardView(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavbarProvider(),
      child: Consumer<BottomNavbarProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: LocalStorageService().read('userType') == 'student'
                  ? _studentScreens[provider.selectedIndex]
                  : _teacherScreens[provider.selectedIndex],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 40), // Adjust padding here
              child: DotNavigationBar(
                currentIndex: provider.selectedIndex,
                onTap: (index) {
                  provider.updateIndex(index);
                },
                items: [
                  DotNavigationBarItem(
                    icon: const Icon(Icons.home),
                    selectedColor: Colors.blue,
                  ),
                  DotNavigationBarItem(
                    icon: const Icon(Icons.search),
                    selectedColor: Colors.blue,
                  ),
                  DotNavigationBarItem(
                    icon: const Icon(Icons.person),
                    selectedColor: Colors.blue,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
