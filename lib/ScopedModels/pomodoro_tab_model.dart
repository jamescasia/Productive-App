import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class PomodoroModel extends Model {
  int completedCtr = 0;
  Duration durationPicked;
  PomodoroState pomodoroState;
  CountdownState countdownState;

  Timer pomTimer;
  Duration lastSetDuration = Duration(seconds: 30, minutes: 1);
  Duration timeLeftDuration;
  bool paused;

  PomodoroModel() { 
    this.pomodoroState = PomodoroState.SetTimer;
    this.countdownState = CountdownState.Neutral;
  }

  startCountdown(Duration countdownLength) {
    try {
      if (this.pomTimer.isActive) this.pomTimer.cancel();
    } catch (e) {}
    this.pomodoroState = PomodoroState.CountingDown;
    this.countdownState = CountdownState.Playing;
    this.timeLeftDuration = countdownLength;
    notifyListeners();

    this.pomTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      print("ruiining");

      if (this.timeLeftDuration < Duration(seconds: 1)) {
        finishedTimer();
      } else if (this.countdownState == CountdownState.Playing) {
        this.timeLeftDuration -= Duration(seconds: 1);
        tickCallback();
      }
    });
  }

  pauseTimer() {
    this.countdownState = CountdownState.Paused;
    pomTimer.cancel();
    notifyListeners();
  }

  finishedTimer() {
    this.pomodoroState = PomodoroState.CountdownOver;
    this.countdownState = CountdownState.Neutral;
    pomTimer.cancel();
    notifyListeners();
  }

  stopTimer() {
    this.countdownState = CountdownState.Neutral;
    this.pomodoroState = PomodoroState.SetTimer;
    // set timepicker to last

    pomTimer.cancel();
    notifyListeners();
  }

  resumeTimer() {
    this.countdownState = CountdownState.Playing;

    startCountdown(this.timeLeftDuration);
    notifyListeners();
  }

  tickCallback() {
    print("time left:");
    print("time lefts:");
    print(this.timeLeftDuration.toString());
    notifyListeners();
  }

  secondsToDuration(int seconds) {
    return Duration(seconds: seconds);
  }

  confirmOver() {
    this.pomodoroState = PomodoroState.SetTimer;
    notifyListeners();
  }
}

enum PomodoroState { SetTimer, CountingDown, CountdownOver }
enum CountdownState { Paused, Playing, Neutral }
