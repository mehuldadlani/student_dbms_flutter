part of 'student_course_view.dart';

class StudentCourseProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  final session = Supabase.instance.client.auth.currentSession;
  late String regNo;

  late List<CourseModel> courses = [];

  StudentCourseProvider() {
    initState();
  }

  void initState() async {
    await getUserRegistrationNumber(session!.user.email!);
    await getCoursesForUser();
    log('Data Fetched Successfully');
    notifyListeners();
  }

  getUserRegistrationNumber(String email) async {
    final data =
        await supabase.from('student').select('reg_no').eq('email', email);
    regNo = data[0]['reg_no'].toString();
  }

  Future<List<CourseModel>> getCoursesForUser() async {
    final response =
        await supabase.from('course').select().eq('student_reg_no', regNo);
    log('Response: $response');
    courses = response.map((json) => CourseModel.fromJson(json)).toList();
    return courses;
  }
}
