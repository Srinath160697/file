import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/constant/Widgets/common_widgets.dart';
import 'package:project/core/provider/provider.dart';
import 'package:project/presentation/authentication/email_login.dart';
import 'package:project/presentation/todo_screens/edit_task.dart';
import 'package:project/services/services.dart';
import 'package:provider/provider.dart';

class Show_Listview extends StatefulWidget {
  const Show_Listview({super.key});

  @override
  State<Show_Listview> createState() => _Show_ListviewState();
}

class _Show_ListviewState extends State<Show_Listview> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final FirebaseService authService = FirebaseService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
              if (context.mounted) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const EmailLoginPage()));
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: taskProvider.tasks.isEmpty
          ? Center(
              child: Text(
                "No tasks added yet...",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return buildTaskCard(
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => EditTaskDialog(task: task),
                    );
                  },
                  task: task,
                  onToggleComplete: (val) {
                    task.isCompleted = val!;
                    taskProvider.updateTask(task);
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Delete Task"),
                        content: const Text(
                            "Are you sure you want to delete this task?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              taskProvider.deleteTask(task.id);
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("Delete",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/todolist');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
        ),
        child: const Text(
          "Add Task",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
