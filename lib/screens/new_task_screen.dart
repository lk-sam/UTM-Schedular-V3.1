import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/task.dart';

class NewTaskPage extends StatefulWidget {
  final TaskService taskService;

  const NewTaskPage({Key? key, required this.taskService}) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  DateTime? _dueDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Task Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _venueController,
                decoration: InputDecoration(labelText: 'Venue'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a venue';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2099),
                  );
                  if (picked != null && picked != _dueDateTime) {
                    setState(() {
                      _dueDateTime = picked;
                    });
                  }
                },
                child: Text(_dueDateTime == null ? 'Select due date' : 'Due date: ${_dueDateTime!.toIso8601String()}'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Task newTask = Task(
                      title: _titleController.text,
                      venue: _venueController.text,
                      dueDateTime: _dueDateTime!,
                      category: 'Category', 
                      tag: 'Tag', 
                      userId: 'A20EC0224', 
                      isRepeated: false, 
                      id: '', 
                    );
                    await widget.taskService.createTask(newTask);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
