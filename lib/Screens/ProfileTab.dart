import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'package:ProductiveApp/ScopedModels/profile_tab_model.dart';
import 'package:ProductiveApp/Screens/LogInScreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import './elements/ProfileMission.dart';

import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        rebuildOnChange: true,
        builder: (context, snapshot, appModel) {
          return ScopedModel<ProfileTabModel>(
              model: appModel.profileTabModel,
              child: ScopedModelDescendant<ProfileTabModel>(
                  rebuildOnChange: true,
                  builder: (context, snapshot, homeTabModel) {
                    return Material(
                      child: Container(
                        child: Column(children: [
                          Container(
                            // color: Colors.red,
                            width: double.infinity,
                            height: Globals.height * 0.4,
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: Globals.dheight * 63,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: Globals.dheight * 60,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0),
                                            child: Stack(
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    "Profile",
                                                    style: TextStyle(
                                                        fontFamily: "QuickSand",
                                                        fontSize: 22,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 18,
                                                  child: InkWell(
                                                      onTap: () async {
                                                        var success = await appModel
                                                            .logInScreenLogOut();
                                                        if (success ==
                                                            AuthState
                                                                .LoggedOut) {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      LogInScreen()));
                                                        }
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .signOutAlt,
                                                        size: Globals.dheight *
                                                            35,
                                                        color: Colors.red[300],
                                                      )),
                                                )
                                              ],
                                            ),
                                          )),
                                        ),
                                        Container(
                                            width: double.infinity,
                                            height: Globals.dheight * 3,
                                            color: Colors.grey[300]),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    // color: Colors.blue,
                                    // width: double.infinity,
                                    // height: 262 * Globals.dheight,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          height: Globals.dheight * 110,
                                          child: Image.asset(
                                            "assets/mission_icons/mission_icon_4.png",
                                            height: Globals.dheight * 140,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.blue[100],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1000))),
                                        ),
                                        Text(
                                          appModel
                                              .userAdapter.user.userInfo.name,
                                          style: TextStyle(
                                              fontFamily: "QuickSand",
                                              fontSize: 23,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[400],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: Globals.dheight * 50,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Positioned(
                                                  left: 0,
                                                  child: AnimatedContainer(
                                                    curve:
                                                        Curves.linearToEaseOut,
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.amber[400],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50))),
                                                    width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        0.8 *
                                                        (homeTabModel
                                                            .percentageCompletedMissions),
                                                    height:
                                                        Globals.dheight * 50,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: Globals.dheight * 3,
                                      color: Colors.grey[300]),
                                ]),
                          ),
                          Expanded(
                            child: Container(
                              child: ScrollConfiguration(
                                behavior: NoScrollLimitIndicator(),
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    ProfileMissionRowUIElement(
                                        AppData.missions[0],
                                        appModel.userAdapter.user.stats
                                            .missionsCompleted[0],
                                        appModel.userAdapter.user.stats
                                            .numOfPomodorosCompleted),
                                    ProfileMissionRowUIElement(
                                        AppData.missions[1],
                                        appModel.userAdapter.user.stats
                                            .missionsCompleted[1],
                                        appModel.userAdapter.user.stats
                                            .numOfSoloTasksCompleted),
                                    ProfileMissionRowUIElement(
                                        AppData.missions[2],
                                        appModel.userAdapter.user.stats
                                            .missionsCompleted[2],
                                        appModel.userAdapter.user.stats
                                            .numOfLoginsCompleted),
                                    ProfileMissionRowUIElement(
                                        AppData.missions[3],
                                        appModel.userAdapter.user.stats
                                            .missionsCompleted[3],
                                        appModel.userAdapter.user.stats
                                            .numOfFriendsCollaboratedWith),
                                    ProfileMissionRowUIElement(
                                        AppData.missions[4],
                                        appModel.userAdapter.user.stats
                                            .missionsCompleted[4],
                                        appModel.userAdapter.user.stats
                                            .numOfCollabTasksCompleted),
                                  ]

                                  //     AppData.missions.map((m) {
                                  //   var accomplished = appModel.userAdapter.user
                                  //       .stats.missionsCompleted[i];
                                  //       var current = ;
                                  //   i += 1;
                                  //   return ProfileMissionRowUIElement(
                                  //       m, accomplished, );
                                  // }).toList())

                                  ,
                                )),
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  }));
        });
  }
}
