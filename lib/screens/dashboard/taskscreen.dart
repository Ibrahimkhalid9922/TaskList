import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_list/utils/constants/colors.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    QuerySnapshot snapshot = await _firestore.collection('tasks').get();
    setState(() {
      _tasks = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'task': doc['task'],
        };
      }).toList();
    });
  }

  Future<void> _addTask(String task) async {
    await _firestore.collection('tasks').add({'task': task});
    _fetchTasks();
  }

  Future<void> _updateTask(String id, String newTask) async {
    await _firestore.collection('tasks').doc(id).update({'task': newTask});
    _fetchTasks();
  }

  Future<void> _deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
    _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.themeColor,
        title: const Text(
          'Tasks',
          style: TextStyle(color: AppColor.textColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/task.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      title: Text(task['task']),
                      trailing: Wrap(
                        spacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showEditTaskDialog(
                                  context, task['id'], task['task']);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteConfirmationDialog(
                                  context, task['id']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.themeColor,
        shape: const CircleBorder(),
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: AppColor.textColor,
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String task = '';
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            onChanged: (value) {
              task = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter task details',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.themeColor),
              child: const Text(
                'Add',
                style: TextStyle(color: AppColor.textColor),
              ),
              onPressed: () {
                if (task.isNotEmpty) {
                  _addTask(task);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(
      BuildContext context, String id, String currentTask) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedTask = currentTask;
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            onChanged: (value) {
              updatedTask = value;
            },
            controller: TextEditingController(text: currentTask),
            decoration: const InputDecoration(
              hintText: 'Enter new task details',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.themeColor),
              child: const Text('Update'),
              onPressed: () {
                if (updatedTask.isNotEmpty) {
                  _updateTask(id, updatedTask);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteTask(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
