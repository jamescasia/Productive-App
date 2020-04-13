import 'dart:convert';

import 'package:ProductiveApp/DataModels/AppDatabase.dart';
import 'package:ProductiveApp/ScopedModels/home_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/profile_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/collab_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/tab_changer_model.dart';
import 'package:ProductiveApp/Screens/CollabRewardDialog.dart';
import 'package:ProductiveApp/Screens/LogInScreen.dart';
import 'package:ProductiveApp/Screens/NotificationDialog.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/DataModels/AppAuth.dart';
import 'package:ProductiveApp/DataModels/CollabNotification.dart';
import 'package:ProductiveApp/UtilityModels/UserAdapter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:ProductiveApp/Screens/RewardDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ProductiveApp/DataModels/SoloTask.dart';
import 'package:ProductiveApp/DataModels/CollabTask.dart';
import 'dart:math';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

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
  BuildContext context;
  StreamSubscription collabTablistenForNewCollabTasks;
  StreamSubscription collabTablistenForChangesInCollabTasks;
  StreamSubscription listenForNotifications;
  List<String> collabTaskIds;
  Map<String, bool> collabTasksArchives = {};

  TabChangerModel tabChangerModel;
  AppModel(BuildContext context) {
    initialize();
    initializeUser();
    this.context = context;
  }

  // await collabTablistenForNewCollabTasks();
  // collabTablistenForChangesInCollabTasks();
  // listenForNotifications();
  initialize() {
    collabTaskIds = [];
    tabChangerModel = TabChangerModel();
    pomModel = PomodoroModel();
    homeTabModel = HomeTabModel();
    userAdapter = UserAdapter();
    appAuth = AppAuth();
    appDatabase = AppDatabase();
    profileTabModel = ProfileTabModel();
    collabTabModel = CollabTabModel();
  }

  Future<bool> initializeUser() async {
    if (await isUserLoggedIn()) {
      print("logged in");
      await logInScreenLoginAutomatically();

      return true;
    } else {
      print("not logged in");
      return false;
    }
  }

  initializeListeners() {
    try {
      collabTablistenForNewCollabTasks.cancel();
      collabTablistenForChangesInCollabTasks.cancel();
      listenForNotifications.cancel();
    } catch (e) {}

    collabTablistenForChangesInCollabTasks =
        appDatabase.collabTasksRef.onChildChanged.listen((data) {
      print("changed!");
      for (int i = 0; i < userAdapter.user.collabTasks.length; i++) {
        if (userAdapter.user.collabTasks[i].id == data.snapshot.key) {
          userAdapter.user.collabTasks[i] =
              CollabTask.fromJson(jsonDecode(data.snapshot.value.toString()));
          collabTabUpdateCollabTasks();
        }
      }
    });

    collabTablistenForNewCollabTasks = appDatabase.personalUserRef
        .child('CollabTasks')
        .onChildAdded
        .listen((data) async {
      print("new collab task");
      print(data.snapshot.key.toString());
      CollabTask clb = await appDatabase
          .userFetchCollabTaskUsingId(data.snapshot.key.toString());
      if (!userAdapter.user.collabTasks.contains(clb) &&
          !collabTaskIds.contains(clb.id) &&
          !data.snapshot.value) {
        userAdapter.user.collabTasks.add(clb);
        collabTaskIds.add(clb.id);

        collabTasksArchives[clb.id] = false;
        collabTabUpdateCollabTasks();
      }
    });

    listenForNotifications = appDatabase.personalUserRef
        .child("Notifications")
        .onChildAdded
        .listen((data) {
      print(data.snapshot.value);
      CollabNotification clb = CollabNotification.fromJson(
          jsonDecode(data.snapshot.value.toString()));
      if (authState == AuthState.LoggedIn) {
        showNotificationDialog(clb);
      }
    });
  }

  isUserLoggedIn() async {
    return (await appAuth.isUserLoggedIn());
  }

  logInScreenLoginAutomatically() async {
    authState = AuthState.LoggedIn;
    var loginType = await appAuth.loginType();
    print("the damn login type");
    print(loginType);
    if (loginType == LoginType.Firebase) {
      userAdapter.fUser = await appAuth.currentUser();
      userAdapter.uid = userAdapter.fUser.uid.toString();
    } else if (loginType == LoginType.Google) {
      userAdapter.gUser = await appAuth.currentUser();
      userAdapter.uid = userAdapter.gUser.id.toString();
    }

    print(userAdapter.uid);
    print("the damn user");

    await appDatabase.initializeUserDatabase(userAdapter.uid);
    print(userAdapter.uid);
    print("uid");
    await profileTabFetchUserStats();
    userAdapter.user.stats.numOfLoginsCompleted += 1;
    profileTabUpdateStats();

    await homeTabFetchSoloTasks();
    await collabTabFetchCollabTasks();

    await profileTabFetchUserInfo();
    initializeListeners();
    // await collabTablistenForNewCollabTasks();
    // collabTablistenForChangesInCollabTasks();
    // listenForNotifications();
    // notifyListeners();
  }

  logInScreenLogIn(email, pass) async {
    // initialize();
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

      await profileTabFetchUserIn
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
    FlutterRingtonePlayer.stop();
    try {
      collabTablistenForNewCollabTasks.cancel();
      collabTablistenForChangesInCollabTasks.cancel();
      listenForNotifications.cancel();
    } catch (e) {}
    initialize();

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
    // initialize();
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

      await appDatabase.initializeUserDatabase(userAdapter.uid);
      await profileTabFetchUserStats();
      userAdapter.user.stats.numOfLoginsCompleted += 1;
      profileTabUpdateStats();
      await homeTabFetchSoloTasks();
      // await collabTablistenForNewCollabTasks();

      await collabTabFetchCollabTasks();
      await profileTabFetchUserInfo();
      // collabTablistenForChangesInCollabTasks();

      // listenForNotifications();
      initializeListeners();
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
    // initialize();
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

        authState = AuthState.LoggedIn;
        userAdapter.user.stats.numOfLoginsCompleted += 1;
        profileTabUpdateStats();
        await homeTabFetchSoloTasks();

        await collabTabFetchCollabTasks();
        await profileTabFetchUserInfo();
        initializeListeners();
        // await collabTablistenForNewCollabTasks();
        // collabTablistenForChangesInCollabTasks();
        // listenForNotifications();

        notifyListeners();
        return signUpState;
      } else {
        print(userAdapter.gUser);

        signUpState = SignUpState.SignedUp;

        await appDatabase.addNewUser(userAdapter.gUser.displayName,
            userAdapter.gUser.email.toString(), userAdapter.uid);
        await appDatabase.initializeUserDatabase(userAdapter.uid);
        userAdapter.user.stats.numOfLoginsCompleted += 1;

        authState = AuthState.LoggedIn;
        await profileTabFetchUserStats();
        profileTabUpdateStats();
        await homeTabFetchSoloTasks();
        // await collabTablistenForNewCollabTasks();
        await profileTabFetchUserInfo();

        await collabTabFetchCollabTasks();
        // collabTablistenForChangesInCollabTasks();

        // listenForNotifications();
        initializeListeners();

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
    // initialize();
    try {
      signUpState = SignUpState.SigningUp;
      print(signUpState);
      notifyListeners();

      userAdapter.fUser = await appAuth.signUpWithEmailAndPass(email, pass);

      print(userAdapter.fUser);

      userAdapter.uid = userAdapter.fUser.uid.toString();

      signUpState = SignUpState.SignedUp;

      authState = AuthState.LoggedIn;
      await appDatabase.addNewUser(
          username, userAdapter.fUser.email.toString(), userAdapter.uid);
      await appDatabase.initializeUserDatabase(userAdapter.uid);
      userAdapter.user.stats.numOfLoginsCompleted += 1;

      await profileTabFetchUserStats();
      profileTabUpdateStats();
      await homeTabFetchSoloTasks();
      // await collabTablistenForNewCollabTasks();
      await profileTabFetchUserInfo();

      // collabTablistenForChangesInCollabTasks();

      await collabTabFetchCollabTasks();
      // listenForNotifications();
      initializeListeners();
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
    // userAdapter.user.collabTasks.add(collabTask);
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
    print(collabSubtask.assignedName);
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

  homeTabDeleteSoloSubtask(SoloTask soloTask, Subtask subtask) async {
    for (SoloTask st in userAdapter.user.soloTasks) {
      if (st.id == soloTask.id) {
        st.subtasks.remove(subtask);
        await homeTabUpdateSoloTask(st);

        break;
      }
    }
  }

  homeTabEditSoloTask(SoloTask soloTask) async {
    print("edited solo ask");
    print(soloTask.title);
    print(soloTask.completed);
    for (SoloTask st in userAdapter.user.soloTasks) {
      if (st.id == soloTask.id) {
        st = soloTask;

        homeTabUpdateSoloTask(st);

        break;
      }
    }
  }

  collabTabEditCollabTask(CollabTask collabTask) async {
    for (CollabTask ct in userAdapter.user.collabTasks) {
      if (ct.id == collabTask.id) {
        ct = collabTask;

        collabTabUpdateCollabTask(ct);

        break;
      }
    }
  }

  collabTabDeleteCollabSubtask(
      CollabTask collabTask, CollabSubtask collabSubtask) async {
    for (CollabTask ct in userAdapter.user.collabTasks) {
      if (ct.id == collabTask.id) {
        ct.collabSubtasks.remove(collabSubtask);
        await collabTabUpdateCollabTask(ct);

        break;
      }
    }
  }

  collabTabDeleteCollabTask(CollabTask collabTask) async {
    userAdapter.user.collabTasks.remove(collabTask);
    try {
      await appDatabase.deleteCollabTask(collabTask);

      collabTabUpdateAllTasksProgress();
    } catch (E) {
      print("Error");
      print(E);
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
        completedCollabSubtasks == collabTask.collabSubtasks.length &&
            collabTask.collabSubtasks.length > 0;

    try {
      await appDatabase.updateCollabTask(collabTask);

      // collabTabUpdateAllTasksProgress();
      subCollabTabUpdateAllTasksProgress();
    } catch (E) {
      print("Error");
      print(E);
    }

    profileTabUpdateStats();
    notifyListeners();
  }

  homeTabDeleteSoloTask(SoloTask soloTask) async {
    userAdapter.user.soloTasks.remove(soloTask);
    try {
      await appDatabase.deleteSoloTask(soloTask);

      homeTabUpdateAllTasksProgress();
    } catch (E) {
      print("Error");
      print(E);
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
    soloTask.completed = (completedSubtasks == soloTask.subtasks.length &&
        soloTask.subtasks.length > 0);

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

  subCollabTabUpdateAllTasksProgress() {
    double sumOfProgressPercentages = 0.0;
    for (CollabTask ct in userAdapter.user.collabTasks) {
      sumOfProgressPercentages += ct.totalProgress;
    }
    collabTabModel.percentCompletedTasks =
        (userAdapter.user.collabTasks.length == 0)
            ? 0
            : sumOfProgressPercentages / userAdapter.user.collabTasks.length;
    profileTabUpdateStats();
    collabTabUpdateCollabTabState();
  }

  collabTabUpdateAllTasksProgress() {
    double sumOfProgressPercentages = 0.0;
    // int collabTasksCompleted = 0;
    for (CollabTask ct in userAdapter.user.collabTasks) {
      sumOfProgressPercentages += ct.totalProgress;

      if (ct.completed) {
        if (!collabTasksArchives[ct.id]) {
          showCollabReward(ct);
        }
        userAdapter.user.stats.numOfCollabTasksCompleted += 1;
      }
    }
    collabTabModel.percentCompletedTasks =
        (userAdapter.user.collabTasks.length == 0)
            ? 0
            : sumOfProgressPercentages / userAdapter.user.collabTasks.length;
    profileTabUpdateStats();
    collabTabUpdateCollabTabState();
  }

  homeTabUpdateAllTasksProgress() {
    double sumOfProgressPercentages = 0.0;
    for (SoloTask st in userAdapter.user.soloTasks) {
      sumOfProgressPercentages += st.totalProgress;
      if (st.completed) {
        if (!st.archived) {
          showReward(st);
        }
      }
    }
    homeTabModel.percentCompletedTasks =
        (userAdapter.user.soloTasks.length == 0)
            ? 0
            : sumOfProgressPercentages / userAdapter.user.soloTasks.length;
    profileTabUpdateStats();
    homeTabUpdateHomeState();
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
    userAdapter.user.collabTasks.forEach((clb) {
      if (!collabTaskIds.contains(clb.id)) {
        collabTaskIds.add(clb.id);
        collabTasksArchives[clb.id] = false;
      }
    });

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
  }

  profileTabFetchUserInfo() async {
    userAdapter.user.userInfo =
        await appDatabase.fetchUserInfo(userAdapter.uid);
  }

  collabTabCheckUserExists(String email) async {
    return await appDatabase.userExistsThruEmail(email);
  }

  collabTabFetchNameThroughUid(String uid) async {
    return await appDatabase.userFetchName(uid);
  }

  collabTabAddCollabTaskToCollaborator(
      String uid, CollabTask collabTask) async {
    await appDatabase.userAddCollabTaskToCollaborator(uid, collabTask);
  }

  showNotifications() {
    List<String> showed = [];

    userAdapter.user.collabNotification.forEach((collabNotif) {
      if (!showed.contains(collabNotif.taskName)) {
        showNotificationDialog(collabNotif);
        showed.add(collabNotif.taskName);
      }
    });
    userAdapter.user.collabNotification = <CollabNotification>[];
  }

  showNotificationDialog(CollabNotification collabNotif) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: NotificationDialog(this, collabNotif, UniqueKey())),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  collabTabUpdateCollabTasks() {
    collabTabUpdateAllTasksProgress();
    collabTabUpdateCollabTabState();
    notifyListeners();
  }

  collabTabNotifyUser(String uid, String taskName, String message) async {
    print("num of collab tasksd");
    print(userAdapter.user.collabTasks.length);
    appDatabase.notifyUser(
        uid,
        CollabNotification(
            taskName, DateTime.now().toIso8601String(), message));
  }

  fetchCollabNotifications() async {
    try {
      userAdapter.user.collabNotification =
          await appDatabase.fetchNotifications(userAdapter.uid);
    } catch (E) {}
  }

  confirmReadNotification(CollabNotification notif) async {
    List<CollabNotification> newList = [];

    userAdapter.user.collabNotification.forEach((clbNotif) {
      if (clbNotif.taskName.replaceAll('"', "") !=
          notif.taskName.replaceAll('"', "")) {
        newList.add(clbNotif);
      }
    });

    userAdapter.user.collabNotification = newList;

    await appDatabase.deleteNotification(notif.taskName);
  }

  collabTabArchiveCollabTask(CollabTask collabTask) async {
    List<CollabTask> temp = [];
    userAdapter.user.collabTasks.forEach((ct) {
      if (collabTask.id != ct.id) {
        temp.add(ct);
      }
    });
    userAdapter.user.collabTasks = temp;
    collabTasksArchives[collabTask.id] = true;
    collabTabUpdateAllTasksProgress();

    await appDatabase.archiveCollabTask(collabTask);
  }

  homeTabArchiveSoloTask(SoloTask soloTask) async {
    List<SoloTask> temp = [];
    userAdapter.user.soloTasks.forEach((st) {
      if (soloTask.id != st.id) {
        temp.add(st);
      }
    });
    userAdapter.user.soloTasks = temp;
    homeTabUpdateAllTasksProgress();

    await appDatabase.archiveSoloTask(soloTask);
  }

  showCollabReward(CollabTask ct) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: CollabRewardDialog(
                    AppData
                        .rewards[Random().nextInt(AppData.rewards.length - 1)],
                    ct,
                    this),
              ));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  showReward(SoloTask st) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: RewardDialog(
                    AppData
                        .rewards[Random().nextInt(AppData.rewards.length - 1)],
                    st,
                    this),
              ));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
    // homeTabUpdateAllTasksProgress();
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
