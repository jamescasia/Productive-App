import 'package:ProductiveApp/DataModels/CollabTask.dart';
import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/ScopedModels/home_tab_model.dart';
import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';

enum UserExistence { NotExist, Exist, Undefined }

class EditCollabSubtaskDialog extends StatefulWidget {
  AppModel appModel;
  CollabTask collabTask;
  CollabSubtask collabSubtask;
  EditCollabSubtaskDialog(this.appModel, this.collabTask, this.collabSubtask);
  @override
  _EditCollabSubtaskDialogState createState() => _EditCollabSubtaskDialogState(
      this.appModel, this.collabTask, this.collabSubtask);
}

class _EditCollabSubtaskDialogState extends State<EditCollabSubtaskDialog> {
  AppModel appModel;
  CollabTask collabTask;
  CollabSubtask collabSubtask;
  UserExistence userExists = UserExistence.Undefined;
  String userUid;
  String userName;
  _EditCollabSubtaskDialogState(
      this.appModel, this.collabTask, this.collabSubtask);
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  TextEditingController taskAssignedController = TextEditingController();
  DateTime selectedDate;

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
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.parse(collabTask.deadline));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        taskDateController.text =
            "${month[selectedDate.month - 1]} ${selectedDate.day}, ${selectedDate.year} ";
      });
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.parse(collabSubtask.deadline);
    taskTitleController.text = collabSubtask.title;
    var deadline = DateTime.parse(collabSubtask.deadline);
    taskDateController.text =
        "${month[deadline.month - 1]} ${deadline.day}, ${deadline.year} ";
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
          Text("Edit subtask",
              style: TextStyle(
                  fontFamily: "QuickSand",
                  fontSize: 18,
                  color: Colors.grey[600])),
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
              child: TextField(
                style: TextStyle(fontFamily: "QuickSand"),
                controller: taskTitleController,
                decoration: new InputDecoration.collapsed(hintText: 'title'),
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: Globals.dheight * 7),
          //   height: Globals.dheight * 40,
          //   decoration: BoxDecoration(
          //       color: Colors.grey[350],
          //       borderRadius: BorderRadius.all(Radius.circular(10)),
          //       border: Border.all(
          //           color: (userExists == UserExistence.Exist)
          //               ? Colors.green[200]
          //               : (userExists == UserExistence.NotExist)
          //                   ? Colors.red[200]
          //                   : Colors.grey[400])),
          //   padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          //   width: Globals.width * 0.8,
          //   child: Center(
          //     child: TextField(
          //       style: TextStyle(fontFamily: "QuickSand"),
          //       controller: taskAssignedController,
          //       onChanged: (text) async {
          //         await Future.delayed(Duration(milliseconds: 1500));
          //         var result = await appModel.collabTabCheckUserExists(text);
          //         userExists = (result["exists"])
          //             ? UserExistence.Exist
          //             : UserExistence.NotExist;
          //         userUid = result["uid"];
          //         print("yuid");
          //         print(userUid);
          //         try {
          //           setState(() {});
          //         } catch (e) {}
          //       },
          //       decoration:
          //           new InputDecoration.collapsed(hintText: 'assigned email'),
          //     ),
          //   ),
          // ),
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
                child: TextField(
                  style: TextStyle(fontFamily: "QuickSand"),
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
            height: Globals.dheight * 6,
          ),
          MaterialButton(
            color: Colors.red[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            onPressed: () async {
              Navigator.pop(context);
              appModel.collabTabDeleteCollabSubtask(collabTask, collabSubtask);
            },
            height: Globals.dheight * 40,
            minWidth: double.infinity,
            child: Text(
              "Delete",
              style: TextStyle(
                  fontFamily: "QuickSand",
                  color: Colors.white,
                  fontSize: Globals.dheight * 16,
                  fontWeight: FontWeight.w700),
            ),
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
                      style: TextStyle(
                          fontFamily: "QuickSand",
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
                    onPressed: () async {
                      collabSubtask.title = taskTitleController.text;
                      collabSubtask.deadline = selectedDate.toIso8601String();

                      await appModel.collabTabAddCollabSubTask(
                          collabTask, collabSubtask);
                      await appModel.collabTabAddCollabTaskToCollaborator(
                          userUid, collabTask);
                      Navigator.pop(context);
                    },
                    height: Globals.dheight * 40,
                    minWidth: Globals.width * 0.8 * 0.42,
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          fontFamily: "QuickSand",
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
