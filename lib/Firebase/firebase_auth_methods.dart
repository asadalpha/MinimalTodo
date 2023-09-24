import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskapp/Widgets/snack_bar.dart';

class FirebaseAuthMethods {
  final storage = new FlutterSecureStorage();

  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  //email fun
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: use_build_context_synchronously
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }

  //email login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("successfully logged in");
      if (!_auth.currentUser!.emailVerified) {
        // ignore: use_build_context_synchronously
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      // Displaying the error message
    }
  }

  //emailverification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  //Google-signin
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser != null) {
          print("Signed in: ${googleUser.displayName}");
          print("Email: ${googleUser.email}");
          print("Profile Picture: ${googleUser.photoUrl}");
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          //here
          storeTokenandData(userCredential);
          if (userCredential.additionalUserInfo?.isNewUser ?? false) {
            // Perform actions for a new user
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> storeTokenandData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }
}
