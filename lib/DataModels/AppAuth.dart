import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AppAuth {
  FirebaseAuth fbAuth;
  AppAuth() {
    fbAuth = FirebaseAuth.instance;
  }
  logInWithEmailAndPass(email, pass) async {
    //returns the user
    return (await fbAuth.signInWithEmailAndPassword(
            email: email, password: pass))
        .user;
  }

  logOut() async {
    await fbAuth.signOut();
  }

  signUpWithEmailAndPass(email, pass) async {
    (await fbAuth.createUserWithEmailAndPassword(email: email, password: pass)).user;
  }
}
