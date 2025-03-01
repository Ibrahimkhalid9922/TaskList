// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class TaskService {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// //   Future<List<Map<String, dynamic>>> fetchTasks() async {
// //     QuerySnapshot snapshot = await _firestore.collection('tasks').get();
// //     return snapshot.docs.map((doc) {
// //       return {
// //         'id': doc.id,
// //         'task': doc['task'],
// //       };
// //     }).toList();
// //   }

// //   Future<void> addTask(String task) async {
// //     await _firestore.collection('tasks').add({'task': task});
// //   }

// //   Future<void> updateTask(String id, String newTask) async {
// //     await _firestore.collection('tasks').doc(id).update({'task': newTask});
// //   }

// //   Future<void> deleteTask(String id) async {
// //     await _firestore.collection('tasks').doc(id).delete();
// //   }
// // }

// // class TaskController {
// //   final TaskService _taskService = TaskService();

// //   Future<List<Map<String, dynamic>>> fetchTasks() {
// //     return _taskService.fetchTasks();
// //   }

// //   Future<void> addTask(String task) {
// //     return _taskService.addTask(task);
// //   }

// //   Future<void> updateTask(String id, String updatedTask) {
// //     return _taskService.updateTask(id, updatedTask);
// //   }

// //   Future<void> deleteTask(String id) {
// //     return _taskService.deleteTask(id);
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';

// class TaskRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<Map<String, dynamic>>> fetchTasks() async {
//     QuerySnapshot snapshot = await _firestore.collection('tasks').get();
//     return snapshot.docs.map((doc) {
//       return {
//         'id': doc.id,
//         'task': doc['task'],
//       };
//     }).toList();
//   }

//   Future<void> addTask(String task) async {
//     await _firestore.collection('tasks').add({'task': task});
//   }

//   Future<void> updateTask(String id, String newTask) async {
//     await _firestore.collection('tasks').doc(id).update({'task': newTask});
//   }

//   Future<void> deleteTask(String id) async {
//     await _firestore.collection('tasks').doc(id).delete();
//   }
// }
// task_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionPath = 'tasks'; // Collection name in Firestore

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    try {
      final snapshot = await _db.collection(_collectionPath).get();
      return snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  Future<void> addTask(String task) async {
    try {
      await _db.collection(_collectionPath).add({'task': task});
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Future<void> updateTask(String id, String updatedTask) async {
    try {
      await _db
          .collection(_collectionPath)
          .doc(id)
          .update({'task': updatedTask});
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _db.collection(_collectionPath).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}

// task_controller.dart

class TaskController {
  final TaskService _taskService = TaskService();

  Future<List<Map<String, dynamic>>> fetchTasks() {
    return _taskService.fetchTasks();
  }

  Future<void> addTask(String task) {
    return _taskService.addTask(task);
  }

  Future<void> updateTask(String id, String updatedTask) {
    return _taskService.updateTask(id, updatedTask);
  }

  Future<void> deleteTask(String id) {
    return _taskService.deleteTask(id);
  }
}
