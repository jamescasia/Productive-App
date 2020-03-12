import 'dart:async';

import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';

class Countdowner {
  Timer _timer;
  int timeLeftSeconds;
  Duration timeLeft;
  bool paused;

  PomodoroModel pomModel;

  Function tickCallback;
  Function pauseCallback;
  Function stopCallback;
  Function overCallback;

  Countdowner(
       this.pomModel);

  startCountdown(int durationSeconds) {
    timeLeftSeconds = durationSeconds;
    _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (this.timeLeftSeconds < 1) {
        _timer.cancel();
        pomModel.countdownOverCallback();
      } else {
        this.timeLeftSeconds -= 1;
        pomModel.countdownTickCallback();
      }
    });
  }

  pauseTimer() {
    _timer.cancel();
  }

  resumeTimer() {
    startCountdown(this.timeLeftSeconds);
  }
}
