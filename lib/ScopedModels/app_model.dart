import 'package:ProductiveApp/DataModels/AppDatabase.dart';
import 'package:ProductiveApp/ScopedModels/home_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/profile_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/collab_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/tab_changer_model.dart';
import 'package:ProductiveApp/Screens/LogInScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/DataModels/AppAuth.dart';
import 'package:ProductiveApp/UtilityModels/UserAdapter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ProductiveApp/DataModels/SoloTask.dart';
import 'package:ProductiveApp/DataModels/CollabTask.dart';

//this is the main communicator between the ui and the backend
class AppModel extends Model {
  PomodoroModel pomModel;
  HomeTabModel homeTabModel;
  ProfileTabModel profileTabModel;
  CollabTabModel collabTabModel;
  UserAdapter userAdapter;
  AppAuth appAuth;
  AppDatabase appDatabase;
  AuthState authState = AuthState.LoggedOut;
  SignUpState signUpState = SignUpState.NotSignedUp;

  TabChangerModel tabChangerModel;
  AppModel() {
    tabChangerModel = TabChangerModel();
    pomModel = PomodoroModel();
    homeTabModel = HomeTabModel();
    userAdapter = UserAdapter();
    appAuth = AppAuth();
    appDatabase = AppDatabase();
    profileTabModel = ProfileTabModel();
    collabTabModel = CollabTabModel();
  }

  logInScreenLogIn(email, pass) async {
    try {
      authState = AuthState.LoggingIn;
      print(authState);

      notifyListeners();
      userAdapter.fUser = await appAuth.logInWithEmailAndPass(email, pass);
      print(userAdapter.fUser);
      authState = AuthState.LoggedIn;

      userAdapter.uid = userAdapter.fUser.uid.toString();

      await appDatabase.initializeUserDatabase(userAdapter.uid);
      await profileTabFetchUserStats();
      userAdapter.user.stats.numOfLoginsCompleted += 1;
      profileTabUpdateStats();

      await homeTabFetchSoloTasks();
      await collabTabFetchCollabTasks();
      await profileTabFetchUserInfo();
      notifyListeners();
    } catch (E) {
      authState = AuthState.InvalidLogIn;
      Future.delayed(const Duration(milliseconds: 2500), () {
        authState = AuthState.LoggedOut;

        print(authState);
        notifyListeners();
      });
    }

    print(authState);
    tabChangerModel.currentTab = 0;

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
    return authState;
  }

