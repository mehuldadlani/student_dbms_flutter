part of 'student_course_view.dart';

class StudentCourseProvider extends ChangeNotifier {
  bool _isBusy = false;
  final supabase = Supabase.instance.client;
  final session = Supabase.instance.client.auth.currentSession;
  late String regNo;
  late List<String> courseCodes;
  late List<String> facultyCodes;

  late List<StudentCourseFacultyModel> studentCourseFaculty = [];
  late List<CourseModel> courses = [];
  late List<FacultyModel> faculties = [];

  StudentCourseProvider() {
    initState();
  }

  void initState() async {
    _isBusy = true;
    await getUserRegistrationNumber(session!.user.email!);
    log('Faculty Test: $faculties');
    log('Courses Test: $courses');
    log('Data Fetched Successfully');
    _isBusy = false;
    notifyListeners();
  }

  getUserRegistrationNumber(String email) async {
    final data =
        await supabase.from('student').select('reg_no').eq('email', email);
    regNo = data[0]['reg_no'].toString();
    globalRegNo = regNo;
    await getCoursesForUser();
  }

  Future<void> getCoursesForUser() async {
    final response = await supabase
        .from('student_course_faculty_relationship')
        .select()
        .eq('student_reg_no', regNo);
    log('Response: $response');
    studentCourseFaculty = response
        .map((json) => StudentCourseFacultyModel.fromJson(json))
        .toList();

    courseCodes = studentCourseFaculty
        .map((model) => model.courseCode)
        .where((code) => code.isNotEmpty) // Filter out empty strings
        .toList();
    globalCourseCodes = courseCodes;
    log('Course Codes: $courseCodes');

    facultyCodes = studentCourseFaculty
        .map((model) => model.facultyId.toString())
        .where((code) => code.isNotEmpty) // Filter out empty strings
        .toList();
    globalFacultyCodes = facultyCodes;
    log('Faculty Codes: $facultyCodes');

    await getCourseDetails();
    await getFacultyDetails();
  }

  getCourseDetails() async {
    for (String courseCode in courseCodes) {
      final response =
          await supabase.from('course').select().eq('id', courseCode);
      courses.add(CourseModel.fromJson(response[0]));
    }
  }

  getFacultyDetails() async {
    for (String facultyCode in facultyCodes) {
      final response =
          await supabase.from('faculty').select().eq('id', facultyCode);
      faculties.add(FacultyModel.fromJson(response[0]));
    }
  }
}
