import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';  // Name of the generated file

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime dueDateTime;

  @HiveField(3)
  final String venue;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final bool isRepeated;

  @HiveField(6)
  final String userId;

  @HiveField(7)
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.dueDateTime,
    required this.venue,
    required this.category,
    required this.userId,
    this.isRepeated = false,
    this.isCompleted = false,
  });

  static Task fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: json['title'],
      dueDateTime: (json['dueDateTime'] as Timestamp).toDate(),
      venue: json['venue'],
      category: json['category'],
      userId: json['userId'],
      isRepeated: json['isRepeated'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dueDateTime': dueDateTime,
      'venue': venue,
      'category': category,
      'userId': userId,
      'isRepeated': isRepeated,
      'isCompleted': isCompleted,
    };
  }

  // Factory constructor to create a Task object from a Map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      dueDateTime: DateTime.parse(json['dueDateTime'] as String),
      venue: json['venue'] as String,
      category: json['category'] as String,
      userId: json['userId'] as String,
      isRepeated: json['isRepeated'] as bool,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}

class TaskService {
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('tasks');
  
  // Create new task in Firestore
  Future<void> createTask(Task task) async {
    DocumentReference docRef = await taskCollection.add(task.toJson());
    await docRef.update(
        {'id': docRef.id}); // update the task document with the generated ID
  }

  // Get all tasks of a user from Firestore
  Stream<List<Task>> getTasks(String userId) {
    return taskCollection.where('userId', isEqualTo: userId).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Task.fromDocument(doc)).toList());
  }

  // Update existing task in Firestore
  Future<void> updateTask(Task task) async {
    await taskCollection.doc(task.id).update(task.toJson());
  }

  // Delete task from Firestore
  Future<void> deleteTask(Task task) async {
    await taskCollection.doc(task.id).delete();
  }

  //toggle task completion status
  Future<void> toggleTaskCompletion(Task task) async {
    await taskCollection.doc(task.id).update({'isCompleted': !task.isCompleted});
  }
}

class TaskHiveService {
  late Box<Task> taskBox;

  TaskHiveService() {
    _openBox();
  }

  Future<void> _openBox() async {
    taskBox = await Hive.openBox<Task>('tasks');
  }

   // Create new task in Hive
  Future<void> createTaskInHive(Task task) async {
    await taskBox.put(task.id, task);
  }

  // Get all tasks of a user from Hive
  List<Task> getTasksFromHive(String userId) {
    return taskBox.values
        .map((json) => Task.fromJson(json as Map<String, dynamic>))
        .where((task) => task.userId == userId)
        .toList(growable: false);
  }

  // Update existing task in Hive
  Future<void> updateTaskInHive(Task task) async {
    await taskBox.put(task.id, task);
  }

  // Delete task from Hive
  Future<void> deleteTaskFromHive(Task task) async {
    await taskBox.delete(task.id);
  }

  // Toggle task completion status in Hive
  Future<void> toggleTaskCompletionInHive(Task task) async {
    task.isCompleted = !task.isCompleted;
    await taskBox.put(task.id, task);
  }

  void close() {
    taskBox.close();
  }
}
