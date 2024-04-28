// ignore_for_file: use_build_context_synchronously

part of 'auth_view.dart';

class AuthViewProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  final LocalStorageService localStorageService = LocalStorageService();
  late String? _userId;
  late String? _email;

  AuthViewProvider() {
    initState();
  }

  void initState() {
    supabase.auth.onAuthStateChange.listen((data) {
      _userId = data.session?.user.id;
      localStorageService.write('userId', _userId);
      _email = data.session?.user.email;
      localStorageService.write('email', _email);
    });
  }

  Future<void> authenticate(BuildContext context) async {
    const webClientId =
        '501712025784-pehbi7dmv1rh1iruhc4tjsdh1n5hrh0b.apps.googleusercontent.com';

    const iosClientId =
        '501712025784-vh2sidt3f3sp2e8ifcaiv2lv5c60r9ml.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    final session = supabase.auth.currentSession;
    if (session != null) {
      final userEmail = session.user.email;
      // Check if the email ends with 'srmist.edu.in' and the first two characters are alphabets and the next two are numbers
      if (userEmail != null && userEmail.endsWith('srmist.edu.in')) {
        final emailParts = userEmail.split('@')[0];
        if (emailParts.length == 6 &&
            emailParts.substring(0, 2).contains(RegExp(r'[a-zA-Z]')) &&
            emailParts.substring(2, 6).contains(RegExp(r'[0-9]'))) {
          localStorageService.write('userType', 'student');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNavbarView()),
          );
        } else if (userEmail.endsWith('srmist.edu.in')) {
          localStorageService.write('userType', 'teacher');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNavbarView()),
          );
        }
      } else {
        supabase.auth.signOut();
        final materialBanner = MaterialBanner(
          elevation: 0,
          backgroundColor: Colors.transparent,
          forceActionsBelow: true,
          content: AwesomeSnackbarContent(
            title: 'Oh Snap!',
            message:
                'Invalid email address. Please use your SRM email address.',
            contentType: ContentType.failure,
            inMaterialBanner: true,
          ),
          actions: const [SizedBox.shrink()],
        );
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: materialBanner.content,
          actions: materialBanner.actions,
          backgroundColor: materialBanner.backgroundColor,
          elevation: materialBanner.elevation,
          leading: materialBanner.leading,
          padding: materialBanner.padding,
          forceActionsBelow: materialBanner.forceActionsBelow,
        ));

        Timer(const Duration(seconds: 3), () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        });

        throw 'Invalid email address. Please use your SRM email address.';
      }
    }
  }
}
