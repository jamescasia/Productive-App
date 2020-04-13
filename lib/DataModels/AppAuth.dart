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

  Future<bool> isUserLoggedIn() async {
    try {
      print(await fbAuth.currentUser());
      print(gSignIn.currentUser);
      print(await gSignIn.isSignedIn());
    } catch (e) {
      print("error");
      print(e.toString());
    }
    return ((await fbAuth.currentUser()) != null) ||
        (await gSignIn.currentUser != null);
  }

  gLogInSilently() async{
    gSignIn.signInSilently();
  }

  loginType() async {
    var gUser = gSignIn.currentUser;
    var fbUser = await fbAuth.currentUser();
    if (fbUser != null) return LoginType.Firebase;
    if (gUser != null) return LoginType.Google;
  }

  currentUser() async {
    var gUser = gSignIn.currentUser;
    var fbUser = await fbAuth.currentUser();
    if (fbUser != null) return fbUser;
    if (gUser != null) return gUser;
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

enum LoginType { Firebase, Google }
