import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Features/persentation/cuibts/tasks_cubit.dart';
import 'package:todoapp/Features/persentation/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleController = TextEditingController();
  DateTime? selectedDate;

  final List<String> categoriesKeys = ["work", "home", "study"];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasksCubit>();
    List<String> categories = categoriesKeys.map((key) => "categories.$key".tr()).toList();


    return Scaffold(
      appBar: AppBar(
        title: Text('addTask').tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "whatIsToDo".tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'taskTitle'.tr(),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "taskDate".tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  setState(() {
                    selectedDate = date;
                  });
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "selectDate".tr(),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                child: Text(
                  selectedDate == null
                      ? "noDateSelected".tr()
                      : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "taskCategory".tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "taskCategory".tr(),
                      border: OutlineInputBorder(),
                    ),
                    items: categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      );
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() => selectedCategory = value);
                    },
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    String? newCat = await showDialog(
                      context: context,
                      builder: (_) {
                        TextEditingController controller =
                        TextEditingController();
                        return AlertDialog(
                          title: Text("Add new category".tr()),
                          content: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: "Category name".tr(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, controller.text);
                              },
                              child: Text("Add".tr()),
                            )
                          ],
                        );
                      },
                    );

                    if (newCat != null && newCat.isNotEmpty) {
                      setState(() {
                        categories.add(newCat);
                        selectedCategory = newCat;
                      });
                    }
                  },
                  icon: Icon(Icons.add),
                )
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCategory == null || selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields").tr()),
                    );
                    return;
                  }

                  final task = TaskModel(
                    id: '',
                    title: titleController.text,
                    category: selectedCategory!,
                    date: selectedDate!,
                  );

                  cubit.addTask(task);
                  Navigator.pop(context);
                },
                child: Text('addTask').tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


