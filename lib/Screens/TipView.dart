import 'package:flutter/material.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';

class TipView extends StatefulWidget {
  @override
  _TipViewState createState() => _TipViewState();
}

class _TipViewState extends State<TipView> with TickerProviderStateMixin {
  var currentPage = images.length - 1.0;
  List<String> welcomeImages = [
    "assets/mission_icons/mission_icon_1.png",
    "assets/mission_icons/mission_icon_2.png",
    "assets/mission_icons/mission_icon_3.png",
    "assets/mission_icons/mission_icon_4.png",
    "assets/mission_icons/mission_icon_5.png",
    "assets/mission_icons/mission_icon_1.png",
  ];
  @override
  Widget build(BuildContext context) {
    // CardController controller;
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Material(
      child: Scaffold(
        body: Container(
          child: Flex(direction: Axis.vertical, children: [
            Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    Positioned(
                        top: Globals.dheight * 30,
                        left: Globals.dwidth * -10,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          shape: CircleBorder(),
                          height: Globals.dheight * 60,
                          child: Icon(
                            Icons.close,
                            size: Globals.dheight * 60,
                            color: Colors.grey[400],
                          ),
                        )),
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: Globals.dheight * 20),
                            Image.asset(
                              "assets/app_icons/light_bulb_icon.png",
                              height: Globals.dheight * 100,
                            ),
                            Text("Study Tips",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.yellow[800])),
                            SizedBox(height: Globals.dheight * 20)
                          ]),
                    )
                  ],
                )),
            Container(
                width: double.infinity,
                height: Globals.dheight * 3,
                color: Colors.grey[300]),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: Globals.width * 0.8,
                    //   height: Globals.height * 0.55,
                    //   decoration: BoxDecoration(
                    //       color: Colors.amber[100],
                    //       boxShadow: [],
                    //       borderRadius: BorderRadius.all(Radius.circular(30))),
                    // )
                    Container(
                        width: Globals.width * 0.8,
                        // height: Globals.height * 0.55,
                        child: Stack(
                          children: <Widget>[
                            SwipeableCardStack(currentPage),
                            Positioned.fill(
                              child: PageView.builder(
                                itemCount: images.length,
                                controller: controller,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Container();
                                },
                              ),
                            )
                          ],
                        ))
                  ],
                )),
          ]),
          // color: Colors.red,
        ),
      ),
    );
  }
}
