import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class TabChangerModel extends Model {
  int currentTab = 0;

  void doneSwiping(int index) async {
    this.currentTab = index; 
    await Future.delayed(Duration(milliseconds: 700));
    notifyListeners();
  }

  void switchPage(int index) {
    this.currentTab = index;
    notifyListeners();
  }
}
