import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:ProductiveApp/Screens/LogInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomeTab.dart';
import 'PomodoroTab.dart';
import 'ProfileTab.dart';
import 'CollabTab.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/ScopedModels/tab_changer_model.dart';

import 'package:keyboard_visibility/keyboard_visibility.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  double safePadding = 0;

  ScrollController sc = ScrollController();

  afterBuild() {
    print("done");
    sc.jumpTo(29);
  }

  @override
  void initState() {
    // TODO: implement initState\

    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      print("Keyboardd is");
      print(visible);

      setState(() {
        if (visible) {
          Future.delayed(Duration(milliseconds: 40)).then((_) {
            sc.animateTo(sc.position.maxScrollExtent * 0.5,
                duration: Duration(milliseconds: 100), curve: Curves.easeOut);
          });
        }
        if (!visible) {
          Future.delayed(Duration(milliseconds: 40)).then((_) {
            sc.animateTo(safePadding,
                duration: Duration(milliseconds: 100), curve: Curves.easeOut);
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.grey[100],
      systemNavigationBarColor: const Color(0xFF1BA977),
      // #61C350
    ));
    return SafeArea(
      child: new LayoutBuilder(builder: (context, constraints) {
        // print("constraints");
        // print(constraints.maxHeight);
        safePadding = Globals.height - constraints.maxHeight;
        print("padding");
        print(safePadding);
        // print(sc.position.maxScrollExtent);

        return ScopedModelDescendant<AppModel>(
            builder: (context, snapshot, appModel) {
          return Material(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: sc,
              child: Column(
                children: <Widget>[
                  Container(
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(1000))),
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
                                            "Sign-up",
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
                            flex: 5,
                            child: Container(
                                // color: Colors.red,
                                width: Globals.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    color: Colors.grey[400])),
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            width: Globals.width * 0.8,
                                            child: Center(
                                              child: TextField(
                                                controller: nameController,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText: 'Username'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    color: Colors.grey[400])),
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            width: Globals.width * 0.8,
                                            child: Center(
                                              child: TextField(
                                                controller: emailController,
                                                decoration: new InputDecoration
                                                        .collapsed(
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    color: Colors.grey[400])),
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            width: Globals.width * 0.8,
                                            child: Center(
                                              child: TextField(
                                                obscureText: true,
                                                controller: passwordController,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText: 'Password'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    color: Colors.grey[400])),
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            width: Globals.width * 0.8,
                                            child: Center(
                                              child: TextField(
                                                obscureText: true,
                                                controller: password2Controller,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText:
                                                        'Re-enter password'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            width: Globals.width * 0.8,
                                            child: MaterialButton(
                                              enableFeedback:
                                                  (appModel.signUpState ==
                                                      SignUpState.NotSignedUp),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              onPressed: (!(emailController
                                                                  .text
                                                                  .toString()
                                                                  .length ==
                                                              0 ||
                                                          passwordController
                                                                  .text
                                                                  .toString()
                                                                  .length ==
                                                              0 ||
                                                          nameController
                                                                  .text
                                                                  .toString()
                                                                  .length ==
                                                              0 ||
                                                          password2Controller
                                                                  .text
                                                                  .toString()
                                                                  .length ==
                                                              0 ||
                                                          password2Controller
                                                                  .text
                                                                  .toString() !=
                                                              passwordController
                                                                  .text
                                                                  .toString()) &&
                                                      appModel.signUpState !=
                                                          SignUpState.SigningUp)
                                                  ? () async {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              FocusNode());
                                                      print("sign up pressed");
                                                      if (appModel
                                                              .signUpState ==
                                                          SignUpState
                                                              .InvalidSignUp)
                                                        return;
                                                      var success = await appModel
                                                          .signUpScreenSignUp(
                                                              nameController
                                                                  .text,
                                                              emailController
                                                                  .text,
                                                              passwordController
                                                                  .text);
                                                      if (success ==
                                                          SignUpState
                                                              .SignedUp) {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    HomeScreen()));
                                                      }
                                                    }
                                                  : null,
                                              disabledColor:
                                                  Colors.greenAccent[400],
                                              color: (appModel.signUpState ==
                                                      SignUpState.InvalidSignUp)
                                                  ? Colors.red
                                                  : Colors.greenAccent[400],
                                              height: Globals.dheight * 50,
                                              minWidth: Globals.width * 0.8,
                                              child: Center(
                                                child: (appModel.signUpState ==
                                                            SignUpState
                                                                .NotSignedUp ||
                                                        appModel.signUpState ==
                                                            SignUpState
                                                                .SignedUp)
                                                    ? Text(
                                                        "CONTINUE",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      )
                                                    : (appModel.signUpState ==
                                                            SignUpState
                                                                .SigningUp)
                                                        ? JumpingText("...",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 35))
                                                        : Text(
                                                            "INVALID",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18),
                                                          ),
                                              ),
                                            ),
                                          )
                                        ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Center(
                                            child: Text(
                                          "or sign up with",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[900],
                                              fontSize: 18),
                                        )),
                                        SizedBox(height: Globals.dheight * 9),
                                        Container(
                                          width: Globals.width * 0.8,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                MaterialButton(
                                                  color: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6))),
                                                  onPressed: () {},
                                                  height: Globals.dheight * 60,
                                                  minWidth: Globals.width *
                                                      0.8 *
                                                      0.48,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      //insert google logo here
                                                      Container(),
                                                      Text(
                                                        "GOOGLE",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                MaterialButton(
                                                  color: Colors.blue,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6))),
                                                  onPressed: () {},
                                                  height: Globals.dheight * 60,
                                                  minWidth: Globals.width *
                                                      0.8 *
                                                      0.48,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      //insert google logo here
                                                      Container(),
                                                      Text(
                                                        "FACEBOOK",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                    Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Already have an account? ",
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: 17),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Log-in",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                )),
                          )
                        ]),
                  ),
                  Container(height: Globals.height * 0.4)
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
