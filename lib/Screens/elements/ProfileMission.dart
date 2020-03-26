import 'package:flutter/material.dart';

import 'package:ProductiveApp/DataModels/Globals.dart';

import 'package:ProductiveApp/DataModels/Mission.dart';

class ProfileMissionRowUIElement extends StatefulWidget {
  Mission mission;
  bool accomplished;
  int current;

  ProfileMissionRowUIElement(this.mission, this.accomplished, this.current);
  @override
  _ProfileMissionRowUIElementState createState() =>
      _ProfileMissionRowUIElementState(
          this.mission, this.accomplished, this.current);
}

class _ProfileMissionRowUIElementState
    extends State<ProfileMissionRowUIElement> {
  Mission mission;
  bool accomplished;
  int current;
  _ProfileMissionRowUIElementState(
      this.mission, this.accomplished, this.current);

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
          width: Globals.width * 0.8,
          height: Globals.dheight * 80,
          child: Flex(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    // color: Colors.red,
                    child: Center(
                      child: Container(
                        height: Globals.dheight * 80,
                        width: Globals.dheight * 80,
                        child: Image.asset(
                          this.mission.badgeIconPathid,
                          height: Globals.dheight * 140,
                          width: Globals.dheight * 140,
                        ),
                        decoration: BoxDecoration(
                            color: (this.accomplished)
                                ? Colors.amber[300]
                                : Colors.blue[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(1000))),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Globals.dwidth * 20),
                Expanded(
                  flex: 4,
                  child: Container(
                    // color: Colors.blue,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(this.mission.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 16 * Globals.dheight)),
                          Flexible(
                            child: Text(this.mission.desc,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14 * Globals.dheight)),
                          ),
                          Text(
                              (this.current < 10)
                                  ? "${10 - this.current} left."
                                  : "",
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14 * Globals.dheight)),
                        ]),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
