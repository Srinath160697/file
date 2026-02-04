import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/core/model/model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  final _collection = FirebaseFirestore.instance.collection('tasks');

  Future<void> fetchTasks() async {
    final snapshot = await _collection.get();
    _tasks = snapshot.docs.map((doc) => Task.fromDocument(doc)).toList();
    notifyListeners();
  }

  Future<void> addTask(String title, String description, String date) async {
    final docRef = await _collection.add({
      'title': title,
      'description': description,
      'date': date,
      'isCompleted': false,
    });

    _tasks.add(Task(
      id: docRef.id,
      title: title,
      description: description,
      date: date,
      isCompleted: false,
    ));
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _collection.doc(task.id).update(task.toMap());
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    await _collection.doc(id).delete();
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
