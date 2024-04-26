part of 'bottom_navbar_view.dart';

class BottomNavbarProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }


    final List<Widget> _studentScreens = [
    const StudentDashboardView(),
    const StudentCourseView(),
    const StudentExamView(),
    const StudentProfileView(),
  ];

    final List<Widget> _teacherScreens = [
    const TeacherDashboardView(),
  ];


  hapticFeedback() {
    HapticFeedback.lightImpact();
    notifyListeners();
  }

  List<String> listOfStrings = [
    'Dashboard',
    'Course',
    'Exam',
    'Profile',
  ];

  List<IconData> listOfIcons = [
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.person,
  ];
}
