import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:flutter/material.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import './AddCollabSubtaskDialog.dart';
import './CollabSubtaskCompletedDialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ProductiveApp/DataModels/CollabTask.dart';

class CollabTaskView extends StatefulWidget {
  CollabTask collabTask;
  AppModel appModel;
  CollabTaskView(this.collabTask, this.appModel);

  @override
  _CollabTaskViewState createState() =>
      _CollabTaskViewState(this.collabTask, appModel);
}

class _CollabTaskViewState extends State<CollabTaskView> {
  CollabTask collabTask;
  AppModel appModel;
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
  _CollabTaskViewState(this.collabTask, this.appModel);
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
                                                (this.collabTask.totalProgress),
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
                                  color: (this.collabTask.completed)
                                      ? Colors.blue
                                      : Colors.grey[200] /*variable*/,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(500))),
                              child: Image.asset(
                                  "assets/app_icons/apple_icon.png"),
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
                          this.collabTask.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[700],
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: Globals.dheight * 5),
                        Text(
                          "${month[DateTime.parse(this.collabTask.deadline).month - 1]} ${DateTime.parse(this.collabTask.deadline).day}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
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
                  .collabTask
                  .collabSubtasks
                  .map((s) => SubtaskView(s, this.collabTask, appModel))
                  .toList()),
          SizedBox(height: Globals.dheight * 20),
          MaterialButton(
            onPressed: () {
              showGeneralDialog(
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionBuilder: (context, a1, a2, widget) {
                    return Transform.scale(
                      scale: a1.value,
                      child: Opacity(
                          opacity: a1.value,
                          child: AddCollabSubtaskDialog(appModel, collabTask)),
                    );
                  },
                  transitionDuration: Duration(milliseconds: 200),
                  barrierDismissible: true,
                  barrierLabel: '',
                  context: context,
                  pageBuilder: (context, animation1, animation2) {});

              // appModel.homeTabAddSubTask(
              //     collabTask, CollabSubtask("id", "title", collabTask.deadline, false));
            },
            color: Colors.blue,
            shape: CircleBorder(),
            height: Globals.dheight * 28,
            minWidth: Globals.dheight * 28,
            child: Icon(
              FontAwesomeIcons.plus,
              color: Colors.white,
              size: Globals.dheight * 16,
            ),
          )
        ],
      ),
    );
  }
}

class SubtaskView extends StatefulWidget {
  AppModel appModel;
  CollabTask collabTask;
  CollabSubtask collabSubtask;

  SubtaskView(this.collabSubtask, this.collabTask, this.appModel);
  @override
  _SubtaskViewState createState() =>
      _SubtaskViewState(this.collabSubtask, this.collabTask, this.appModel);
}

class _SubtaskViewState extends State<SubtaskView> {
  AppModel appModel;
  CollabTask collabTask;
  CollabSubtask collabSubtask;
  _SubtaskViewState(this.collabSubtask, this.collabTask, this.appModel);

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
            height: Globals.dheight * 80,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75 *
                                                ((this.collabSubtask.completed)
                                                    ? 1
                                                    : 0),
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
                                if (collabSubtask.completed) return;
                                showGeneralDialog(
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    transitionBuilder:
                                        (context, a1, a2, widget) {
                                      return Transform.scale(
                                        scale: a1.value,
                                        child: Opacity(
                                            opacity: a1.value,
                                            child: CollabSubtaskCompletedDialog(
                                                appModel,
                                                collabTask,
                                                collabSubtask)),
                                      );
                                    },
                                    transitionDuration:
                                        Duration(milliseconds: 200),
                                    barrierDismissible: true,
                                    barrierLabel: '',
                                    context: context,
                                    pageBuilder:
                                        (context, animation1, animation2) {});
                              },
                              child: Container(
                                width: Globals.dheight * 40,
                                height: Globals.dheight * 40,
                                decoration: BoxDecoration(
                                    color: (this.collabSubtask.completed)
                                        ? Colors.blue
                                        : Colors.grey[350] /*variable*/,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(500))),
                                child: Image.asset(
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
                          this.collabSubtask.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${month[DateTime.parse(this.collabSubtask.deadline).month - 1]} ${DateTime.parse(this.collabSubtask.deadline).day}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
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
