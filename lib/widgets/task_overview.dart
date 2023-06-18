import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:provider/provider.dart';

enum TaskAction { Edit, Delete, Complete }
class TaskOverviewPage extends StatefulWidget {
  final Task task;

  const TaskOverviewPage({Key? key, required this.task}) : super(key: key);

  @override
  _TaskOverviewPageState createState() => _TaskOverviewPageState();
}

class _TaskOverviewPageState extends State<TaskOverviewPage> {
  late TextEditingController _titleController;
  late TextEditingController _venueController;
  DateTime? _dueDateTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _venueController = TextEditingController(text: widget.task.venue);
    _dueDateTime = widget.task.dueDateTime;
  }

  Future<void> _showEditModal(String field) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Edit $field'),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: field,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement save functionality here
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onTaskActionSelected(TaskAction action) {
    final taskService = Provider.of<TaskService>(context, listen: false);
    switch (action) {
      case TaskAction.Edit:
        // implement editing task
        break;
      case TaskAction.Delete:
        // implement deleting task
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
                    taskService.deleteTask(widget.task);
                  },
                ),
              ],
            );
          },
        );
        break;
      case TaskAction.Complete:
        // implement completing task
          Navigator.pop(context);
          taskService.toggleTaskCompletion(widget.task);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.circle_outlined),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        widget.task.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      onTap: () => _showEditModal('Title'),
                    ),
                  ),
                   PopupMenuButton<TaskAction>(
                    onSelected: _onTaskActionSelected,
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<TaskAction>>[
                      const PopupMenuItem<TaskAction>(
                        value: TaskAction.Edit,
                        child: Text('Edit Task'),
                      ),
                      const PopupMenuItem<TaskAction>(
                        value: TaskAction.Delete,
                        child: Text('Delete Task'),
                        
                      ),
                      const PopupMenuItem<TaskAction>(
                        value: TaskAction.Complete,
                        child: Text('Complete Task'),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today_outlined, size: 40),
                title: Text(
                  'Due Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _dueDateTime.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () => _showEditModal('Due Date'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.location_on, size: 40),
                title: Text(
                  'Venue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  widget.task.venue,
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () => _showEditModal('Venue'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.category, size: 40),
                title: Text(
                  'Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  widget.task.category,
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () => _showEditModal('Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
