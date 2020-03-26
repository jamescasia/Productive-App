import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/DataModels/CollabTask.dart';
import 'package:ProductiveApp/DataModels/CollabTask.dart';
import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/ScopedModels/home_tab_model.dart';
import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:ProductiveApp/DataModels/CollabNotification.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';

class CollabRewardDialog extends StatefulWidget {
  Reward reward;
  CollabTask collabTask;
  AppModel appModel;

  CollabRewardDialog(this.reward, this.collabTask, this.appModel);
  @override
  _CollabRewardDialogState createState() =>
      _CollabRewardDialogState(this.reward, this.collabTask, this.appModel);
}

class _CollabRewardDialogState extends State<CollabRewardDialog> {
  Reward reward;
  CollabTask collabTask;
  AppModel appModel;
  _CollabRewardDialogState(this.reward, this.collabTask, this.appModel);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.all(Globals.dheight * 18),
        width: Globals.width * 0.9,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "${reward.message} You deserve it.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "QuickSand",
                color: Colors.black,
                fontSize: 26 * Globals.dheight,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: Globals.dheight * 30),
          Image.asset(
            reward.imagePath,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(
            height: Globals.dheight * 15,
          ),
          SizedBox(height: Globals.dheight * 30),
          MaterialButton(
            color: Colors.green[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            onPressed: () async {
              await appModel.collabTabArchiveCollabTask(collabTask);
              Navigator.pop(context);
            },
            height: Globals.dheight * 40,
            // minWidth: Globals.width * 0.7,
            child: Text(
              "Alright",
              style: TextStyle(
                  fontFamily: "QuickSand",
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ]),
        // decoration: BoxDecoration(
        //   color: Colors.red,
        // ),
      ),
    );
  }
}
