import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomeScreen.dart';
import 'HomeTab.dart';
import 'PomodoroTab.dart';
import 'ProfileTab.dart';
import 'CollabTab.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/ScopedModels/tab_changer_model.dart';
import './SignUpScreen.dart';
import 'dart:async';

class Mansana extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: MaterialApp(
          home: LogInScreen(),
        ));
  }
}

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Globals.dheight = MediaQuery.of(context).size.height / 822;
    Globals.dwidth = MediaQuery.of(context).size.width / 393;
    Globals.height = MediaQuery.of(context).size.height;
    Globals.width = MediaQuery.of(context).size.width;

    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Material(
        child: Container(
          height: Globals.height,
          width: Globals.width,
          child: Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                      width: Globals.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: Globals.dheight * 130,
                              child: Image.asset(
                                "assets/app_icons/smiley apple.png",
                                height: Globals.dheight * 160,
                                scale: 2,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent[400],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1000))),
                            ),
                            SizedBox(height: Globals.dheight * 25),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Welcome",
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  "Log-in",
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ])),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      // color: Colors.red,
                      width: Globals.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Globals.dheight * 7),
                                  height: Globals.dheight * 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border:
                                          Border.all(color: Colors.grey[400])),
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  width: Globals.width * 0.8,
                                  child: Center(
                                    child: TextField(
                                      controller: emailController,
                                      decoration: new InputDecoration.collapsed(
                                          hintText: 'Email address'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Globals.dheight * 7),
                                  height: Globals.dheight * 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border:
                                          Border.all(color: Colors.grey[400])),
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  width: Globals.width * 0.8,
                                  child: Center(
                                    child: TextField(
                                      controller: passwordController,
                                      decoration: new InputDecoration.collapsed(
                                          hintText: 'Password'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Globals.dheight * 7),
                                  width: Globals.width * 0.8,
                                  child: MaterialButton(
                                    enableFeedback: (appModel.authState ==
                                        AuthState.LoggedOut),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    onPressed: (!(emailController.text
                                                        .toString()
                                                        .length ==
                                                    0 ||
                                                passwordController.text
                                                        .toString()
                                                        .length ==
                                                    0) &&
                                            appModel.authState !=
                                                AuthState.LoggingIn)
                                        ? () async {
                                            if (appModel.authState ==
                                                AuthState.InvalidLogIn) return;
                                            var success =
                                                await appModel.logInScreenLogIn(
                                                    emailController.text,
                                                    passwordController.text);
                                            if (success == AuthState.LoggedIn) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          HomeScreen()));
                                            }
                                          }
                                        : null,
                                    disabledColor: Colors.greenAccent[400],
                                    color: (appModel.authState ==
                                            AuthState.InvalidLogIn)
                                        ? Colors.red
                                        : Colors.greenAccent[400],
                                    height: Globals.dheight * 50,
                                    minWidth: Globals.width * 0.8,
                                    child: Center(
                                      child: (appModel.authState ==
                                                  AuthState.LoggedOut ||
                                              appModel.authState ==
                                                  AuthState.LoggedIn)
                                          ? Text(
                                              "LOG IN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )
                                          : (appModel.authState ==
                                                  AuthState.LoggingIn)
                                              ? JumpingText("...",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 35))
                                              : Text(
                                                  "INVALID",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                    ),
                                  ),
                                )
                              ]),
                          SizedBox(height: Globals.dheight * 14),
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                    color: Colors.grey[900], fontSize: 17),
                              ),
                              InkWell(
                                onTap: () {
                                  appModel.logInScreenLogOut();
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignUpScreen()));
                                },
                                child: Text(
                                  "Sign-up",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 17),
                                ),
                              ),
                            ],
                          )),
                        ],
                      )),
                )
              ]),
        ),
      );
    });
    ;
  }
}