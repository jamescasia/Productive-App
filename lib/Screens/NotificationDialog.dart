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

class NotificationDialog extends StatefulWidget {
  AppModel appModel;
  CollabNotification collabNotif;
  Key key;

  NotificationDialog(this.appModel, this.collabNotif, this.key);
  @override
  _NotificationDialogState createState() =>
      _NotificationDialogState(this.appModel, this.collabNotif);
}

class _NotificationDialogState extends State<NotificationDialog> {
  AppModel appModel;
  CollabNotification collabNotif;
  _NotificationDialogState(this.appModel, this.collabNotif);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.amber[200],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.all(Globals.dheight * 18),
        width: Globals.width * 0.9,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "You've been dinged!",
            style: TextStyle(
                color: Colors.black,
                fontSize: 26 * Globals.dheight,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: Globals.dheight * 30),
          Icon(
            FontAwesomeIcons.conciergeBell,
            size: Globals.dheight * 80,
            color: Colors.grey[700],
          ),
          SizedBox(
            height: Globals.dheight * 15,
          ),
          Text(
            "A gentle reminder to do your part in ${collabNotif.taskName.replaceAll('""', "")} task.",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18 * Globals.dheight,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Globals.dheight * 30),
          MaterialButton(
            color: Colors.green[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            onPressed: () async {
              appModel.confirmReadNotification(this.collabNotif);
              Navigator.pop(context);
            },
            height: Globals.dheight * 40,
            // minWidth: Globals.width * 0.7,
            child: Text(
              "Got it",
              style: TextStyle(
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
