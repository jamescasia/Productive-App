import './UserInfo.dart';
import 'package:ProductiveApp/DataModels/SoloTask.dart';
import 'package:ProductiveApp/DataModels/CollabTask.dart';
import 'package:ProductiveApp/DataModels/Stats.dart';

class User {
  UserInfo userInfo;
  List<UserInfo> friends = [];
  List<SoloTask> soloTasks = [];
  List<CollabTask> collabTasks = [];
  Stats stats;

  User() {
    friends = [];
    soloTasks = [];
    collabTasks = [];
    stats = Stats();
    userInfo = UserInfo("","","");
  }
}
