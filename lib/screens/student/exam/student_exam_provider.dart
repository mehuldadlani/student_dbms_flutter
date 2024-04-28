part of 'student_exam_view.dart';

class StudentExamProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  final session = Supabase.instance.client.auth.currentSession;

  late List<ExamModel> exams = [];

  late List<String> courseCodes;

  late List<String> courseNames = [];

  StudentExamProvider() {
    initState();
    notifyListeners();
  }

  void initState() async {
    await getExams();
    // log('Exams: $exams');
    // log('Course Codes: $courseCodes');
    log('Course Names: $courseNames');
  }

  getCourseNames(String courseCode) async {
    final response =
        await supabase.from('course').select('name').eq('id', courseCode);
    courseNames.add(response[0]['name'].toString());
    notifyListeners();
  }

  getExams() async {
    courseCodes = globalCourseCodes;
    for (var courseCode in courseCodes) {
      final response =
          await supabase.from('exam').select().eq('course_id', courseCode);

      if (response.isNotEmpty) {
        exams.add(ExamModel.fromJson(response[0]));
        await getCourseNames(courseCode);
        log('Course Names: $courseNames');
      } else {
        log('No exams found for course code: $courseCode');
      }
    }
    notifyListeners();
  }
}
