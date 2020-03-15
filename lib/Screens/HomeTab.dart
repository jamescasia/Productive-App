import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import './TipView.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.downToUp,
                                child: TipView()));
                        // Navigator.of(context).push(PageRouteBuilder(
                        //     opaque: false,
                        //     pageBuilder: (BuildContext context, _, __) =>
                        //         TipView()));
                      },
                      height: Globals.dheight * 70,
                      shape: CircleBorder(),
                      child: Image.asset(
                        "assets/app_icons/light_bulb_icon.png",
                        height: Globals.dheight * 70,
                      ),
                    ),
                    // Container(
                    //   height: Globals.dheight * 70,
                    //   width: Globals.dwidth * 70,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(1000)),
                    //   ),
                    //   child:
                    //       Image.asset("assets/app_icons/light_bulb_icon.png"),
                    // ),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: Globals.dheight * 70,
                      width: Globals.dwidth * 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                      ),
                      child: Image.asset("assets/app_icons/add_icon.png"),
                    ),
                  ],
                )),
            Container(
              // color: Colors.red,
              height: Globals.dheight * 80,
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
                        child: Container(
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
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: Globals.dheight * 32,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Positioned(
                        right: Globals.dwidth * 30,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: Globals.dwidth * 80,
                          height: Globals.dwidth * 80,
                          decoration: BoxDecoration(
                              color: Colors.grey[300] /*variable*/,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(500))),
                          child: Image.asset("assets/app_icons/apple_icon.png"),
                        ),
                      ),
                    ],
                  ),
                ))
              ]),
            ),
            SingleChildScrollView(
                child: Column(
              children: <Widget>[
 
              ],
            ))
          ],
        ),
      ),
    );
  }
}
