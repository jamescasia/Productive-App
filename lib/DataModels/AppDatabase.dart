import 'package:firebase_database/firebase_database.dart';

class AppDatabase {
  FirebaseDatabase fDatabase;
  DatabaseReference personalUserRef;
  DatabaseReference userDataRef;
  DatabaseReference tasksRef;
  DatabaseReference usersRef;

  AppDatabase() {
    fDatabase = FirebaseDatabase.instance;
    userDataRef = fDatabase.reference().child('App/UserData');
    tasksRef = fDatabase.reference().child('App/Tasks');
    usersRef = fDatabase.reference().child('App/Users');
  }

  initializeUserDatabase(String uid) {
    personalUserRef = fDatabase.reference().child('App/UserData/${uid}');
  }

  addNewUser(String name, String email, String uid) {
    usersRef.child(uid).set(name);
    userDataRef.child(uid).set({
      "Friends": {"dummyUid1": "dummyName1", "dummyUid2": "dummyName2"},
      "GroupTasks": {"dummyGroupTask1": false},
      "UserInfo": {"email": email, "name": name, "ppID": 0},
      "SoloTasks": {"dummySoloTask1": false},
      "LoginLog": {"dummyTimestamp1": "dummyTimestampValue"}
    });
  }
}
