import 'package:ProductiveApp/Screens/CollabTab.dart';
import 'package:scoped_model/scoped_model.dart';

class CollabTabModel extends Model {
  CollabTabState collabTabState = CollabTabState.SomeCollabTasks;
  double percentCompletedTasks;

   

}

enum CollabTabState { NoCollabTasks, SomeCollabTasks }
