import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  final String title;
  final String category;
  final DateTime date;
  bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    this.isDone = false,
  });


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'date': Timestamp.fromDate(date),
      'isDone': isDone,
    };
  }


  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      date: map['date'] != null && map['date'] is Timestamp
          ? (map['date'] as Timestamp).toDate()
          : DateTime.now(),
      isDone: map['isDone'] ?? false,
    );
  }
}



