import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/pomodoro_tab_model.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';
import './TimePicker.dart';
import './CountdownShow.dart';

class PomodoroTab extends StatefulWidget {
  @override
  _PomodoroTabState createState() => _PomodoroTabState();
}

class _PomodoroTabState extends State<PomodoroTab> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<PomodoroModel>(
        model: PomodoroModel(),
        child: ScopedModelDescendant<PomodoroModel>(
            builder: (context, snapshot, pomModel) {
          return Material(
            child: (pomModel.pomodoroState == PomodoroState.CountingDown)? CountdownShow(): TimePicker()
          );
        }));
  }
}
