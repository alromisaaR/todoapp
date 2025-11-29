import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Features/persentation/models/task_model.dart';


class TasksCubit extends Cubit<List<TaskModel>> {
  final String userId;

  TasksCubit(this.userId) : super([]) {
    _listenToTasks();
  }

  void _listenToTasks() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .snapshots()
        .listen((snapshot) {
      final tasks = snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.id, doc.data()))
          .toList();
      emit(tasks);
    });
  }

  Future<void> addTask(TaskModel task) async {
    if (userId.isEmpty) return;

    final docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .add(task.toMap());

    task.id = docRef.id;
  }


  Future<void> toggleTask(TaskModel task) async {
    if (task.id.isEmpty) return;

    task.isDone = !task.isDone;
    emit(List.from(state));


    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(task.id)
        .update({'isDone': task.isDone});
  }

  Future<void> deleteTask(TaskModel task) async {
    if (task.id.isEmpty) return;

    emit(state.where((t) => t.id != task.id).toList());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(task.id)
        .delete();
  }
}




