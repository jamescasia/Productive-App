import 'package:flutter/material.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Flex(direction: Axis.vertical, children: [
          Expanded(
              flex: 5,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  width: double.infinity,
                  height: Globals.dheight * 60,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                ),
                Container(
                    width: double.infinity,
                    height: Globals.dheight * 3,
                    color: Colors.grey[300]),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: Globals.dheight * 32,
                              ),
                            ),
                          ],
                        )),
                  ],
                )
              ])),
          Expanded(flex: 6, child: Container(color: Colors.blue))
        ]),
      ),
    );
  }
}
