import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'teacher_dashboard_provider.dart';

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TeacherDashboardProvider(),
      child: Consumer<TeacherDashboardProvider>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('S T U D E N T  D B M S'),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  viewModel.checkAuthentication();
                },
                child: Text('Check Authentication'),
              ),
            ),
          );
        },
      ),
    );
  }
}