import 'package:cash_coin/pages/boost_page.dart';
import 'package:cash_coin/pages/ref_page.dart';
import 'package:cash_coin/pages/tap_page.dart';
import 'package:flutter/material.dart';

import 'main.dart';


class MainButtons extends StatefulWidget {
  @override
  _MainButtonsState createState() => _MainButtonsState();
}

class _MainButtonsState extends State<MainButtons> {
  int _activeButtonIndex = 2;

  List<Widget> _pages = [
    BoostPage(),
    Refpage(),
    TapPage(),
    Refpage(),
    Refpage(),
  ];

  void _onButtonTap(int index) {
    setState(() {
      _activeButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _pages[_activeButtonIndex],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            ],
          ),
        ],
      ),
    );
  }
}
