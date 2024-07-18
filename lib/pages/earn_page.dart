import 'package:flutter/material.dart';

class EarnPage extends StatelessWidget {
  const EarnPage({super.key});

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

        ],
      ),
    );
  }
}
