import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/third.png', width: 300,height:300),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Text('Get Things Done', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center, ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Text('Check off tasks one by one and feel your progress. Step by step, you’ll reach everything you aim for.', style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center),
          )
        ],
      )
      ),
    );
  }
}