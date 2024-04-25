import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/screens/authentication/auth_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'student_dashboard_provider.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentDashboardProvider(),
      child: Consumer<StudentDashboardProvider>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('S T U D E N T  D B M S'),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  MaterialPageRoute(
                    builder: (context) => AuthView(),
                  );
                  viewModel.checkAuthentication();
                },
                child: Text('Log Out'),
              ),
            ),
          );
        },
      ),
    );
  }
}
