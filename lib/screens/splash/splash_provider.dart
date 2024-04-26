part of 'splash_view.dart';

class SplashProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  late Session? session;

  SplashProvider() {
    initState();
  }

  void initState() {
    session = supabase.auth.currentSession;
  }

  Future<void> checkAuthentication() async {
    if (session != null) {
      MaterialPageRoute(builder: (context) => StudentDashboardView());
    }
  }

}
