part of 'student_dashboard_view.dart';

class StudentDashboardProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  final supabase = Supabase.instance.client;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkAuthentication() async {
    await supabase.auth.signOut();
    _isLoggedIn = false;
    await Future.delayed(Duration(seconds: 2));
    _isLoggedIn = true;
    notifyListeners();
  }

  bool checkStudent() {
    return true;
  }
}
