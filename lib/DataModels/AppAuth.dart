import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppAuth {
  GoogleSignIn gSignIn;
  FirebaseAuth fbAuth;
  AppAuth() {
    fbAuth = FirebaseAuth.instance;
    gSignIn = GoogleSignIn();
  }

  signUpWithGoogle() async {
    return await gSignIn.signIn();
  }

  logInSilentGoogle() async {
    return await gSignIn.signInSilently();
  }

  logInWithEmailAndPass(email, pass) async {
    //returns the user
    return (await fbAuth.signInWithEmailAndPassword(
            email: email, password: pass))
        .user;
  }

  logOut() async {
    try {
      await gSignIn.signOut();
    } catch (e) {}
    try {
      await fbAuth.signOut();
    } catch (e) {}
  }

  signUpWithEmailAndPass(email, pass) async {
    return (await fbAuth.createUserWithEmailAndPassword(
            email: email, password: pass))
        .user;
  }
}
