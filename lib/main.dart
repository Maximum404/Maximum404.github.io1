import 'package:cash_coin/pages/boost_page.dart';
import 'package:cash_coin/pages/earn_page.dart';
import 'package:cash_coin/pages/ref_page.dart';
import 'package:cash_coin/pages/stats_page.dart';
import 'package:cash_coin/pages/tap_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Coin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: PreloadImages(),
      ),
    );
  }
}

class PreloadImages extends StatefulWidget {
  const PreloadImages({super.key});

  @override
  State<PreloadImages> createState() => _PreloadImagesState();
}

class _PreloadImagesState extends State<PreloadImages> {
  late Future<List<dynamic>> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = _preloadImages(context);
  }

  Future<List<dynamic>> _preloadImages(BuildContext context) async {
    List<dynamic> images = [
      'assets/images/but_1.png',
      'assets/images/but_2.png',
      'assets/images/but_3.png',
      'assets/images/but_4.png',
      'assets/images/but_5.png',
    ];

    List<Future<dynamic>> imageFutures = images.map((imagePath) {
      return precacheImage(AssetImage(imagePath), context);
    }).toList();

    return Future.wait(imageFutures);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _imageFuture,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyHomePage();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _activeButtonIndex = 2;

  final List<Widget> _pages = [
    Refpage(),
    EarnPage(),
    TapPage(),
    BoostPage(),
    StatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      _pages[_activeButtonIndex],
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          width: double.infinity,
          height: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomPanelButton(
                initialImagePath: 'assets/images/bottom_panel/btn_1_1.png',
                pressedImagePath: 'assets/images/bottom_panel/btn_1_2.png',
                index: 0,
                activeButtonIndex: _activeButtonIndex,
                onTap: (index) {
                  setState(() {
                    _activeButtonIndex = index;
                  });
                },
              ),
              BottomPanelButton(
                initialImagePath: 'assets/images/bottom_panel/btn_2_1.png',
                pressedImagePath: 'assets/images/bottom_panel/btn_2_2.png',
                index: 1,
                activeButtonIndex: _activeButtonIndex,
                onTap: (index) {
                  setState(() {
                    _activeButtonIndex = index;
                  });
                },
              ),
              BottomPanelButton(
                initialImagePath: 'assets/images/bottom_panel/btn_3_1.png',
                pressedImagePath: 'assets/images/bottom_panel/btn_3_2.png',
                index: 2,
                activeButtonIndex: _activeButtonIndex,
                onTap: (index) {
                  setState(() {
                    _activeButtonIndex = index;
                  });
                },
              ),
              BottomPanelButton(
                initialImagePath: 'assets/images/bottom_panel/btn_4_1.png',
                pressedImagePath: 'assets/images/bottom_panel/btn_4_2.png',
                index: 3,
                activeButtonIndex: _activeButtonIndex,
                onTap: (index) {
                  setState(() {
                    _activeButtonIndex = index;
                  });
                },
              ),
              BottomPanelButton(
                initialImagePath: 'assets/images/bottom_panel/btn_5_1.png',
                pressedImagePath: 'assets/images/bottom_panel/btn_5_2.png',
                index: 4,
                activeButtonIndex: _activeButtonIndex,
                onTap: (index) {
                  setState(() {
                    _activeButtonIndex = index;
                  });
                },
              ),
            ],
          ),
        ),
      )
    ]));
  }
}

class BottomPanelButton extends StatelessWidget {
  final String initialImagePath;
  final String pressedImagePath;
  final int index;
  final int activeButtonIndex;
  final Function(int) onTap;

  const BottomPanelButton({
    required this.initialImagePath,
    required this.pressedImagePath,
    required this.index,
    required this.activeButtonIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Image.asset(
        activeButtonIndex == index ? pressedImagePath : initialImagePath,
        width: 64,
        height: 64,
      ),
    );
  }
}
