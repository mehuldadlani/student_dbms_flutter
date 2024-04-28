import 'dart:math' as math;
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_widgets/easy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'student_dashboard_provider.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentDashboardProvider(),
      child: Consumer<StudentDashboardProvider>(
        builder: (context, provider, child) {
          String displayName =
              provider.session!.user.userMetadata!['full_name'];
          String imgUrl = provider.session!.user.userMetadata!['picture'];
          log(imgUrl);
          log(displayName);
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
                          ],
                        ),
                        Image.asset(
                          'assets/srm_logo.png',
                          height: 70,
                        )
                      ],
                    ),
                    const Spacer(),
                    CarouselSlider(
                      carouselController: provider._controller,
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
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
                    const Text(
                      'Events',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ).alignC,
                    const Spacer(),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Attendance',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Overall',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CustomPaint(
                              painter: AttendancePainter(
                                percentage: 0.7862,
                                text: '78.62',
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

class AttendancePainter extends CustomPainter {
  final double percentage;
  final String text;

  AttendancePainter({required this.percentage, required this.text});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    double strokeWidth = 10;
    double startAngle = -math.pi / 2;
    double sweepAngle = 2 * math.pi * percentage;

    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(Offset(radius, radius), radius - strokeWidth / 2, paint);

    Paint fillPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(radius, radius), radius: radius - strokeWidth / 2),
      startAngle + sweepAngle,
      2 * math.pi - sweepAngle,
      false,
      fillPaint,
    );

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    Offset textOffset = Offset(
      radius - textPainter.width / 2,
      radius - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
