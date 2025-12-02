import 'package:google_sign_in/google_sign_in.dart';

class GoogleServices {
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  static Future<GoogleSignInAccount?> login() async {
    final user = await googleSignIn.signIn();

    return user;
  }

  static Future<void> logout() => googleSignIn.disconnect();
}
