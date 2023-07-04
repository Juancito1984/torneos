import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:torneos/app/data/repository/login_repository.dart';

class LoginProvider extends LoginRepository {
  LoginProvider._();

  static final _intance = LoginProvider._();

  factory LoginProvider() {
    return _intance;
  }

  @override
  Future<void> loginGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    // User? firebaseUser;

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // firebaseUser = (await auth.signInWithCredential(credential)).user;
     (await auth.signInWithCredential(credential)).user;
    }

    // return firebaseUser;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