  logInScreenGoogleLogIn() async {
    try {
      authState = AuthState.LoggingIn;
      print(authState);

      notifyListeners();

      userAdapter.gUser = await appAuth.signUpWithGoogle();
      authState = AuthState.LoggedIn;

      userAdapter.uid = userAdapter.gUser.id.toString();
      var exists = await appDatabase.userExists(userAdapter.uid);
      if (!exists) {
        authState = AuthState.InvalidLogIn;
        Future.delayed(const Duration(milliseconds: 2500), () {
          authState = AuthState.LoggedOut;

          print(authState);
          notifyListeners();
        });

        appAuth.logOut();

        Fluttertoast.showToast(
            msg: "User does not exist. Register first!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        return authState;
      }

      // check if the uid exists in user list
      // if it does, continue signing in
      // if it doesn't, just show toast and show Invalid login

      await appDatabase.initializeUserDatabase(userAdapter.uid);
      await profileTabFetchUserStats();
      userAdapter.user.stats.numOfLoginsCompleted += 1;
      profileTabUpdateStats();
      await homeTabFetchSoloTasks();
      await collabTabFetchCollabTasks();
      await profileTabFetchUserInfo();
      notifyListeners();

      print(authState);
    } catch (E) {
      authState = AuthState.InvalidLogIn;
      Future.delayed(const Duration(milliseconds: 2500), () {
        authState = AuthState.LoggedOut;

        print(authState);
        notifyListeners();
      });
    }

    tabChangerModel.currentTab = 0;
    return authState;
  }

  signUpScreenGoogleSignUp() async {
    appAuth.logOut();
    try {
      signUpState = SignUpState.SigningUp;
      print(signUpState);
      notifyListeners();

      userAdapter.gUser = await appAuth.signUpWithGoogle();

      userAdapter.uid = userAdapter.gUser.id.toString();

      var exists = await appDatabase.userExists(userAdapter.uid);
      if (exists) {
        Fluttertoast.showToast(
            msg: "User already registered! Logging in.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        signUpState = SignUpState.SignedUpWithGoogle;
        await appDatabase.initializeUserDatabase(userAdapter.uid);
        await profileTabFetchUserStats();

        userAdapter.user.stats.numOfLoginsCompleted += 1;
        profileTabUpdateStats();
        await homeTabFetchSoloTasks();
        await collabTabFetchCollabTasks();
        await profileTabFetchUserInfo();
        notifyListeners();
        return signUpState;
      } else {
        print(userAdapter.gUser);

        signUpState = SignUpState.SignedUp;

        await appDatabase.addNewUser(userAdapter.gUser.displayName,
            userAdapter.gUser.email.toString(), userAdapter.uid);
        await appDatabase.initializeUserDatabase(userAdapter.uid);
        userAdapter.user.stats.numOfLoginsCompleted += 1;

        await profileTabFetchUserStats();
        profileTabUpdateStats();
        await homeTabFetchSoloTasks();
        await collabTabFetchCollabTasks();
        await profileTabFetchUserInfo();
        notifyListeners();
      }
    } catch (E) {
      print(E.toString());
      signUpState = SignUpState.InvalidSignUp;
      Future.delayed(const Duration(milliseconds: 2500), () {
        signUpState = SignUpState.NotSignedUp;

        print(signUpState);
        notifyListeners();
      });
    }

    print(signUpState);
    tabChangerModel.currentTab = 0;
    return signUpState;
  }

  signUpScreenSignUp(username, email, pass) async {
    try {
      signUpState = SignUpState.SigningUp;
      print(signUpState);
      notifyListeners();

      userAdapter.fUser = await appAuth.signUpWithEmailAndPass(email, pass);

      print(userAdapter.fUser);

      userAdapter.uid = userAdapter.fUser.uid.toString();

      signUpState = SignUpState.SignedUp;

      await appDatabase.addNewUser(
          username, userAdapter.fUser.email.toString(), userAdapter.uid);
      await appDatabase.initializeUserDatabase(userAdapter.uid);
      userAdapter.user.stats.numOfLoginsCompleted += 1;

      await profileTabFetchUserStats();
      profileTabUpdateStats();
      await homeTabFetchSoloTasks();
      await profileTabFetchUserInfo();
      notifyListeners();
      print(signUpState);
      print(await FirebaseAuth.instance.currentUser());
    } catch (E) {
      print(E.toString());
      signUpState = SignUpState.InvalidSignUp;
      Future.delayed(const Duration(milliseconds: 2500), () {
        signUpState = SignUpState.NotSignedUp;

        print(signUpState);
        notifyListeners();
      });
    }

    return signUpState;
  }

  homeTabDialogAddNewTask(String taskTitle, DateTime dateDeadline) async {
    appDatabase.initializeUserDatabase(userAdapter.uid);
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

  collabTabDialogAddNewCollabTask(
      String taskTitle, DateTime dateDeadline) async {
    appDatabase.initializeUserDatabase(userAdapter.uid);
    print("added new task");
    print(taskTitle);
    print(dateDeadline);
    var collabTask = CollabTask();

    collabTask.title = taskTitle;
    collabTask.deadline = dateDeadline.toIso8601String();
    userAdapter.user.collabTasks.add(collabTask);
    // soloTask.subtasks = [ Subtask("dummySubTask", "title", "deadline", false), Subtask("dummySubTask2", "title", "deadline", false)];

    try {
      await appDatabase.addNewCollabTask(collabTask);
    } catch (E) {
      print("Error");
      print(E);
    }
    collabTabUpdateCollabTabState();
    collabTabUpdateAllTasksProgress();
    notifyListeners();
  }

  collabTabAddCollabSubTask(
      CollabTask collabTask, CollabSubtask collabSubtask) async {
    for (CollabTask ct in userAdapter.user.collabTasks) {
      if (ct.id == collabTask.id) {
        collabSubtask.id = ct.collabSubtasks.length.toString();
        ct.collabSubtasks.add(collabSubtask);
        collabTabUpdateCollabTask(ct);

        break;
      }
    }
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

  collabTabUpdateCollabTask(CollabTask collabTask) async {
    var completedCollabSubtasks = 0;
    for (CollabSubtask collabSubtask in collabTask.collabSubtasks) {
      if (collabSubtask.completed) {
        completedCollabSubtasks += 1;

        userAdapter.user.stats.numOfCollabTasksCompleted += 1;
      }
    }

    collabTask.totalProgress = (collabTask.collabSubtasks.length == 0)
        ? 0.0
        : (completedCollabSubtasks / (collabTask.collabSubtasks.length));
    collabTask.completed =
        completedCollabSubtasks == collabTask.collabSubtasks.length;

    try {
      await appDatabase.updateCollabTask(collabTask);

      collabTabUpdateAllTasksProgress();
    } catch (E) {
      print("Error");
      print(E);
    }

    profileTabUpdateStats();
    notifyListeners();
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

  collabTabTickFinishedCollabSubtask(
      CollabTask collabTask, CollabSubtask collabSubtask) async {
    for (CollabTask ct in userAdapter.user.collabTasks) {
      if (ct.id == collabTask.id) {
        for (CollabSubtask clbSbtsk in ct.collabSubtasks) {
          if (clbSbtsk.id == collabSubtask.id) {
            clbSbtsk = collabSubtask;
          }
        }

        break;
      }
    }
    print("subtask");
    userAdapter.user.stats.numOfSubtasksCompleted += 1;
    profileTabUpdateStats();
    userAdapter.user.collabTasks.add(collabTask);
    userAdapter.user.collabTasks.removeLast();
    collabTabUpdateCollabTask(collabTask);
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

  collabTabUpdateAllTasksProgress() {
    double sumOfProgressPercentages = 0.0;
    int collabTasksCompleted = 0;
    for (CollabTask ct in userAdapter.user.collabTasks) {
      sumOfProgressPercentages += ct.totalProgress;
      collabTasksCompleted += (ct.completed) ? 1 : 0;
    }
    collabTabModel.percentCompletedTasks =
        (userAdapter.user.collabTasks.length == 0)
            ? 0
            : sumOfProgressPercentages / userAdapter.user.collabTasks.length;
    userAdapter.user.stats.numOfCollabTasksCompleted = collabTasksCompleted;
    profileTabUpdateStats();
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

  collabTabUpdateCollabTabState() {
    collabTabModel.collabTabState = (userAdapter.user.collabTasks.length > 0)
        ? CollabTabState.SomeCollabTasks
        : CollabTabState.NoCollabTasks;
  }

  homeTabUpdateHomeState() {
    homeTabModel.homeTabState = (userAdapter.user.soloTasks.length > 0)
        ? HomeTabState.SomeSoloTasks
        : HomeTabState.NoSoloTasks;
  }

  collabTabFetchCollabTasks() async {
    userAdapter.user.collabTasks = await appDatabase.fetchCollabTasks();

    collabTabUpdateAllTasksProgress();
    collabTabUpdateCollabTabState();

    notifyListeners();
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
        await appDatabase.fetchUserInfo(userAdapter.uid);
  }
}

enum SignUpState {
  SigningUp,
  NotSignedUp,
  InvalidSignUp,
  SignedUp,
  SignedUpWithGoogle
}
enum AuthState { LoggedIn, LoggingIn, LoggedOut, LoggingOut, InvalidLogIn }
