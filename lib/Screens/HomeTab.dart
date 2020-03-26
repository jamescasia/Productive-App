import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/ScopedModels/home_tab_model.dart';
import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:ProductiveApp/DataModels/SoloTask.dart';
import './TipView.dart';
import './SoloTaskView.dart';
import './AddTaskDialog.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:ProductiveApp/DataModels/Globals.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var soloTask = SoloTask();

  @override
  Widget build(BuildContext context) {
    // soloTask.title = "Demo task";
    // soloTask.deadline = DateTime.now().toIso8601String();
    // soloTask.subtasks.add(Subtask("0", "title", soloTask.deadline, false));
    return ScopedModelDescendant<AppModel>(
        rebuildOnChange: true,
        builder: (context, snapshot, appModel) {
          return ScopedModel<HomeTabModel>(
              model: appModel.homeTabModel,
              child: ScopedModelDescendant<HomeTabModel>(
                  builder: (context, snapshot, homeTabModel) {
                return Material(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            color: Colors.grey[100],
                            height: Globals.dheight * 80,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0 * Globals.dwidth,
                                  left: -15 * Globals.dwidth,
                                  child: MaterialButton(
                                    onPressed: () {
                                      // appModel.homeTabFetchSoloTasks();
                                      int rand = Random()
                                          .nextInt(AppData.tips.length - 1);
                                      showGeneralDialog(
                                          barrierColor:
                                              Colors.black.withOpacity(0.5),
                                          transitionBuilder:
                                              (context, a1, a2, widget) {
                                            final curvedValue = Curves
                                                    .linearToEaseOut
                                                    .transform(a1.value) -
                                                1.0;
                                            return Transform(
                                              transform:
                                                  Matrix4.translationValues(0.0,
                                                      curvedValue * -800, 0.0),
                                              child: TipView(rand),
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 500),
                                          barrierDismissible: true,
                                          barrierLabel: '',
                                          context: context,
                                          pageBuilder: (context, animation1,
                                              animation2) {});
                                    },
                                    height: Globals.dheight * 70,
                                    shape: CircleBorder(),
                                    child: Image.asset(
                                      "assets/app_icons/light_bulb_icon.png",
                                      height: Globals.dheight * 70,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Text(
                                      "Dashboard",
                                      style: TextStyle(fontFamily:"QuickSand",
                                          fontSize: 25,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 7 * Globals.dwidth,
                                  right: -7 * Globals.dwidth,
                                  child: (homeTabModel.homeTabState ==
                                          HomeTabState.SomeSoloTasks)
                                      ? MaterialButton(
                                          height: Globals.dheight * 53,
                                          onPressed: () {
                                            showGeneralDialog(
                                                barrierColor: Colors.black
                                                    .withOpacity(0.5),
                                                transitionBuilder:
                                                    (context, a1, a2, widget) {
                                                  return Transform.scale(
                                                    scale: a1.value,
                                                    child: Opacity(
                                                        opacity: a1.value,
                                                        child: AddTaskDialog(
                                                            appModel)),
                                                  );
                                                },
                                                transitionDuration:
                                                    Duration(milliseconds: 200),
                                                barrierDismissible: true,
                                                barrierLabel: '',
                                                context: context,
                                                pageBuilder: (context,
                                                    animation1, animation2) {});
                                          },
                                          shape: CircleBorder(),
                                          color: Colors.blue[400],
                                          child: Icon(
                                            FontAwesomeIcons.plus,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            )),
                        Container(
                          // color: Colors.red,
                          height: Globals.dheight * 70,
                          width: double.infinity,
                          child: Stack(children: [
                            Container(
                              height: Globals.dheight * 40,
                              width: double.infinity,
                              color: Colors.grey[100],
                            ),
                            Center(
                              child: Container(
                                  width: double.infinity,
                                  height: Globals.dheight * 3,
                                  color: Colors.grey[300]),
                            ),
                            Center(
                                child: Container(
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: (homeTabModel.homeTabState ==
                                            HomeTabState.SomeSoloTasks)
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: Globals.dheight * 35,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Positioned(
                                                  left: 0,
                                                  child: AnimatedContainer(
                                                    curve:
                                                        Curves.linearToEaseOut,
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .greenAccent[400],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50))),
                                                    width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        0.8 *
                                                        homeTabModel
                                                            .percentCompletedTasks,
                                                    height:
                                                        Globals.dheight * 35,
                                                  ),
                                                ),
                                              ],
                                            ))
                                        : null,
                                  ),
                                  (homeTabModel.homeTabState ==
                                          HomeTabState.SomeSoloTasks)
                                      ? Positioned(
                                          right: Globals.dwidth * 30,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            width: Globals.dwidth * 70,
                                            height: Globals.dwidth * 70,
                                            decoration: BoxDecoration(
                                                color: (homeTabModel
                                                            .percentCompletedTasks ==
                                                        1)
                                                    ? Colors.greenAccent[400]
                                                    : Colors
                                                        .grey[300] /*variable*/,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(500))),
                                            child: Image.asset(
                                                "assets/app_icons/apple_icon.png"),
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            width: Globals.dwidth * 70,
                                            height: Globals.dwidth * 70,
                                            decoration: BoxDecoration(
                                                color: Colors
                                                    .grey[300] /*variable*/,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(500))),
                                            child: Image.asset(
                                                "assets/app_icons/apple_icon.png"),
                                          ),
                                        ),
                                ],
                              ),
                            ))
                          ]),
                        ),
                        // Expanded(child:
                        // Container(color: Colors.red,)),
                        Expanded(
                            child: (homeTabModel.homeTabState ==
                                    HomeTabState.SomeSoloTasks)
                                ? Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: ScrollConfiguration(
                                      behavior: NoScrollLimitIndicator(),
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: <Widget>[
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: appModel
                                                .userAdapter.user.soloTasks
                                                .map((s) =>
                                                    SoloTaskView(s, appModel))
                                                .toList(),
                                          ),
                                          SizedBox(
                                              height: Globals.dheight * 100),
                                          MaterialButton(
                                            height: Globals.dheight * 120,
                                            onPressed: () {
                                              showGeneralDialog(
                                                  barrierColor: Colors.black
                                                      .withOpacity(0.5),
                                                  transitionBuilder: (context,
                                                      a1, a2, widget) {
                                                    return Transform.scale(
                                                      scale: a1.value,
                                                      child: Opacity(
                                                          opacity: a1.value,
                                                          child: AddTaskDialog(
                                                              appModel)),
                                                    );
                                                  },
                                                  transitionDuration: Duration(
                                                      milliseconds: 200),
                                                  barrierDismissible: true,
                                                  barrierLabel: '',
                                                  context: context,
                                                  pageBuilder: (context,
                                                      animation1,
                                                      animation2) {});
                                            },
                                            shape: CircleBorder(),
                                            color: Colors.blue[400],
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 7.0),
                                                child: Icon(
                                                  FontAwesomeIcons.plus,
                                                  color: Colors.white,
                                                  size: Globals.dheight * 80,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  )
                                : Container(
                                    width: Globals.width,
                                    // height: Globals.height / 2,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          MaterialButton(
                                            height: Globals.dheight * 120,
                                            onPressed: () {
                                              showGeneralDialog(
                                                  barrierColor: Colors.black
                                                      .withOpacity(0.5),
                                                  transitionBuilder: (context,
                                                      a1, a2, widget) {
                                                    return Transform.scale(
                                                      scale: a1.value,
                                                      child: Opacity(
                                                          opacity: a1.value,
                                                          child: AddTaskDialog(
                                                              appModel)),
                                                    );
                                                  },
                                                  transitionDuration: Duration(
                                                      milliseconds: 200),
                                                  barrierDismissible: true,
                                                  barrierLabel: '',
                                                  context: context,
                                                  pageBuilder: (context,
                                                      animation1,
                                                      animation2) {});
                                            },
                                            shape: CircleBorder(),
                                            color: Colors.blue[400],
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 7.0),
                                                child: Icon(
                                                  FontAwesomeIcons.plus,
                                                  color: Colors.white,
                                                  size: Globals.dheight * 80,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: Globals.dheight * 20),
                                          Text(
                                            "Have things to do?\nKeep track of them here",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily:"QuickSand",
                                                color: Colors.grey[400],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                      ],
                    ),
                  ),
                );
              }));
        });
  }
}
