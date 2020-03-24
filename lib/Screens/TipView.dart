import 'package:ProductiveApp/DataModels/AppData.dart';
import 'package:flutter/material.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';
import 'package:ProductiveApp/DataModels/Tip.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ProductiveApp/Libraries/SwipeableCardStack/SwipeableCardStack.dart';
import 'dart:math';

class TipView extends StatefulWidget {
  int rand;
  TipView(this.rand);
  @override
  _TipViewState createState() => _TipViewState(this.rand);
}

class _TipViewState extends State<TipView> with TickerProviderStateMixin {
  @override
  int rand;
  _TipViewState(this.rand);
  Widget build(BuildContext context) {
    // print("chosen");
    // print(AppData.tips[rng.nextInt(AppData.tips.length - 1)].imagePath);
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
                  children: [TipCard(AppData.tips[rand])],
                )),
          ]),
          // color: Colors.red,
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  Tip tip;

  TipCard(this.tip);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Globals.width * 0.76,
      height: Globals.height * 0.5,
      decoration: BoxDecoration(
          color: Colors.amber[100],
          boxShadow: [
            BoxShadow(
              color: Colors.amber[600],
              blurRadius: 3.0,
              spreadRadius: 3.0,
              offset: Offset(
                -5.0,
                8.0,
              ),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(height: Globals.dheight * 10),
          Text(tip.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                  fontSize: 28)),
          Container(
            height: Globals.dheight * 2,
            width: Globals.width * 0.76 * 0.9,
            color: Colors.grey[400],
          ),
          Container(
            width: Globals.width * 0.76 * 0.9,
            child: Text(tip.text,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                    fontSize: 16)),
          ),
          Image.asset(
            tip.imagePath,
            height: Globals.dheight * 220,
          ),
        ]),
      ),
    );
  }
}
