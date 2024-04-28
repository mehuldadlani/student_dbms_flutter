part of 'student_profile_view.dart';

class StudentProfileProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  final session = Supabase.instance.client.auth.currentSession;

  List<StudentModel> studentProfile = [];

  late bool _isBusy;

  StudentProfileProvider() {
    initState();
  }

  Future<void> initState() async {
    _isBusy = true;
    notifyListeners();
    await getStudentProfile();
    _isBusy = false;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  Future<void> getStudentProfile() async {
    final response =
        await supabase.from('student').select().eq('reg_no', globalRegNo);

    log('Response: $response');
    studentProfile =
        response.map((json) => StudentModel.fromJson(json)).toList();
    log('Student Profile: $studentProfile');
  }

  void signOut(BuildContext context) async {
    await supabase.auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AuthView()));

    notifyListeners();
  }
}
