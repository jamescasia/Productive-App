import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';

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
                  Text(
                    "Time's up!",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 41,
                    ),
                  ),
                  SizedBox(height: 1),
                  MaterialButton(
                    minWidth: Globals.dwidth * 200,
                    height: Globals.dheight * 60,
                    onPressed: () {
                      pomModel.confirmOver();
                      appModel.pomodoroTabAcceptFinishedTimer();
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Text("Okay",
                        style: TextStyle(
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
