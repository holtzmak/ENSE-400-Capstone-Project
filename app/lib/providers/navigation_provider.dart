import 'package:app/screens/history/history.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/new_travel/new_travel.dart';
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _index = 0;
  List<Widget> _screens = <Widget>[
    HomeScreen(),
    NewTravel(),
    TravelHistory(),
  ];
  get getIndex => _index;
  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  get getCurrentScreen => _screens;
}
