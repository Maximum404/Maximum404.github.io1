import 'package:flutter/material.dart';

class BoostPage extends StatelessWidget {
  const BoostPage({super.key});

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
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28)),
                ),
                height: 180,
              ),
              Text(
                'Your daily boosters:',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 60,
                      width: 164,
                      child: Image.asset('assets/images/boost/guru.png')),
                  //SizedBox(width: 15,),
                  SizedBox(
                      height: 60,
                      width: 164,
                      child: Image.asset('assets/images/boost/tank.png')),
                ],
              ),
              Text(
                'Boosters:',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 340,
                height: 80,
                child: Card(
                  color: Colors.white.withOpacity(0.33),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/boost/3d-mini-gamepad.png'),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Multitap',
                                  style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                              Text('600 000',
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),


                      // Replace with your image path
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: Colors.white.withOpacity(0.54),
                          size: 30,
                        ),
                        // Replace with your check icon
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 340,
                height: 80,
                child: Card(
                  color: Colors.white.withOpacity(0.33),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/boost/3d-mini-gamepad.png'),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Multitap',
                                  style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                              Text('600 000',
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),


                      // Replace with your image path
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: Colors.white.withOpacity(0.54),
                          size: 30,
                        ),
                        // Replace with your check icon
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 340,
                height: 80,
                child: Card(
                  color: Colors.white.withOpacity(0.33),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/boost/3d-mini-gamepad.png'),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Multitap',
                                  style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                              Text('600 000',
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),


                      // Replace with your image path
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: Colors.white.withOpacity(0.54),
                          size: 30,
                        ),
                        // Replace with your check icon
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ))
        ],
      ),
    );
  }
}
