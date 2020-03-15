import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';
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
      child: ScopedModelDescendant<PomodoroModel>(
          builder: (context, snapshot, pomModel) {
        return Container(
          color: Colors.blue,
          child: MaterialButton(
            onPressed: () {
              pomModel.confirmOver();
            },
            color: Colors.blue,
            shape: CircleBorder(),
            height: Globals.dheight * 90,
          ),
        );
      }),
    );
  }
}
