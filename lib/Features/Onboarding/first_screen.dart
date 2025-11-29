import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/first.png', width: 300,height:300),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Text('Capture Your Ideas', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center, ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Text('Don’t let your thoughts slip away. Save every idea the moment it comes and keep everything in one place', style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center),
          )
        ],
      )
      ),
    );
  }
}