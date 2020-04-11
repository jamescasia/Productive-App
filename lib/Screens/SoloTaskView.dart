import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/Screens/EditSoloSubtaskDialog.dart';
import 'package:ProductiveApp/Screens/EditSoloTaskDialog.dart';
import 'package:flutter/material.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';

import 'package:ProductiveApp/Screens/AddSubtaskDialog.dart';
import 'package:ProductiveApp/Screens/SubtaskCompletedDialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ProductiveApp/DataModels/SoloTask.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SoloTaskView extends StatefulWidget {
  SoloTask soloTask;
  AppModel appModel;
  SoloTaskView(this.soloTask, this.appModel);

  @override
  _SoloTaskViewState createState() =>
      _SoloTaskViewState(this.soloTask, appModel);
}

class _SoloTaskViewState extends State<SoloTaskView> {
  SoloTask soloTask;
  AppModel appModel;
  bool isEditing = false;
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
  _SoloTaskViewState(this.soloTask, this.appModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Globals.width * 0.8,
      // color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            // color: Colors.grey,
            height: Globals.dheight * 100,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  child: Container(
                    // color: Colors.red,
                    height: Globals.dheight * 60,
                    // width: Globals.width,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(500))),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: Globals.dheight * 25,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Positioned(
                                      left: 0,
                                      child: AnimatedContainer(
                                        curve: Curves.linearToEaseOut,
                                        duration: Duration(milliseconds: 1000),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(500))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8 *
                                                (this.soloTask.totalProgress),
                                        height: Globals.dheight * 25,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: Globals.dheight * 60,
                              height: Globals.dheight * 60,
                              decoration: BoxDecoration(
                                  color: (this.soloTask.completed)
                                      ? Colors.blue
                                      : Colors.grey[200] /*variable*/,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(500))),
                              child: (!isEditing)
                                  ? Image.asset(
                                      "assets/app_icons/apple_icon.png")
                                  : InkWell(
                                      borderRadius: BorderRadius.circular(1000),
                                      onTap: () {
                                        showGeneralDialog(
                                            barrierColor:
                                                Colors.black.withOpacity(0.5),
                                            transitionBuilder:
                                                (context, a1, a2, widget) {
                                              return Transform.scale(
                                                scale: a1.value,
                                                child: Opacity(
                                                    opacity: a1.value,
                                                    child: EditSoloTaskDialog(
                                                      appModel,
                                                      soloTask,
                                                    )),
                                              );
                                            },
                                            transitionDuration:
                                                Duration(milliseconds: 200),
                                            barrierDismissible: true,
                                            barrierLabel: '',
                                            context: context,
                                            pageBuilder: (context, animation1,
                                                animation2) {});
                                      },
                                      child: Center(
                                          child: FaIcon(
                                        FontAwesomeIcons.pen,
                                        color: Colors.green,
                                      )),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: Globals.dwidth * 4,
                  top: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.soloTask.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "QuickSand",
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[700],
                            fontSize: 18 * Globals.dheight,
                          ),
                        ),
                        SizedBox(height: Globals.dheight * 5),
                        Text(
                          "${month[DateTime.parse(this.soloTask.deadline).month - 1]} ${DateTime.parse(this.soloTask.deadline).day}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "QuickSand",
                            color: Colors.grey[700],
                            fontSize: 16 * Globals.dheight,
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: this
                  .soloTask
                  .subtasks
                  .map((s) => SubtaskView(
                      s, this.soloTask, appModel, isEditing, UniqueKey()))
                  .toList()),
          SizedBox(height: Globals.dheight * 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                color: Colors.green,
                shape: CircleBorder(),
                height: Globals.dheight * 28,
                minWidth: Globals.dheight * 28,
                child: Icon(
                  (!isEditing) ? FontAwesomeIcons.pen : FontAwesomeIcons.check,
                  color: Colors.white,
                  size: Globals.dheight * 16,
                ),
              ),
              SizedBox(width: Globals.dwidth * 30),
              MaterialButton(
                onPressed: () {
                  if (DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day)
                      .isAfter(DateTime.parse(soloTask.deadline))) {
                    Fluttertoast.showToast(
                        msg: "Deadline is over. Can't add task.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                              opacity: a1.value,
                              child: AddSubtaskDialog(appModel, soloTask)),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {});
                },
                color: Colors.blue,
                shape: CircleBorder(),
                height: Globals.dheight * 36,
                minWidth: Globals.dheight * 28,
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: Globals.dheight * 24,
                ),
              ),
              SizedBox(width: Globals.dwidth * 30),
              MaterialButton(
                onPressed: () {
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                              opacity: a1.value,
                              child: AddSubtaskDialog(appModel, soloTask)),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {});
                },
                color: Colors.red,
                shape: CircleBorder(),
                height: Globals.dheight * 28,
                minWidth: Globals.dheight * 28,
                child: Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.white,
                  size: Globals.dheight * 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SubtaskView extends StatefulWidget {
  AppModel appModel;
  SoloTask soloTask;
  Subtask subtask;
  bool isEditing;
  Key key;

  SubtaskView(
      this.subtask, this.soloTask, this.appModel, this.isEditing, this.key);
  @override
  _SubtaskViewState createState() => _SubtaskViewState(
      this.subtask, this.soloTask, this.appModel, this.isEditing);
}

