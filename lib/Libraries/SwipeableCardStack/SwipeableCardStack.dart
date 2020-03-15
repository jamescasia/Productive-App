import 'package:flutter/material.dart';
import 'dart:math';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class SwipeableCardStack extends StatefulWidget {
  List<String> mainText;
  List<String> subText;
  List<String> assetPath;

  SwipeableCardStack(this.mainText, this.subText, this.assetPath);

  @override
  _SwipeableCardStackState createState() =>
      _SwipeableCardStackState(this.mainText, this.subText, this.assetPath);
}

class _SwipeableCardStackState extends State<SwipeableCardStack> {
  var currentPage = 3.0;
  List<String> mainText;
  List<String> subText;
  List<String> assetPath;

  var padding = 20.0;
  _SwipeableCardStackState(this.mainText, this.subText, this.assetPath);
  var verticalInset = 20.0;

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: this.assetPath.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return ScrollConfiguration(
      behavior: NoScrollLimitIndicator(),
      child: Stack(
        children: <Widget>[
          new AspectRatio(
            aspectRatio: widgetAspectRatio,
            child: LayoutBuilder(builder: (context, contraints) {
              var width = contraints.maxWidth;
              var height = contraints.maxHeight;

              var safeWidth = width - 2 * padding;
              var safeHeight = height - 2 * padding;

              var heightOfPrimaryCard = safeHeight;
              var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

              var primaryCardLeft = safeWidth - widthOfPrimaryCard;
              var horizontalInset = primaryCardLeft / 2;

              List<Widget> cardList = new List();
              print("length");
              print(this.assetPath.length);

              for (var i = 0; i < this.assetPath.length; i++) {
                var delta = i - this.currentPage;
                bool isOnRight = delta > 0;

                var start = padding +
                    max(
                        primaryCardLeft -
                            horizontalInset * -delta * (isOnRight ? 15 : 1),
                        0.0);

                var cardItem = Positioned.directional(
                  top: padding + verticalInset * max(-delta, 0.0),
                  bottom: padding + verticalInset * max(-delta, 0.0),
                  start: start,
                  textDirection: TextDirection.rtl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      
                      decoration: BoxDecoration(
                          color: Colors.amber[100],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3.0, 6.0),
                                blurRadius: 10.0)
                          ]),
                      child: AspectRatio(
                        aspectRatio: cardAspectRatio,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.asset(this.assetPath[i], fit: BoxFit.cover),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: Text(this.assetPath[i],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, bottom: 12.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Text("Read Later",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                cardList.add(cardItem);
                print("added card");
                print(i);
              }
              print(cardList.length);
              return Stack(
                children: cardList,
              );
            }),
          ),
          Positioned.fill(
            child: PageView.builder(
              itemCount: this.assetPath.length,
              controller: controller,
              reverse: true,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}

class NoScrollLimitIndicator extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
