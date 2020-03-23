import 'package:ProductiveApp/Screens/HomeTab.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTabModel extends Model {
  HomeTabState homeTabState = HomeTabState.SomeSoloTasks;
  double percentCompletedTasks;

   

}

enum HomeTabState { NoSoloTasks, SomeSoloTasks }
