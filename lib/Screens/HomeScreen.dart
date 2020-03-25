import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomeTab.dart';
import 'PomodoroTab.dart';
import 'ProfileTab.dart';
import 'CollabTab.dart';
import 'package:ProductiveApp/DataModels/Globals.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:ProductiveApp/ScopedModels/app_model.dart';
import 'package:ProductiveApp/ScopedModels/tab_changer_model.dart';
import './SignUpScreen.dart';
import './LogInScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tC;
  HomeTab homeTab = HomeTab();
  CollabTab collabTab = CollabTab();
  PomodoroTab pomodoroTab = PomodoroTab();
  ProfileTab profileTab = ProfileTab();
  var currentPage = 0;
  @override
  void initState() {
    print("in homescren");
    super.initState();
    tC = TabController(vsync: this, length: 4);
  }

  void afterBuild() {}

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

  void switchPage(int index) {
    tC.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    // appModelSingleton = AppModel();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.grey[100],
      systemNavigationBarColor: const Color(0xFF1BA977),
      // #61C350
    ));
    
    return SafeArea(
      child: ScopedModelDescendant<AppModel>(
          builder: (context, snapshot, appModel) {
        return Material(
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
                body: TabBarView(
                    controller: tC,
                    children: [homeTab, collabTab, pomodoroTab, profileTab]),
                bottomNavigationBar: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(30),
                    //     topRight: Radius.circular(30)),
                    color: Colors.grey[200],
                  ),
                  height: Globals.dheight * 80,
                  child: ScopedModel<TabChangerModel>(
                      model: appModel.tabChangerModel,
                      child: ScopedModelDescendant<TabChangerModel>(
                          builder: (context, snapshot, tabChangerModel) {
                        tC.animation.addListener(
                            () => tabChangerModel.doneSwiping(tC.index));
                        return Flex(
                            direction: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: () {
                                      switchPage(0);
                                      tabChangerModel.switchPage(0);
                                    },
                                    splashColor: Colors.blue.withAlpha(0),
                                    highlightColor:
                                        Colors.blueAccent.withAlpha(0),
                                    child: (tabChangerModel.currentTab == 0)
                                        ? Image.asset(
                                            "assets/app_icons/home_icon.png")
                                        : Image.asset(
                                            "assets/app_icons/home - gray.png")),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: () {
                                      switchPage(1);
                                      tabChangerModel.switchPage(1);
                                    },
                                    splashColor: Colors.blue,
                                    highlightColor: Colors.black,
                                    child: (tabChangerModel.currentTab == 1)
                                        ? Image.asset(
                                            "assets/app_icons/collab_icon.png")
                                        : Image.asset(
                                            "assets/app_icons/collabs - gray.png")),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: () {
                                      switchPage(2);
                                      tabChangerModel.switchPage(2);
                                    },
                                    splashColor: Colors.blue,
                                    highlightColor: Colors.black,
                                    child: (tabChangerModel.currentTab == 2)
                                        ? Image.asset(
                                            "assets/app_icons/pomodoro_icon.png")
                                        : Image.asset(
                                            "assets/app_icons/timer - gray.png")),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: () {
                                      switchPage(3);
                                      tabChangerModel.switchPage(3);
                                    },
                                    splashColor: Colors.blue.withAlpha(0),
                                    highlightColor: Colors.black.withAlpha(0),
                                    child: (tabChangerModel.currentTab == 3)
                                        ? Image.asset(
                                            "assets/app_icons/profile_icon.png")
                                        : Image.asset(
                                            "assets/app_icons/profile - gray.png")),
                              ),
                            ]);
                      })),
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
    );
  }
}
