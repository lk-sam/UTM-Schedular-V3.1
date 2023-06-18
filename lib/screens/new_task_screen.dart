import 'package:flutter/material.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:utmschedular/services/preference_service.dart';

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
  late Future<String> matricNo;

  @override
  void initState() {
    super.initState();
    matricNo = getMatricNo();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        backgroundColor: primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _venueController,
                decoration: InputDecoration(
                  labelText: 'Venue',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a venue';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                ),
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
                child: Text(
                  _dueDateTime == null
                      ? 'Select due date'
                      : 'Due date: ${_dueDateTime!.toIso8601String()}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder<String>(
                future: matricNo,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primaryColor),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Task newTask = Task(
                            title: _titleController.text,
                            venue: _venueController.text,
                            dueDateTime: _dueDateTime!,
                            category: 'Category',
                            userId: snapshot.data!,
                            isRepeated: false,
                            id:
                                                        '', 
                          );
                          await widget.taskService.createTask(newTask);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

