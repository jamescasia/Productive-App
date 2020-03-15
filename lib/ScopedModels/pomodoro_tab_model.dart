import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class PomodoroModel extends Model {
  int completedCtr = 0;
  Duration durationPicked;
  PomodoroState pomodoroState;
  CountdownState countdownState;

  Timer pomTimer;
  int timeLeftSeconds;
  Duration lastSetDuration = Duration(seconds: 30, minutes: 1);
  Duration timeLeftDuration;
  bool paused;

  PomodoroModel() {
    print("pommodel is built!");
    this.pomodoroState = PomodoroState.SetTimer;
    this.countdownState = CountdownState.Neutral;
  }

  startCountdown(Duration countdownLength) {
    try {
      if (this.pomTimer.isActive) this.pomTimer.cancel();
    } catch (e) {}
    this.pomodoroState = PomodoroState.CountingDown;
    this.countdownState = CountdownState.Playing;
    this.timeLeftSeconds = countdownLength.inSeconds;
    this.timeLeftDuration = countdownLength;
    notifyListeners();

    this.pomTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      print("ruiining");

      if (this.timeLeftSeconds < 1) {
        finishedTimer();
      } else if (this.countdownState == CountdownState.Playing) {
        this.timeLeftSeconds -= 1;
        tickCallback();
      }
    });
  }

  pauseTimer() {
    this.timeLeftDuration = this.secondsToDuration(this.timeLeftSeconds);
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

    startCountdown(this.secondsToDuration(this.timeLeftSeconds));
    notifyListeners();
  }

  tickCallback() {
    print("time left:");
    print(this.timeLeftSeconds);
    print("time lefts:");
    print(this.timeLeftDuration.toString());
    this.timeLeftDuration = this.secondsToDuration(this.timeLeftSeconds);
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
