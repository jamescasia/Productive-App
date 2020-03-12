import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart';
import 'HomeTab.dart';
import 'PomodoroTab.dart';
import 'ProfileTab.dart';
import 'CollabTab.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tC;
  var currentPage = 0;
  @override
  void initState() {
    super.initState();
    tC = TabController(vsync: this, length: 4);

    tC.animation.addListener(() => this.doneSwiping());
  }

  void doneSwiping() {
    print("done swiping ");
    print(tC.index);
    // this.setState(() {});
 
  }

  @override
  void dispose() {
    tC.dispose();
    super.dispose();
  }

  void switchPage() {
    tC.animateTo(this.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    Globals.dheight = MediaQuery.of(context).size.height / 822;

    Globals.dwidth = MediaQuery.of(context).size.width / 393;

    Globals.height = MediaQuery.of(context).size.height;
    Globals.width = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      systemNavigationBarColor: const Color(0xFF1BA977),
      // #61C350
    ));
    return SafeArea(
      child: ScopedModel<AppModel>(
        model: AppModel(),
        child: ScopedModelDescendant<AppModel>(
            builder: (context, snapshot, appModel) {
          return Material(
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                  body: TabBarView(controller: tC, children: [
                    HomeTab(),
                    CollabTab(),
                    PomodoroTab(),
                    ProfileTab()
                  ]),
                  bottomNavigationBar: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Colors.grey[200],
                    ),
                    height: Globals.dheight * 80,
                    child: Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  this.currentPage = 0;
                                  this.switchPage();
                                },
                                splashColor: Colors.blue,
                                highlightColor: Colors.blueAccent,
                                child: (tC.index == 0)
                                    ? Image.asset(
                                        "assets/app_icons/home_icon.png")
                                    : Image.asset(
                                        "assets/app_icons/home_grey_icon.png")),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  this.currentPage = 1;
                                  this.switchPage();
                                },
                                splashColor: Colors.blue,
                                highlightColor: Colors.black,
                                child: (tC.index == 1)
                                    ? Image.asset(
                                        "assets/app_icons/collab_icon.png")
                                    : Image.asset(
                                        "assets/app_icons/collab_grey_icon.png")),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  this.currentPage = 2;
                                  this.switchPage();
                                },
                                splashColor: Colors.blue,
                                highlightColor: Colors.black,
                                child: (tC.index == 2)
                                    ? Image.asset(
                                        "assets/app_icons/pomodoro_icon.png")
                                    : Image.asset(
                                        "assets/app_icons/pomodoro_grey_icon.png")),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  this.currentPage = 3;
                                  this.switchPage();
                                },
                                splashColor: Colors.blue,
                                highlightColor: Colors.black,
                                child: (tC.index == 3)
                                    ? Image.asset(
                                        "assets/app_icons/profile_icon.png")
                                    : Image.asset(
                                        "assets/app_icons/profile_grey_icon.png")),
                          ),
                        ]),
                  )

                  //     new TabBar(indicatorColor: Colors.white.withAlpha(0), tabs: [
                  //   Tab(
                  //       icon: Image.asset(
                  //     "assets/app_icons/MANSANAS-05.png",
                  //     scale: 3,
                  //   )

                  //       // ImageIcon(
                  //       // AssetImage("assets/app_icons/MANSANAS-05.png"),
                  //       // size: 50,
                  //       // color: Colors.red,
                  //       // )

                  //       ),
                  //   Tab(
                  //       icon: ImageIcon(
                  //     AssetImage("assets/app_icons/MANSANAS-06.png"),
                  //   )),
                  //   Tab(
                  //       icon: ImageIcon(
                  //     AssetImage("assets/app_icons/MANSANAS-07.png"),
                  //   )),
                  //   Tab(
                  //       icon: ImageIcon(
                  //     AssetImage("assets/app_icons/MANSANAS-08.png"),
                  //   )),
                  // ])

                  //  BottomNavigationBar(
                  //   backgroundColor: Colors.black,
                  //   selectedItemColor: Colors.red,
                  //   items: [
                  //     BottomNavigationBarItem(icon: Icon(Icons.face), title: Text("Hello")),
                  //     BottomNavigationBarItem(
                  //         icon: Icon(Icons.ac_unit), title: Text("Hello")),
                  //     BottomNavigationBarItem(
                  //         icon: Icon(Icons.ac_unit), title: Text("Hello")),

                  //     BottomNavigationBarItem(
                  //         icon: Icon(Icons.ac_unit), title: Text("Hello"))
                  //   ],
                  // ),
                  ),
            ),
          );
        }),
      ),
    );
  }
}
