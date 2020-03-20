import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/UtilityModels/UserAdapter.dart';

class AppModel extends Model {
  PomodoroModel pomModel;
  AppModel() {
    print("Appmodel is built");
    pomModel = PomodoroModel();
  }

  UserAdapter userAdapter;
}
