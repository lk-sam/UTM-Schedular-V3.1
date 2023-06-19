import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:utmschedular/models/domain/task.dart';

class TaskManager {
  final TaskService taskService;
  final TaskHiveService taskHiveService;
  final Connectivity connectivity;

  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  TaskManager({
    required this.taskService,
    required this.taskHiveService,
    required this.connectivity,
  }) {
    // Listen for connectivity changes
    connectivitySubscription = connectivity.onConnectivityChanged.listen((result) {
      // If the device is connected, sync the tasks from Hive to Firebase
      if (result != ConnectivityResult.none) {
        _syncTasks();
      }
    });
  }

 // Update the getTasks method to return a stream of tasks
Stream<List<Task>> getTasks(String userId) {
  return taskService.getTasks(userId);
}

// Add a new method to get tasks when offline
Future<List<Task>> getTasksOffline(String userId) async {
  final connectivityResult = await connectivity.checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    // Device is offline, use Hive
    return taskHiveService.getTasksFromHive(userId);
  } else {
    throw Exception("Device is online, use stream instead.");
  }
}


  // Sync tasks from Hive to Firebase
  Future<void> _syncTasks() async {
    try {
      // This is a basic example. You might want to add more advanced
      // conflict resolution, error handling, etc.
      final tasks = taskHiveService.getTasksFromHive('*'); // get all tasks from Hive
      for (var task in tasks) {
        await taskService.createTask(task);
        await taskHiveService.deleteTaskFromHive(task); // remove task from Hive after it's pushed to Firebase
      }
    } catch (e) {
      // Handle error, perhaps by re-throwing or logging it
      throw e;
    }
  }


Future<void> createTask(Task newTask) async {
  final connectivityResult = await connectivity.checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    // Device is offline, use Hive
    await taskHiveService.createTaskInHive(newTask);
  } else {
    // Device is online, use Firebase
    await taskService.createTask(newTask);
  }
}


  void dispose() {
    // Cancel the connectivity subscription when the TaskManager is disposed
    connectivitySubscription?.cancel();
  }
}
