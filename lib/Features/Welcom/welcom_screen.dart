import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Features/Welcom/login_screen.dart';
import 'package:todoapp/Features/Welcom/signup_screen.dart';
import 'package:todoapp/Features/persentation/cuibts/tasks_cubit.dart';
import 'package:todoapp/Features/persentation/home_screen.dart';


class WelcomScreen extends StatelessWidget {

  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  const WelcomScreen({
    Key? key,
    required this.toggleTheme,
    required this.toggleLanguage,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    String uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/first.png', width: 300,height:300),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Text('Welcome to DO', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center, ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Text('Stay organized, focused, and in control of your day by easily capturing your tasks!', style: TextStyle(color: const Color.fromARGB(255, 41, 40, 39), fontSize: 20,), textAlign: TextAlign.center),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(
                    toggleTheme: toggleTheme,
                    toggleLanguage: toggleLanguage,
                  ),
                ),
              );
            },
            child: (Container
              (
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 250,
              height: 50,
              child: (Text('Sign In', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),)),),


          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupScreen(
                    toggleTheme: toggleTheme,
                    toggleLanguage: toggleLanguage,
                  ),
                ),
              );
            },
            child: (Container
              (
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 250,
              height: 50,
              child: (Text('Sign Up', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),)),),

          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => TasksCubit(uid),
                      child: HomeScreen(
                        toggleTheme: toggleTheme,
                        toggleLanguage: toggleLanguage,
                      ),
                    ),
                  ),
                ),
            },
              child:
              Text('Skip', style: TextStyle(fontSize: 20 )

                ,),
            ),
          ),
        ],
      )
      ),
    );
  }
}