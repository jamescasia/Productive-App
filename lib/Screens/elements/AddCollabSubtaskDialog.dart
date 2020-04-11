import 'package:ProductiveApp/DataModels/CollabTask.dart';
import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/ScopedModels/home_tab_model.dart';
import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import '../TipView.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';

enum UserExistence { NotExist, Exist, Undefined }

class AddCollabSubtaskDialog extends StatefulWidget {
  AppModel appModel;
  CollabTask collabTask;
  AddCollabSubtaskDialog(this.appModel, this.collabTask);
  @override
  _AddCollabSubtaskDialogState createState() =>
      _AddCollabSubtaskDialogState(this.appModel, this.collabTask);
}

class _AddCollabSubtaskDialogState extends State<AddCollabSubtaskDialog> {
  AppModel appModel;
  CollabTask collabTask;
  UserExistence userExists = UserExistence.Undefined;
  String userUid;
  String userName;
  _AddCollabSubtaskDialogState(this.appModel, this.collabTask);
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  TextEditingController taskAssignedController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CupertinoDatePicker(
            onDateTimeChanged: (DateTime value) {
              setState(() {
                selectedDate = value;
              });
            },
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            maximumYear: 2025,
            minimumYear: 2020,
          );
        });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.parse(collabTask.deadline));
    if (picked != null )
      setState(() {
        var month = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec"
        ];
        selectedDate = picked;
        taskDateController.text =
            "${month[selectedDate.month - 1]} ${selectedDate.day}, ${selectedDate.year} ";
      });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.all(Globals.dheight * 18),
        width: Globals.width * 0.9,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Break it down!",
              style: TextStyle(fontFamily:"QuickSand",fontSize: 18, color: Colors.grey[600])),
          SizedBox(height: Globals.dheight * 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: Globals.dheight * 7),
            height: Globals.dheight * 40,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey[400])),
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            width: Globals.width * 0.8,
            child: Center(
              child: TextField(style:TextStyle(fontFamily:"QuickSand"),
                controller: taskTitleController,
                decoration: new InputDecoration.collapsed(hintText: 'title'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: Globals.dheight * 7),
            height: Globals.dheight * 40,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: (userExists == UserExistence.Exist)
                        ? Colors.green[200]
                        : (userExists == UserExistence.NotExist)
                            ? Colors.red[200]
                            : Colors.grey[400])),
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            width: Globals.width * 0.8,
            child: Center(
              child: TextField(style:TextStyle(fontFamily:"QuickSand"),
                controller: taskAssignedController,
                onChanged: (text) async {
                  await Future.delayed(Duration(milliseconds: 1500));
                  var result = await appModel.collabTabCheckUserExists(text);
                  userExists = (result["exists"])
                      ? UserExistence.Exist
                      : UserExistence.NotExist;
                  userUid = result["uid"];
                  print("yuid");
                  print(userUid);
                  try {
                    setState(() {});
                  } catch (e) {}
                },
                decoration:
                    new InputDecoration.collapsed(hintText: 'assigned email'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: Globals.dheight * 7),
            height: Globals.dheight * 40,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey[400])),
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            width: Globals.width * 0.8,
            child: Center(
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectDate(context);
                  // _showDatePicker(context);
                },
                child: TextField(style:TextStyle(fontFamily:"QuickSand"),
                  focusNode: null,
                  enabled: false,
                  controller: taskDateController,
                  decoration:
                      new InputDecoration.collapsed(hintText: 'due date'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Globals.dheight * 15,
          ),
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    height: Globals.dheight * 40,
                    minWidth: Globals.width * 0.8 * 0.42,
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontFamily:"QuickSand",
                          color: Colors.white,
                          fontSize: Globals.dheight * 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(width: Globals.dwidth * 8),
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    color: Colors.green[400],
                    disabledColor: Colors.green[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    onPressed: (userExists == UserExistence.Exist)
                        ? () async {
                            String name = await appModel
                                .collabTabFetchNameThroughUid(userUid);

                            print("addiong subtask");
                            print(name);
                            var collabSubtask = await CollabSubtask(
                                "0",
                                taskTitleController.text.toString(),
                                selectedDate.toIso8601String(),
                                name,
                                userUid,
                                false);
                            await appModel.collabTabAddCollabSubTask(
                                collabTask, collabSubtask);
                            await appModel.collabTabAddCollabTaskToCollaborator(
                                userUid, collabTask);
                            Navigator.pop(context);
                          }
                        : null,
                    height: Globals.dheight * 40,
                    minWidth: Globals.width * 0.8 * 0.42,
                    child: Text(
                      "Add",
                      style: TextStyle(fontFamily:"QuickSand",
                          color: Colors.white,
                          fontSize: Globals.dheight * 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ])
        ]),
        // decoration: BoxDecoration(
        //   color: Colors.red,
        // ),
      ),
    );
  }
}
// user writes name on email bar
// user can't press create subtask until the user is confirmed exists
// when user is confirmed to exist, the startbtn is clickable, and userinfo is fetched
// when  started, the collabtask id is added to the users collabtaskids list
