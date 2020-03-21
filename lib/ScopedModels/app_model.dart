import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/DataModels/AppAuth.dart';
import 'package:ProductiveApp/UtilityModels/UserAdapter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:ProductiveApp/Screens/HomeScreen.dart';

//this is the main communicator between the ui and the backend
class AppModel extends Model {
  PomodoroModel pomModel;
  UserAdapter userAdapter;
  AppAuth appAuth;
  AuthState authState = AuthState.LoggedOut;
  SignUpState signUpState = SignUpState.NotSignedUp;

  AppModel() {
    print("Appmodel is built");
    pomModel = PomodoroModel();
    userAdapter = UserAdapter();
    appAuth = AppAuth();
  }

  logInScreenLogIn(email, pass) async {
    try {
      authState = AuthState.LoggingIn;
      print(authState);

      notifyListeners();
      userAdapter.fUser = await appAuth.logInWithEmailAndPass(email, pass);
      print(userAdapter.fUser);
      authState = AuthState.LoggedIn;
    } catch (E) {
      authState = AuthState.InvalidLogIn;
      Future.delayed(const Duration(milliseconds: 2500), () {
        authState = AuthState.LoggedOut;

        print(authState);
        notifyListeners();
      });
    }

    notifyListeners();

    print(authState);

    return authState;
  }

  logInScreenLogOut() async {
    try {
      authState = AuthState.LoggingOut;
      print(authState);

      notifyListeners();
      await appAuth.logOut();
      userAdapter.fUser = null;

      authState = AuthState.LoggedOut;
    } catch (E) {
      authState = AuthState.LoggedIn;
    }

    notifyListeners();
    print(authState);
    print(await FirebaseAuth.instance.currentUser());
    return authState;
  }

  signUpScreenSignUp(username, email, pass) async {
    try {
      signUpState = SignUpState.SigningUp;
      print(signUpState);
      notifyListeners();

      userAdapter.fUser = await appAuth.signUpWithEmailAndPass(email, pass);

      print(userAdapter.fUser);

      signUpState = SignUpState.SignedUp;
    } catch (E) {
      signUpState = SignUpState.InvalidSignUp;
      Future.delayed(const Duration(milliseconds: 2500), () {
        signUpState = SignUpState.NotSignedUp;

        print(signUpState);
        notifyListeners();
      });
    }

    notifyListeners();
    print(signUpState);
    print(await FirebaseAuth.instance.currentUser());
    return signUpState;
  }
}

enum SignUpState { SigningUp, NotSignedUp, InvalidSignUp, SignedUp }
enum AuthState { LoggedIn, LoggingIn, LoggedOut, LoggingOut, InvalidLogIn }
