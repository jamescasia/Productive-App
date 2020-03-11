import 'package:ProductiveApp/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

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
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: dheight * 70,
                  width: dwidth * 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                  ),
                  child: Image.asset("assets/app_icons/light_bulb_icon.png"),
                ),
                Text(
                  "Dashboard",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  height: dheight * 70,
                  width: dwidth * 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                  ),
                  child: Image.asset("assets/app_icons/add_icon.png"),
                ),
              ],
            )),
            Container(
              // color: Colors.red,
              height: dheight * 80,
              width: double.infinity,
              child: Stack(children: [
                Center(
                  child: Container(
                      width: double.infinity,
                      height: dheight * 3,
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
                            height: dheight * 50,
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
                                    height: dheight * 32,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Positioned(
                        right: dwidth * 30,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: dwidth * 80,
                          height: dwidth * 80,
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
              children: <Widget>[],
            ))
          ],
        ),
      ),
    );
  }
}
