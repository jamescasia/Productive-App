import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'package:ProductiveApp/Screens/LogInScreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import './elements/ProfileMission.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (context, snapshot, appModel) {
      return Material(
        child: Container(
          child: Column(children: [
            Container(
              // color: Colors.red,
              width: double.infinity,
              height: Globals.height * 0.4,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  height: Globals.dheight * 63,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: Globals.dheight * 60,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(width: 1),
                              Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900),
                              ),
                              InkWell(
                                  onTap: () async {
                                    var success =
                                        await appModel.logInScreenLogOut();
                                    if (success == AuthState.LoggedOut) {
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LogInScreen()));
                                    }
                                  },
                                  child: Icon(Icons.supervised_user_circle))
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: Globals.dheight * 110,
                        child: Image.asset(
                          "assets/mission_icons/mission_icon_4.png",
                          height: Globals.dheight * 140,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(1000))),
                      ),
                      Text(
                        "Ana Burgos",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: Globals.dheight * 50,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                left: 10,
                                child: AnimatedContainer(
                                  curve: Curves.linearToEaseOut,
                                  duration: Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                      color: Colors.amber[400],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: Globals.dheight * 32,
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
                color: Colors.red,
                child: ScrollConfiguration(
                  behavior: NoScrollLimitIndicator(),
                  child: SingleChildScrollView(
                    child: Column(children: []),
                  ),
                ),
              ),
            )
          ]),
        ),
      );
    });
  }
}
