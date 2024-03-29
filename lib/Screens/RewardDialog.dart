import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/DataModels/CollabTask.dart';
import 'package:ProductiveApp/DataModels/SoloTask.dart';
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

class RewardDialog extends StatefulWidget {
  Reward reward;
  SoloTask soloTask;
  AppModel appModel;

  RewardDialog(this.reward, this.soloTask, this.appModel);
  @override
  _RewardDialogState createState() =>
      _RewardDialogState(this.reward, this.soloTask, this.appModel);
}

class _RewardDialogState extends State<RewardDialog> {
  Reward reward;
  SoloTask soloTask;
  AppModel appModel;
  _RewardDialogState(this.reward, this.soloTask, this.appModel);

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
              await appModel.homeTabArchiveSoloTask(soloTask);
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
