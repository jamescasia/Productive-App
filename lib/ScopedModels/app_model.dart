import 'package:ProductiveApp/DataModels/AppDatabase.dart';
import 'package:ProductiveApp/ScopedModels/home_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/profile_tab_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/DataModels/AppAuth.dart';
import 'package:ProductiveApp/UtilityModels/UserAdapter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:ProductiveApp/Screens/HomeScreen.dart';

import 'package:ProductiveApp/DataModels/SoloTask.dart';

//this is the main communicator between the ui and the backend
class AppModel extends Model {
  PomodoroModel pomModel;
  HomeTabModel homeTabModel;
  ProfileTabModel profileTabModel;
  UserAdapter userAdapter;
  AppAuth appAuth;
  AppDatabase appDatabase;
  AuthState authState = AuthState.LoggedOut;
  SignUpState signUpState = SignUpState.NotSignedUp;

  AppModel() {
    pomModel = PomodoroModel();
    homeTabModel = HomeTabModel();
    userAdapter = UserAdapter();
    appAuth = AppAuth();
    appDatabase = AppDatabase();
    profileTabModel = ProfileTabModel();
  }

  logInScreenLogIn(email, pass) async {
    try {
      authState = AuthState.LoggingIn;
      print(authState);

      notifyListeners();
      userAdapter.fUser = await appAuth.logInWithEmailAndPass(email, pass);
      print(userAdapter.fUser);
      authState = AuthState.LoggedIn;

      await appDatabase
          .initializeUserDatabase(userAdapter.fUser.uid.toString());
      userAdapter.user.stats.numOfLoginsCompleted += 1;
      await profileTabFetchUserStats();
      profileTabUpdateStats();
    } catch (E) {
      authState = AuthState.InvalidLogIn;
      Future.delayed(const Duration(milliseconds: 2500), () {
        authState = AuthState.LoggedOut;

        print(authState);
        notifyListeners();
      });
    }

    await homeTabFetchSoloTasks();
    await profileTabFetchUserInfo();
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

      await appDatabase.addNewUser(username, userAdapter.fUser.email.toString(),
          userAdapter.fUser.uid.toString());
      await appDatabase
          .initializeUserDatabase(userAdapter.fUser.uid.toString());
      userAdapter.user.stats.numOfLoginsCompleted += 1;

      await profileTabFetchUserStats();
      profileTabUpdateStats();
    } catch (E) {
      print(E.toString());
      signUpState = SignUpState.InvalidSignUp;
      Future.delayed(const Duration(milliseconds: 2500), () {
        signUpState = SignUpState.NotSignedUp;

        print(signUpState);
        notifyListeners();
      });
    }
    await homeTabFetchSoloTasks();
    await profileTabFetchUserInfo();
    notifyListeners();
    print(signUpState);
    print(await FirebaseAuth.instance.currentUser());
    return signUpState;
  }

  homeTabDialogAddNewTask(String taskTitle, DateTime dateDeadline) async {
    appDatabase.initializeUserDatabase(userAdapter.fUser.uid.toString());
    print("added new task");
    print(taskTitle);
    print(dateDeadline);
    var soloTask = SoloTask();

    soloTask.title = taskTitle;
    soloTask.deadline = dateDeadline.toIso8601String();
    userAdapter.user.soloTasks.add(soloTask);
    // soloTask.subtasks = [ Subtask("dummySubTask", "title", "deadline", false), Subtask("dummySubTask2", "title", "deadline", false)];

    try {
      await appDatabase.addNewSoloTask(soloTask);
    } catch (E) {
      print("Error");
      print(E);
    }
    homeTabUpdateHomeState();
    homeTabUpdateAllTasksProgress();
    notifyListeners();
  }

  homeTabAddSubTask(SoloTask soloTask, Subtask subtask) async {
    for (SoloTask st in userAdapter.user.soloTasks) {
      if (st.id == soloTask.id) {
        subtask.id = st.subtasks.length.toString();
        st.subtasks.add(subtask);
        homeTabUpdateSoloTask(st);

        break;
      }
    }
  }

  homeTabUpdateSoloTask(SoloTask soloTask) async {
    var completedSubtasks = 0;
    for (Subtask subtask in soloTask.subtasks) {
      if (subtask.completed) {
        completedSubtasks += 1;

        userAdapter.user.stats.numOfSoloTasksCompleted += 1;
      }
    }

    soloTask.totalProgress = (soloTask.subtasks.length == 0)
        ? 0.0
        : (completedSubtasks / (soloTask.subtasks.length));
    soloTask.completed = completedSubtasks == soloTask.subtasks.length;

    try {
      await appDatabase.updateSoloTask(soloTask);

      homeTabUpdateAllTasksProgress();
    } catch (E) {
      print("Error");
      print(E);
    }

    profileTabUpdateStats();
    notifyListeners();
  }

  homeTabTickFinishedSubtask(SoloTask soloTask, Subtask subtask) async {
    for (SoloTask st in userAdapter.user.soloTasks) {
      if (st.id == soloTask.id) {
        for (Subtask sbtsk in st.subtasks) {
          if (sbtsk.id == subtask.id) {
            sbtsk = subtask;
          }
        }

        break;
      }
    }
    print("subtask");
    userAdapter.user.stats.numOfSubtasksCompleted += 1;
    profileTabUpdateStats();
    userAdapter.user.soloTasks.add(soloTask);
    userAdapter.user.soloTasks.removeLast();
    homeTabUpdateSoloTask(soloTask);
  }

  homeTabUpdateAllTasksProgress() {
    double sumOfProgressPercentages = 0.0;
    int soloTasksCompleted = 0;
    for (SoloTask st in userAdapter.user.soloTasks) {
      sumOfProgressPercentages += st.totalProgress;
      soloTasksCompleted += (st.completed) ? 1 : 0;
    }
    homeTabModel.percentCompletedTasks =
        (userAdapter.user.soloTasks.length == 0)
            ? 0
            : sumOfProgressPercentages / userAdapter.user.soloTasks.length;
    userAdapter.user.stats.numOfSoloTasksCompleted = soloTasksCompleted;
    profileTabUpdateStats();
  }

  homeTabUpdateHomeState() {
    homeTabModel.homeTabState = (userAdapter.user.soloTasks.length > 0)
        ? HomeTabState.SomeSoloTasks
        : HomeTabState.NoSoloTasks;
  }

  homeTabFetchSoloTasks() async {
    userAdapter.user.soloTasks = await appDatabase.fetchSoloTasks();

    homeTabUpdateAllTasksProgress();
    homeTabUpdateHomeState();

    notifyListeners();
  }

  pomodoroTabAcceptFinishedTimer() {
    userAdapter.user.stats.numOfPomodorosCompleted += 1;

    profileTabUpdateStats();
  }

  profileTabUpdateStats() async {
    userAdapter.user.stats.update();
    int numOfCompletedMissions = 0;

    for (bool b in userAdapter.user.stats.missionsCompleted) {
      if (b) {
        numOfCompletedMissions += 1;
      }
    }
    profileTabModel.updateProfilePercentageCompletedMissions(
        numOfCompletedMissions /
            userAdapter.user.stats.missionsCompleted.length);
    notifyListeners();
    await appDatabase.updateUserStats(userAdapter.user.stats);
  }

  profileTabFetchUserStats() async {
    userAdapter.user.stats = await appDatabase.fetchUserStats();
    notifyListeners();
  }

  profileTabFetchUserInfo() async {
    userAdapter.user.userInfo =
        await appDatabase.fetchUserInfo(userAdapter.fUser.uid);
  }
}

enum SignUpState { SigningUp, NotSignedUp, InvalidSignUp, SignedUp }
enum AuthState { LoggedIn, LoggingIn, LoggedOut, LoggingOut, InvalidLogIn }
