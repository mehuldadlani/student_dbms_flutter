part of 'student_dashboard_view.dart';

class StudentDashboardProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  final supabase = Supabase.instance.client;
  final session = Supabase.instance.client.auth.currentSession;
  bool get isLoggedIn => _isLoggedIn;

  final int _current = 0;
  final CarouselController _controller = CarouselController();

  int get current => _current;

  Future<void> checkAuthentication() async {
    await supabase.auth.signOut();
    _isLoggedIn = false;
    await Future.delayed(const Duration(seconds: 2));
    _isLoggedIn = true;
    notifyListeners();
  }

}
