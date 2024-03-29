import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:progress_indicators/progress_indicators.dart';

class CountdownOver extends StatefulWidget {
  @override
  _CountdownOverState createState() => _CountdownOverState();
}

class _CountdownOverState extends State<CountdownOver> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ScopedModelDescendant<AppModel>(
          builder: (context, snapshot, appModel) {
        return ScopedModelDescendant<PomodoroModel>(
            builder: (context, snapshot, pomModel) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  JumpingText(
                    "Time's up!",
                    style: TextStyle(
                      fontFamily: "QuickSand",
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 50*Globals.dheight,
                    ),
                  ),
                  SizedBox(height: 1),
                  MaterialButton(
                    minWidth: Globals.dwidth * 200,
                    height: Globals.dheight * 60,
                    onPressed: () {
                      FlutterRingtonePlayer.stop();
                      pomModel.confirmOver();
                      appModel.pomodoroTabAcceptFinishedTimer();
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Text("Okay",
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
