import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';

class CountdownShow extends StatefulWidget {
  @override
  _CountdownShowState createState() => _CountdownShowState();
}

class _CountdownShowState extends State<CountdownShow> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PomodoroModel>(
        builder: (context, snapshot, pomModel) {
      return Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      "assets/app_icons/clock_icon.png",
                      height: 0.4 * Globals.height,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: (pomModel.countdownState == CountdownState.Paused)
                        ? Text(
                            pomModel.timeLeftDuration
                                .toString()
                                .substring(2, 7),
                            style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          )
                        : SlideCountdownClock(
                            tightLabel: true,
                            shouldShowDays: false,
                            duration: pomModel.timeLeftDuration,
                            slideDirection: SlideDirection.Up,
                            separator: ":",
                            textStyle: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                MaterialButton(
                  height: Globals.dheight * 140,
                  onPressed: () {
                    pomModel.stopTimer();
                  },
                  shape: CircleBorder(),
                  color: Colors.grey[400],
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                MaterialButton(
                  height: Globals.dheight * 140,
                  onPressed: () {
                    if (pomModel.countdownState == CountdownState.Paused) {
                      pomModel.resumeTimer();
                    } else if (pomModel.countdownState ==
                        CountdownState.Playing) {
                      pomModel.pauseTimer();
                    }
                  },
                  shape: CircleBorder(),
                  color: Colors.yellow[800],
                  child: Text(
                    (pomModel.countdownState == CountdownState.Paused)
                        ? "Resume"
                        : "Pause",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ])
            ],
          ),
        ),
      );
    });
  }
}
