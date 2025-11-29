import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Features/Welcom/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/Features/persentation/home_screen.dart';


class SignupScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();
  final nameController = TextEditingController();

  SignupScreen({
    Key? key,
    required this.toggleTheme,
    required this.toggleLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Register')), backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/todoApp.png', width: 300,),

                  // Username
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: mailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      String pattern =
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Email is not valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Password
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password is very short';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Confirm Password
                  TextFormField(
                    controller: confirmpassController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please confirm your password';
                      }
                      if (value != passController.text) {
                        return 'Not matshed';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),

                  // Sign Up Button
                  InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          try {

                            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: mailController.text,
                              password: passController.text,
                            );


                            var user = FirebaseAuth.instance.currentUser;


                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(user!.uid)
                                .set({
                              "name": nameController.text,
                              "email": mailController.text,
                              "createdAt": DateTime.now(),
                            });


                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Account Created Successfully')),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                  toggleTheme: toggleTheme,
                                  toggleLanguage: toggleLanguage,
                                ),
                              ),
                            );

                          }
                          catch(e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },

                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 250,
                      height: 50,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}