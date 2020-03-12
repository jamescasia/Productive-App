import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (context, snapshot, appModel) {
      return ScopedModelDescendant<PomodoroModel>(
          builder: (context, snapshot, pomModel) {
        return Material(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Globals.dheight * 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/app_icons/clock_icon.png",
                        width: Globals.dwidth * 40,
                        height: Globals.dheight * 40,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        pomModel.completedCtr.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      )
                    ]),
                Image.asset(
                  "assets/app_icons/clock_icon.png",
                  height: 0.4 * Globals.height,
                ),
                Center(
                  // padding: const EdgeInsets.only(left: 60),
                  child: ClipRRect(
                    child: Container(
                      width: Globals.width * 0.7,
                      height: Globals.height * 0.14,
                      decoration: BoxDecoration(
                          // color: Colors.red
                          ),
                      child: CupertinoTimerPicker(
                        // backgroundColor: Colors.red,
                        mode: CupertinoTimerPickerMode.ms,
                        minuteInterval: 1,
                        secondInterval: 1,
                        initialTimerDuration: pomModel.lastSetDuration,
                        onTimerDurationChanged: (Duration changedtimer) {
                          pomModel.lastSetDuration = changedtimer;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Globals.dheight * 40),
                MaterialButton(
                  minWidth: Globals.dwidth * 200,
                  height: Globals.dheight * 40,
                  onPressed: () {
                    pomModel.startCountdown(pomModel.lastSetDuration);
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Text("Start Timer",
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
    });
  }
}
