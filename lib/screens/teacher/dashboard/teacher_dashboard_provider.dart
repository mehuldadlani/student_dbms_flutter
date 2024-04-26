part of 'teacher_dashboard_view.dart';

class TeacherDashboardProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  void logout() {
    supabase.auth.signOut();
  }
}