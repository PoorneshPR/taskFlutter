import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider with ChangeNotifier {
  String? _userInfo;
  var userdetails;
  Map? _userFb;

  Map? get userFb => _userFb;

  String? get userInfo => _userInfo;

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  Future<User?> signInGoogle(BuildContext context) async {
    FirebaseAuth authFirebaseSample = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        UserCredential userCredential =
            await authFirebaseSample.signInWithCredential(authCredential);
        user = userCredential.user;
        _userInfo = userCredential.user?.displayName.toString();
        userdetails = userCredential.user?.email;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "The account already exists with a different credential.",
              style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
            ),
          ));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Error occurred while accessing credentials. Try again.',
              style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
            ),
          )); // handle the error here
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Error occurred using google sign in. Try again.',
            style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
          ),
        ));
      }
    }
    notifyListeners();
    return user;
  }

  //signout google
  Future signOutGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        googleSignIn.signOut();
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Signing out",
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      )));
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error Sign out,Try again.',
          style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
        ),
      ));
    }
  }

  //siginFB
  Future<dynamic> signInFacebook(context) async {
    try {
      final result = await FacebookAuth.instance
          .login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final requestData = await FacebookAuth.i
            .getUserData(fields: 'email,name,first_name,last_name');
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        // Once signed in, return the UserCredential
        var userData = requestData;
        _userFb = userData;

        //return await FirebaseAuth.instance.signInWithCredential(credential);
        return requestData;
      } else {
        debugPrint('error');
      }
    } catch (error) {
      debugPrint(" Facebook login error $error");
    }
    notifyListeners();
  }

  //signOutFb
  signOutFB(BuildContext context) async {
    await FacebookAuth.instance.logOut();
  }
}
