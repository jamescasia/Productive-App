import 'package:ProductiveApp/DataModels/SoloTask.dart';
import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/ScopedModels/home_tab_model.dart';
import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import './TipView.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';

class SubtaskCompletedDialog extends StatefulWidget {
  AppModel appModel;
  SoloTask soloTask;
  Subtask subtask;
  SubtaskCompletedDialog(this.appModel, this.soloTask, this.subtask);
  @override
  _SubtaskCompletedDialogState createState() =>
      _SubtaskCompletedDialogState(this.appModel, this.soloTask, this.subtask);
}

class _SubtaskCompletedDialogState extends State<SubtaskCompletedDialog> {
  AppModel appModel;
  SoloTask soloTask;
  Subtask subtask;
  _SubtaskCompletedDialogState(this.appModel, this.soloTask, this.subtask);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.all(Globals.dheight * 18),
        width: Globals.width * 0.9,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "Finished?",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: Globals.dheight * 15,
          ),
          MaterialButton(
            color: Colors.green[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            onPressed: () async {
              subtask.completed = true;

              Navigator.pop(context);

              await appModel.homeTabTickFinishedSubtask(soloTask, subtask);
            },
            height: Globals.dheight * 40,
            minWidth: Globals.width * 0.7,
            child: Text(
              "Yes",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
          ),
          MaterialButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            height: Globals.dheight * 40,
            minWidth: Globals.width * 0.7,
            child: Text(
              "Not Yet",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
          )
        ]),
        // decoration: BoxDecoration(
        //   color: Colors.red,
        // ),
      ),
    );
  }
}
