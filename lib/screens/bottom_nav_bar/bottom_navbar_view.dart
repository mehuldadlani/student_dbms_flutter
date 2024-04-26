import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/services/local_storage_service.dart';

import '../student/courses/student_course_view.dart';
import '../student/dashboard/student_dashboard_view.dart';
import '../student/exam/student_exams.dart';
import '../student/profile/student_profile.dart';
import '../teacher/dashboard/teacher_dashboard_view.dart';

part 'bottom_navbar_provider.dart';

class BottomNavbarView extends StatelessWidget {
  BottomNavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => BottomNavbarProvider(),
      child: Consumer<BottomNavbarProvider>(
        builder: (context, provider, child) {
          log(LocalStorageService().read('userType'));
          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: LocalStorageService().read('userType') == 'student'
                    ? provider._studentScreens[provider.selectedIndex]
                    : provider._teacherScreens[provider.selectedIndex],
              ),
              bottomNavigationBar: Container(
                  margin: EdgeInsets.all(width * 0.05),
                  height: width * 0.155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          provider._selectedIndex = index;
                          provider.hapticFeedback();
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == provider.selectedIndex
                                  ? width * 0.32
                                  : width * 0.18,
                              alignment: Alignment.center,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                height: index == provider.selectedIndex
                                    ? width * .12
                                    : 0,
                                width: index == provider.selectedIndex
                                    ? width * 0.32
                                    : 0,
                                decoration: BoxDecoration(
                                  color: index == provider.selectedIndex
                                      ? Colors.blueAccent.withOpacity(0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == provider.selectedIndex
                                  ? width * 0.31
                                  : width * 0.18,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    provider.listOfIcons[index],
                                    color: index == provider.selectedIndex
                                        ? Colors.blueAccent
                                        : Colors.black26,
                                    size: width * 0.059,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AnimatedOpacity(
                                    opacity:
                                        index == provider.selectedIndex ? 1 : 0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: Text(
                                      index == provider.selectedIndex
                                          ? provider.listOfStrings[index]
                                          : '',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )));
        },
      ),
    );
  }
}
