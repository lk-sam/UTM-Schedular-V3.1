import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:utmschedular/screens/new_task_screen.dart';

class TaskOverviewPage extends StatefulWidget {
  final TaskService taskService; // inject TaskService

  const TaskOverviewPage({Key? key, required this.taskService})
      : super(key: key);

  @override
  State<TaskOverviewPage> createState() => _HomePageState();
}

class _HomePageState extends State<TaskOverviewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: "Task Overview", scaffoldKey: _scaffoldKey),
      drawer: CustomDrawer(),
      body: StreamBuilder<List<Task>>(
        stream: widget.taskService.getTasks("A20EC0224"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // show progress indicator when loading
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              // show task list when data is ready
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Task task = snapshot.data![index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.category),
                  trailing: Text(task.dueDateTime.toString()),
                  
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => NewTaskPage(taskService: widget.taskService)));
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
