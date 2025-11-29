import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:todoapp/Features/Welcom/login_screen.dart';
import 'package:todoapp/Features/persentation/add_task_screen.dart';
import 'package:todoapp/Features/persentation/cuibts/tasks_cubit.dart';
import 'package:todoapp/Features/persentation/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final List<String> images = [
    'assets/images/first.png',
    'assets/images/second.png',
    'assets/images/third.png',
  ];

  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  HomeScreen({
    Key? key,
    required this.toggleTheme,
    required this.toggleLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;


    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(
              toggleTheme: toggleTheme,
              toggleLanguage: toggleLanguage,
            ),
          ),
        );
      });


      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }


    return BlocProvider(
      create: (context) => TasksCubit(user.uid),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Image.asset(
              'assets/images/todoApp.png',
              fit: BoxFit.cover,
              width: 100,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.brightness_6),
                onPressed: toggleTheme,
              ),
              IconButton(
                icon: Icon(Icons.language),
                onPressed: toggleLanguage,
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(
                        toggleTheme: toggleTheme,
                        toggleLanguage: toggleLanguage,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                ),
                items: images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(
                          i,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<TasksCubit, List<TaskModel>>(
                  builder: (context, tasks) {
                    if (tasks.isEmpty) {
                      return Center(child: Text('noTasks').tr());
                    }
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: ListTile(
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (value) {
                                context.read<TasksCubit>().toggleTask(task);
                              },
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Text(
                              '${task.category}  |  ${task.date.toLocal().toString().split(" ").first}',
                              style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context.read<TasksCubit>().deleteTask(task);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;

              if (user == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      toggleTheme: toggleTheme,
                      toggleLanguage: toggleLanguage,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<TasksCubit>(),
                      child: AddTaskPage(),
                    ),
                  ),
                );
              }
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}



