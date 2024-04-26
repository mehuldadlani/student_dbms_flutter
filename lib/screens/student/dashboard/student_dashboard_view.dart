import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_widgets/easy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dbms/screens/authentication/auth_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'student_dashboard_provider.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentDashboardProvider(),
      child: Consumer<StudentDashboardProvider>(
        builder: (context, provider, child) {
          String displayName =
              provider.session!.user.userMetadata!['first_name'] ?? 'Guest';
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.hWise,
                  horizontal: 20.wWise,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello 👋',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            10.hGap,
                            Text(provider.session!.user.email ?? ''),
                          ],
                        ),
                        Image.asset(
                          'assets/srm_logo.png',
                          height: 70,
                        )
                      ],
                    ),
                    Spacer(),
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {},
                        scrollDirection: Axis.horizontal,
                      ),
                      items: List.generate(5, (index) {
                        return Builder(
                          builder: (BuildContext context) {
                            double screenWidth =
                                MediaQuery.of(context).size.width;
                            double imageHeight = screenWidth * (9 / 16);
                            return Image.asset(
                              'assets/image$index.jpeg',
                              width: screenWidth,
                              height: imageHeight,
                              fit: BoxFit.fill,
                            );
                          },
                        );
                      }),
                    ),
                    20.hGap,
                    Text(
                      'Events',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ).alignC,
                    const Spacer()
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
