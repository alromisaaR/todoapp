import 'package:flutter/material.dart';
import 'package:todoapp/Features/persentation/cuibts/tasks_cubit.dart';
import 'package:todoapp/Features/persentation/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class LoginScreen extends StatelessWidget {


  final _formKey = GlobalKey<FormState>();

  final mailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  // LoginScreen({super.key});

  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  LoginScreen({
    super.key,
    required this.toggleTheme,
    required this.toggleLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/todoApp.png',
                    width: 300,
                  ),

                  // Email
                  TextFormField(
                    controller: mailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                        return 'Password is too short';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Username
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                  SizedBox(height: 24),

                  // Login Button
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {

                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: mailController.text,
                            password: passController.text,
                          );


                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login Successful!')),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<TasksCubit>(
                                create: (context) => TasksCubit(FirebaseAuth.instance.currentUser!.uid),
                                child: HomeScreen(
                                  toggleTheme: toggleTheme,
                                  toggleLanguage: toggleLanguage,
                                ),
                              ),
                            ),
                          );



                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all fields')),
                        );
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
                        'Login',
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