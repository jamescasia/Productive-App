import 'package:scoped_model/scoped_model.dart';

class PomodoroModel extends Model {
  int completedCtr = 0;
  Duration durationPicked;
  PomodoroState pomodoroState;

//for timer, I call appmodel to start a timer, then it calls something here
//
  countdownTickCallback(){
    notifyListeners();
  }
  countdownOverCallback() {
    notifyListeners();
  }
}

enum PomodoroState { SetTimer, CountingDown }