class _SubtaskViewState extends State<SubtaskView> {
  AppModel appModel;
  SoloTask soloTask;
  Subtask subtask;
  bool isEditing;
  _SubtaskViewState(
    this.subtask,
    this.soloTask,
    this.appModel,
    this.isEditing,
  );

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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Globals.width * 0.8,
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            // color: Colors.grey,
            height: Globals.dheight * 95,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    // color: Colors.red,
                    height: Globals.dheight * 40,
                    // width: Globals.width,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(500))),
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: Globals.dheight * 17,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Positioned(
                                      left: 0,
                                      child: AnimatedContainer(
                                        curve: Curves.linearToEaseOut,
                                        duration: Duration(milliseconds: 1300),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(500))),
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.75 *
                                            ((this.subtask.completed) ? 1 : 0),
                                        height: Globals.dheight * 17,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Positioned(
                            right: Globals.dwidth * 7,
                            child: InkWell(
                              onTap: () {
                                if (subtask.completed) return;
                                if (!isEditing) {
                                  showGeneralDialog(
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      transitionBuilder:
                                          (context, a1, a2, widget) {
                                        return Transform.scale(
                                          scale: a1.value,
                                          child: Opacity(
                                              opacity: a1.value,
                                              child: SubtaskCompletedDialog(
                                                  appModel, soloTask, subtask)),
                                        );
                                      },
                                      transitionDuration:
                                          Duration(milliseconds: 200),
                                      barrierDismissible: true,
                                      barrierLabel: '',
                                      context: context,
                                      pageBuilder:
                                          (context, animation1, animation2) {});
                                } else {
                                  showGeneralDialog(
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      transitionBuilder:
                                          (context, a1, a2, widget) {
                                        return Transform.scale(
                                          scale: a1.value,
                                          child: Opacity(
                                              opacity: a1.value,
                                              child: EditSoloSubtaskDialog(
                                                  appModel, soloTask, subtask)),
                                        );
                                      },
                                      transitionDuration:
                                          Duration(milliseconds: 200),
                                      barrierDismissible: true,
                                      barrierLabel: '',
                                      context: context,
                                      pageBuilder:
                                          (context, animation1, animation2) {});
                                }
                              },
                              child: Container(
                                width: Globals.dheight * 40,
                                height: Globals.dheight * 40,
                                decoration: BoxDecoration(
                                    color: (this.subtask.completed)
                                        ? Colors.blue
                                        : Colors.grey[350] /*variable*/,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(500))),
                                child: ((isEditing) && !subtask.completed)
                                    ? Center(
                                        child: FaIcon(FontAwesomeIcons.pen,
                                            color: Colors.green))
                                    : Image.asset(
                                        "assets/app_icons/slice.png",
                                        fit: BoxFit.fitHeight,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: Globals.dwidth * 10,
                  top: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.subtask.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "QuickSand",
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[700],
                            fontSize: 16 * Globals.dheight,
                          ),
                        ),
                        Text(
                          "${month[DateTime.parse(this.subtask.deadline).month - 1]} ${DateTime.parse(this.subtask.deadline).day}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "QuickSand",
                            color: Colors.grey[700],
                            fontSize: 14 * Globals.dheight,
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
