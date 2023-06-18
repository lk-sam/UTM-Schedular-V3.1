import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final DateTime dueDateTime;
  final String venue;
  final String category;
  final String tag;
  final bool isRepeated;
  final String userId;

  Task({
    required this.id,
    required this.title,
    required this.dueDateTime,
    required this.venue,
    required this.category,
    required this.tag,
    required this.userId,
    this.isRepeated = false,
  });

  static Task fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: json['title'],
      dueDateTime: (json['dueDateTime'] as Timestamp).toDate(),
      venue: json['venue'],
      category: json['category'],
      tag: json['tag'],
      userId: json['userId'],
      isRepeated: json['isRepeated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dueDateTime': dueDateTime,
      'venue': venue,
      'category': category,
      'tag': tag,
      'userId': userId,
      'isRepeated': isRepeated,
    };
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
}
