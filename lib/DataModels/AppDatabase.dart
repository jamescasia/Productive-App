import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'package:ProductiveApp/DataModels/SoloTask.dart';
import 'package:ProductiveApp/DataModels/Stats.dart';

import 'package:ProductiveApp/DataModels/UserInfo.dart';

import 'CollabTask.dart';

class AppDatabase {
  FirebaseDatabase fDatabase;
  DatabaseReference personalUserRef;
  DatabaseReference userDataRef;
  DatabaseReference collabTasksRef;
  DatabaseReference soloTasksRef;
  DatabaseReference usersRef;
  String userId;

  AppDatabase() {
    fDatabase = FirebaseDatabase.instance;
    userDataRef = fDatabase.reference().child('App/UserData');
    soloTasksRef = fDatabase.reference().child('App/Tasks/SoloTasks');
    collabTasksRef = fDatabase.reference().child('App/Tasks/CollabTasks');
    usersRef = fDatabase.reference().child('App/Users');
  }

  initializeUserDatabase(String uid) {
    userId = uid;
    personalUserRef = fDatabase.reference().child('App/UserData/${uid}');
  }

  addNewUser(String name, String email, String uid) {
    usersRef.child(uid).set(email);
    Stats stats = Stats();
    userDataRef.child(uid).set({
      "Friends": {"dummyUid1": "dummyName1", "dummyUid2": "dummyName2"},
      // "GroupTasks": {"dummyGroupTask1": false},
      "UserInfo": UserInfo(name, email, "ppID").toJson(),
      // "SoloTasks": {"dummySoloTask1": false},
      "Stats": stats.toJson(),
      "LoginLog": {"dummyTimestamp1": "dummyTimestampValue"}
    });
  }

  addNewSoloTask(SoloTask soloTask) {
    var key = personalUserRef.child('SoloTasks').push().key;
    print("key");
    print(key);
    soloTask.id = key;
    personalUserRef.child('SoloTasks/$key').set(false);
    soloTasksRef.child(key).set(soloTask.toJson());
  }

  addNewCollabTask(CollabTask collabTask) {
    var key = personalUserRef.child('CollabTasks').push().key;
    print("key");
    print(key);
    collabTask.id = key;
    personalUserRef.child('CollabTasks/$key').set(false);
    collabTasksRef.child(key).set(collabTask.toJson());
  }

  updateCollabTask(CollabTask collabTask) {
    personalUserRef
        .child('CollabTasks/${collabTask.id}')
        .set(collabTask.completed);
    collabTasksRef.child(collabTask.id).set(collabTask.toJson());
    print("solo task in json");
    print(collabTask.toJson());
  }

  updateSoloTask(SoloTask soloTask) {
    personalUserRef.child('SoloTasks/${soloTask.id}').set(soloTask.completed);
    soloTasksRef.child(soloTask.id).set(soloTask.toJson());
    print("solo task in json");
    print(soloTask.toJson());
  }

  fetchCollabTasks() async {
    List<String> listOfCollabTaskIds = [];

    List<CollabTask> listOfCollabTasks = [];

    try {
      await personalUserRef.child("CollabTasks").once().then((data) {
        // print("collabtasks");
        // print(data.value);
        data.value.forEach((k, value) {
          listOfCollabTaskIds.add(k.toString());
        });
      });

      print(listOfCollabTaskIds);

      await collabTasksRef.once().then((data) {
        data.value.forEach((k, value) {
          // print(k);
          // print(value);
          if (listOfCollabTaskIds.contains(k.toString())) {
            CollabTask cT = CollabTask.fromJson(jsonDecode(value.toString()));
            listOfCollabTasks.add(cT);
          }
        });
      });
    } catch (E) {
      print("error fetching collab tasks ${E.toString()}");
    }

    return listOfCollabTasks;
  }

  fetchSoloTasks() async {
    List<String> listOfSoloTaskIds = [];

    List<SoloTask> listOfSoloTasks = [];

    try {
      await personalUserRef.child("SoloTasks").once().then((data) {
        // print("solotasks");
        // print(data.value);
        data.value.forEach((k, value) {
          listOfSoloTaskIds.add(k.toString());
        });
      });

      print(listOfSoloTaskIds);

      await soloTasksRef.once().then((data) {
        data.value.forEach((k, value) {
          // print(k);
          // print(value);
          if (listOfSoloTaskIds.contains(k.toString())) {
            SoloTask sT = SoloTask.fromJson(jsonDecode(value.toString()));
            listOfSoloTasks.add(sT);
          }
        });
      });
    } catch (E) {
      print("error fetching solo tasks ${E.toString()}");
    }

    return listOfSoloTasks;
  }

  fetchUserStats() async {
    Stats stats;

    try {
      await personalUserRef.child("Stats").once().then((data) {
        stats = Stats.fromJson(jsonDecode(data.value.toString()));
      });
    } catch (e) {
      print(e);
    }
    return stats;
  }

  updateUserStats(Stats stats) async {
    personalUserRef.child('Stats').set(stats.toJson());
  }

  fetchUserInfo(String uid) async {
    UserInfo userInfo;

    try {
      await personalUserRef.child("UserInfo").once().then((data) {
        userInfo = UserInfo.fromJson(jsonDecode(data.value.toString()));
      });
    } catch (e) {
      print(e);
    }
    return userInfo;
  }

  userExists(String uid) async {
    var exists;
    try {
      await usersRef.once().then((data) {
        exists = data.value[uid] != null;
      });
    } catch (E) {
      exists = false;
    }
    print(exists);
    return exists;
  }
}
