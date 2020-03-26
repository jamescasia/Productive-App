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

class AddSubtaskDialog extends StatefulWidget {
  AppModel appModel;
  SoloTask soloTask;
  AddSubtaskDialog(this.appModel, this.soloTask);
  @override
  _AddSubtaskDialogState createState() =>
      _AddSubtaskDialogState(this.appModel, this.soloTask);
}

class _AddSubtaskDialogState extends State<AddSubtaskDialog> {
  AppModel appModel;
  SoloTask soloTask;
  _AddSubtaskDialogState(this.appModel, this.soloTask);
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  DateTime selectedDate = DateTime.now(); 

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null  )
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
                decoration:
                    new InputDecoration.collapsed(hintText: 'Subtask title'),
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
                  decoration: new InputDecoration.collapsed(
                      hintText: 'Subtask due date'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Globals.dheight * 15,
          ),
          Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
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
                    // minWidth: Globals.width * 0.8 * 0.42,

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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    onPressed: () async {
                      var subtask = Subtask(
                          "0",
                          taskTitleController.text.toString(),
                          selectedDate.toIso8601String(),
                          false);
                      await appModel.homeTabAddSubTask(soloTask, subtask);
                      Navigator.pop(context);
                    },
                    height: Globals.dheight * 40,
                    // minWidth: Globals.width * 0.8 * 0.42,
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
