import 'package:flutter/material.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';

class ProfileAchievementRowUIElement extends StatefulWidget {
  @override
  _ProfileAchievementRowUIElementState createState() =>
      _ProfileAchievementRowUIElementState();
}

class _ProfileAchievementRowUIElementState
    extends State<ProfileAchievementRowUIElement> {
  @override
  Widget build(BuildContext context) {
    return Container( 
      // margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1, color: Colors.grey[200])),
      ),
      width: double.infinity,
      height: Globals.dheight * 140,
      child: Center(
        child: Container(
          width: Globals.width*0.8,
          height: Globals.dheight*80,
          child: Flex(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      height: Globals.dheight * 80,
                      width: Globals.dheight * 80,
                      child: Image.asset(
                        "assets/mission_icons/mission_icon_4.png",
                        height: Globals.dheight * 140,
                        width: Globals.dheight * 140,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.all(Radius.circular(1000))),
                    ),
                  ),
                ),
                SizedBox(width: Globals.dwidth * 20),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tomato Farmer",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 16)),
                          Flexible(
                            child: Text("Complete 10 tomatoes using the timer",
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16)),
                          )
                        ]),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
