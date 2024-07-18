import 'package:cash_coin/pages/boost_page.dart';
import 'package:cash_coin/pages/ref_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import '../Bloc/counter_bloc.dart';
import '../Bloc/counter_event.dart';
import '../Bloc/counter_state.dart';
import '../main.dart';

import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CustomProgressBar extends StatelessWidget {
  final double progressValue;
  final List<Color> gradientColors;
  final String imagePath;

  CustomProgressBar({
    required this.progressValue,
    required this.gradientColors,
    required this.imagePath,
  });



  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width - 40;
     int maxPoints = 2000; // Максимальное количество очков энергии

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      width: double.infinity,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: Container(
              width: (progressValue / maxPoints) * containerWidth,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            left: (progressValue / maxPoints) * containerWidth - 10,
            child: Image.asset(
              imagePath,
              width: 10,
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  final int count;

  CounterDisplay({required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/btn_0.png',
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Text(
          '$count',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
            //fontFamily: 'Axiforma_Semi_Bold',
          ),
        ),
      ],
    );
  }
}



class TapPage extends StatefulWidget {
  const TapPage({Key? key}) : super(key: key);

  @override
  _TapPage createState() => _TapPage();
}

class _TapPage extends State<TapPage> with TickerProviderStateMixin {
  double _progressValue = 2000.0;
  var clic_coins = 0;
  var clic_energy = 2000;
  List<Offset> _textPositions = [];
  List<AnimationController> _animationControllers = [];
  List<Animation<double>> _animations = [];
  int _clickCount = 0;

  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _buttonAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(_buttonController);
  }

  void _addAnimation(Offset offset) {
    AnimationController controller = AnimationController(
      duration: Duration(milliseconds: 500), // Скорость анимации
      vsync: this,
      value: 0.1, // Высота отступа по y от клика
    );
    _animationControllers.add(controller);
    _animations.add(Tween<double>(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      }));
    controller.forward().then((_) {

    });
    _textPositions.add(offset);
  }



  @override
  void dispose() {
    _buttonController.dispose();
    for (AnimationController controller in _animationControllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _onButtonPressDown(TapDownDetails details) {
    _buttonController.forward();
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset localOffset = renderBox.globalToLocal(details.globalPosition);
    _addAnimation(localOffset);
  }

  void _onButtonPressUp() {
    _buttonController.reverse();
    if (_progressValue > 0) {
      context.read<CounterBloc>().add(IncrementCounter());
      setState(() {
        _clickCount++;
        clic_coins = _clickCount;
        _progressValue -= 1; // Уменьшаем энергию на 1 очко
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/Group 61.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 90,),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    int count = state is LoadedCounterState ? state.count : 0;
                    return CounterDisplay(count: count);
                  },
                ),
                Image.asset('assets/images/legendary.png'),
                SizedBox(height: 60),

                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    _onButtonPressDown(details);
                  },
                  onTapCancel: () {
                    _buttonController.reverse();
                  },
                  onTap: () async {
                    _onButtonPressUp();
                    final canVibrate = await Haptics.canVibrate();
                    if (canVibrate) {
                      await Haptics.vibrate(HapticsType.medium);
                    }
                  },

                  child: ScaleTransition(
                    scale: _buttonAnimation,
                    child: Image.asset(
                      'assets/images/btn_0.png',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 32),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset('assets/images/enerje.png', height: 12, width: 8, fit: BoxFit.cover,),
                      SizedBox(width: 8,),
                      Text(
                        '${_progressValue.toInt()}',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '/${clic_energy}',
                        style: TextStyle(color: Colors.white, fontSize: 10,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                CustomProgressBar(
                  progressValue: _progressValue,
                  gradientColors: [
                    Color(0xffFCBEF7),
                    Color(0xffC47E2B),
                    Color(0xff5614CC),
                  ],
                  imagePath: 'assets/images/btn_0.png',
                ),

              ],
            ),
          ),
          for (int i = 0; i < _textPositions.length; i++)
            Positioned(
              left: _textPositions[i].dx,
              top: _textPositions[i].dy - _animations[i].value * 300, // Летит вверх на 100 пикселей от точки нажатия
              child: Opacity(
                opacity: 1 - _animations[i].value,
                child: Text(
                  '+1',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),

        ],
      ),
    );
  }
}

class BottomPanelButton extends StatelessWidget {
  final String initialImagePath;
  final String pressedImagePath;
  final int index;
  final ValueChanged<int> onTap;
  final int activeButtonIndex; // Добавьте эту переменную

  BottomPanelButton({
    required this.initialImagePath,
    required this.pressedImagePath,
    required this.index,
    required this.onTap,
    required this.activeButtonIndex,
  });

  @override
  Widget build(BuildContext context) {
    double _bottomPanelBtnSize = 64.0;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Animate(
        effects: [FadeEffect()],
        child: Container(
          width: _bottomPanelBtnSize,
          height: _bottomPanelBtnSize,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                activeButtonIndex == index
                    ? pressedImagePath
                    : initialImagePath,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}



///Container(
//                 width: double.infinity,
//                 height: 110,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(30),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     BottomPanelButton(
//                       initialImagePath: 'assets/images/bottom_panel/btn_1_1.png',
//                       pressedImagePath: 'assets/images/bottom_panel/btn_1_2.png',
//                       index: 0,
//                       activeButtonIndex: _activeButtonIndex, // Добавьте эту строку в строку 326
//                       onTap: (index) {
//                         setState(() {
//                           _activeButtonIndex = index;
//                         });
//                       },
//                     ),
//                     BottomPanelButton(
//                       initialImagePath: 'assets/images/bottom_panel/btn_2_1.png',
//                       pressedImagePath: 'assets/images/bottom_panel/btn_2_2.png',
//                       index: 1,
//                       activeButtonIndex: _activeButtonIndex, // Добавьте эту строку в строку 326
//                       onTap: (index) {
//                         setState(() {
//                           _activeButtonIndex = index;
//                         });
//                       },
//                     ),
//                     BottomPanelButton(
//                       initialImagePath: 'assets/images/bottom_panel/btn_3_1.png',
//                       pressedImagePath: 'assets/images/bottom_panel/btn_3_2.png',
//                       index: 2,
//                       activeButtonIndex: _activeButtonIndex, // Добавьте эту строку в строку 326
//                       onTap: (index) {
//                         setState(() {
//                           _activeButtonIndex = index;
//                         });
//                       },
//                     ),
//                     BottomPanelButton(
//                       initialImagePath: 'assets/images/bottom_panel/btn_4_1.png',
//                       pressedImagePath: 'assets/images/bottom_panel/btn_4_2.png',
//                       index: 3,
//                       activeButtonIndex: _activeButtonIndex, // Добавьте эту строку в строку 326
//                       onTap: (index) {
//                         setState(() {
//                           _activeButtonIndex = index;
//                         });
//                       },
//                     ),
//
//
//                     BottomPanelButton(
//                       initialImagePath: 'assets/images/bottom_panel/btn_5_1.png',
//                       pressedImagePath: 'assets/images/bottom_panel/btn_5_2.png',
//                       index: 4,
//                       activeButtonIndex: _activeButtonIndex, // Добавьте эту строку в строку 326
//                       onTap: (index) {
//                         setState(() {
//                           _activeButtonIndex = index;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),