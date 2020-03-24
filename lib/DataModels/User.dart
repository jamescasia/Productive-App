import './UserInfo.dart';
import 'package:ProductiveApp/DataModels/SoloTask.dart';
import 'package:ProductiveApp/DataModels/GroupTask.dart';
import 'package:ProductiveApp/DataModels/Stats.dart';

class User {
  UserInfo userInfo;
  List<UserInfo> friends = [];
  List<SoloTask> soloTasks = [];
  List<GroupTask> groupTasks = [];
  Stats stats;

  User() {
    friends = [];
    soloTasks = [];
    groupTasks = [];
    stats = Stats();
    userInfo = UserInfo("","","");
  }
}
