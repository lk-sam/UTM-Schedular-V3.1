import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:utmschedular/screens/new_task_screen.dart';
import 'package:utmschedular/services/preference_service.dart';
import 'package:utmschedular/widgets/task_overview.dart';

enum TaskFilter { Overdue, Today, Future }

class TasksList extends StatelessWidget {
  final TaskService taskService;
  final TaskFilter filter;

  TasksList({required this.taskService, required this.filter});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getMatricNo(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final matricNo = snapshot.data ?? '';

          return StreamBuilder<List<Task>>(
            stream: taskService.getTasks(matricNo),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Task> filteredTasks = [];

                switch (filter) {
                  case TaskFilter.Overdue:
                    filteredTasks = snapshot.data!
                        .where(
                            (task) => task.dueDateTime.isBefore(DateTime.now()))
                        .toList();
                    break;
                  case TaskFilter.Today:
                    filteredTasks = snapshot.data!
                        .where((task) =>
                            task.dueDateTime.day == DateTime.now().day &&
                            task.dueDateTime.month == DateTime.now().month &&
                            task.dueDateTime.year == DateTime.now().year)
                        .toList();
                    break;
                  case TaskFilter.Future:
                    filteredTasks = snapshot.data!
                        .where(
                            (task) => task.dueDateTime.isAfter(DateTime.now()))
                        .toList();
                    break;
                }

                filteredTasks = filteredTasks.where((task) => !task.isCompleted).toList();

                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          filter == TaskFilter.Overdue
                              ? 'Overdue Tasks'
                              : filter == TaskFilter.Today
                                  ? 'Today\'s Tasks'
                                  : 'Future Tasks',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredTasks.length +
                              (filter == TaskFilter.Today ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == filteredTasks.length &&
                                filter == TaskFilter.Today) {
                              return Card(
                                elevation: 4,
                                child: ListTile(
                                  leading: Icon(Icons.add),
                                  title: Text('Add Task'),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => NewTaskPage(
                                                taskService: taskService)));
                                  },
                                ),
                              );
                            } else {
                              Task task = filteredTasks[index];
                              return Card(
                                elevation: 4,
                                child: ListTile(
                                  leading: IconButton(
                                    icon: Icon(task.isCompleted ? Icons.check_circle_outline : Icons.circle_outlined),
                                    onPressed: () {
                                      taskService.toggleTaskCompletion(task);
                                    },
                                  ),
                                  title: Text(task.title),
                                  subtitle: Text(task.category),
                                  trailing: Text(task.dueDateTime.toString()),
                                  //isThreeLine: true,
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return FractionallySizedBox(
                                            heightFactor: 2 / 3,
                                            child: TaskOverviewPage(task: task),
                                          );
                                        });
                                  },
                                  // onLongPress: () {
                                  //   showDialog(
                                  //     context: context, 
                                  //     builder: (context) {

                                  //     }
                                  //     )
                                  // },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
