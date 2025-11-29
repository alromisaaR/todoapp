import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/second.png', width: 300,height:300),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Text('Plan Your Tasks', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center, ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Text('Turn your ideas into a clear to-do list. Write your tasks, organize them, and set your priorities in seconds.', style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center),
          )
        ],
      )
      ),
    );
  }
}