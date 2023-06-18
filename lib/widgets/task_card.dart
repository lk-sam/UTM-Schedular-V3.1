import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:utmschedular/screens/edit_task_screen.dart';
import 'package:utmschedular/widgets/task_overview.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final TaskService taskService;

  TaskCard({required this.task, required this.taskService});

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        setState(() {
          _isPressed = true;
        });
      },
      onLongPressEnd: (details) {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
         transform: (_isPressed) ? (Matrix4.identity()..scale(0.95)) : Matrix4.identity(),
        child: Card(
          elevation: 4,
          child: ListTile(
            leading: IconButton(
              icon: Icon(widget.task.isCompleted ? Icons.check_circle_outline : Icons.circle_outlined),
              onPressed: () {
                widget.taskService.toggleTaskCompletion(widget.task);
              },
            ),
            title: Text(widget.task.title),
            subtitle: Text(widget.task.category),
            trailing: Text(widget.task.dueDateTime.toString()),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 2 / 3,
                      child: TaskOverviewPage(task: widget.task),
                    );
                  });
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text('Select action'),
                    children: [
                      SimpleDialogOption(
                        child: Text('Edit'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditTaskPage(task: widget.task, taskService: widget.taskService)));
                        },
                      ),
                      SimpleDialogOption(
                        child: Text('Delete'),
                        onPressed: () {
                          Navigator.pop(context);
                          //confirmation
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete task'),
                                content: Text('Are you sure you want to delete this task?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      widget.taskService.deleteTask(widget.task);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SimpleDialogOption(
                        child: Text('Complete'),
                        onPressed: () {
                          Navigator.pop(context);
                          widget.taskService.toggleTaskCompletion(widget.task);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

