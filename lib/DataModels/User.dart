import './UserInfo.dart';
import 'package:ProductiveApp/DataModels/SoloTask.dart';
import 'package:ProductiveApp/DataModels/CollabTask.dart';
import 'package:ProductiveApp/DataModels/Stats.dart';
import 'package:ProductiveApp/DataModels/CollabNotification.dart';

class User {
  UserInfo userInfo;
  List<UserInfo> friends = [];
  List<SoloTask> soloTasks = [];
  List<CollabTask> collabTasks = [];
  List<CollabNotification> collabNotification = [];
  Stats stats;

  User() {
    friends = [];
    soloTasks = [];
    collabTasks = [];
    stats = Stats();
    userInfo = UserInfo("","","");
    collabNotification = [];
  }
}
