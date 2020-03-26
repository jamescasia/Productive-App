import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
// import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:ProductiveApp/Libraries/Slide_countdown/slide_countdown_clock.dart';

import 'package:ProductiveApp/Libraries/Slide_countdown/slide_direction.dart';

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
                    top: 30 * Globals.dheight,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: (pomModel.countdownState == CountdownState.Paused)
                        ? Center(
                            child: Text(
                              pomModel.timeLeftDuration
                                  .toString()
                                  .substring(2, 7),
                              style: TextStyle(fontFamily:"QuickSand",
                                  fontSize: 70,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          )
                        : SlideCountdownClocks(
                            tightLabel: true,
                            shouldShowDays: false,
                            duration: pomModel.timeLeftDuration,
                            slideDirection: SlideDirection.Up,
                            separator: ":",
                            textStyle: TextStyle(fontFamily:"QuickSand",
                                fontSize: 70,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                MaterialButton(
                  height: Globals.dheight * 160,
                  onPressed: () {
                    pomModel.stopTimer();
                  },
                  shape: CircleBorder(),
                  color: Colors.grey[400],
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontFamily:"QuickSand",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                MaterialButton(
                  height: Globals.dheight * 160,
                  onPressed: () {
                    if (pomModel.countdownState == CountdownState.Paused) {
                      pomModel.resumeTimer();
                    } else if (pomModel.countdownState ==
                        CountdownState.Playing) {
                      pomModel.pauseTimer();
                    }
                  },
                  shape: CircleBorder(),
                  color: (pomModel.countdownState == CountdownState.Paused)
                      ? Colors.greenAccent[700]
                      : Colors.yellow[800],
                  child: Text(
                    (pomModel.countdownState == CountdownState.Paused)
                        ? "Resume"
                        : "Pause",
                    style: TextStyle(fontFamily:"QuickSand",
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
