import 'dart:developer';

import 'package:easy_widgets/easy_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/models/student.dart';
import 'package:student_dbms/screens/authentication/auth_view.dart';
import 'package:student_dbms/utils/globals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'student_profile_provider.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProfileProvider(),
      child: Consumer<StudentProfileProvider>(
        builder: (context, provider, child) {
          final reverseDob = provider.studentProfile[0].dob
              .toString()
              .split('-')
              .reversed
              .join('/');
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Profile 🧑‍💻',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => provider.signOut(context),
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    _buildInfoCard(
                      context,
                      title: provider.studentProfile[0].name,
                      value: provider.studentProfile[0].regNo,
                    ),
                    const Spacer(),
                    _buildInfoCard(
                      context,
                      title: 'Email',
                      value: provider.session?.user.email ?? '',
                    ),
                    const Spacer(),
                    _buildInfoCard(
                      context,
                      title: 'Age',
                      value: provider.studentProfile[0].age.toString(),
                    ),
                    const Spacer(),
                    _buildInfoCard(
                      context,
                      title: 'Phone',
                      value: provider.studentProfile[0].phone.toString(),
                    ),
                    const Spacer(),
                    _buildInfoCard(
                      context,
                      title: 'DOB',
                      value: reverseDob,
                    ),
                    const Spacer(),
                    _buildInfoCard(
                      context,
                      title: 'Address',
                      value: provider.studentProfile[0].address,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, StudentProfileProvider provider) {
    return Row(
      children: [
        const Text(
          'Profile 🧑‍💻',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => provider.signOut(context),
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required String title, required String value}) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: context.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
