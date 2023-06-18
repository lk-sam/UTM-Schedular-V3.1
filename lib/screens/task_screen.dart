import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:utmschedular/screens/new_task_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // New import

class TaskOverviewPage extends StatefulWidget {
  final TaskService taskService;  // inject TaskService

  const TaskOverviewPage({Key? key, required this.taskService}) : super(key: key);

  @override
  State<TaskOverviewPage> createState() => _HomePageState();
}

class _HomePageState extends State<TaskOverviewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = PageController();  // New controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "Task Overview", 
        scaffoldKey: _scaffoldKey
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                // You will need to create OverdueTasks, TodayTasks, and FutureTasks widgets.
                TasksList(taskService: widget.taskService, filter: TaskFilter.Overdue),
                TasksList(taskService: widget.taskService, filter: TaskFilter.Today),
                TasksList(taskService: widget.taskService, filter: TaskFilter.Future),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: controller,  // PageController
              count: 3,
              effect: ScrollingDotsEffect(
                activeDotColor: Theme.of(context).primaryColor,
                dotColor: Color(0xFFDADADA),
                dotHeight: 8,
                dotWidth: 8,
                ), 
              onDotClicked: (index) {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewTaskPage(taskService: widget.taskService)));
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}




enum TaskFilter { Overdue, Today, Future }

class TasksList extends StatelessWidget {
  final TaskService taskService;
  final TaskFilter filter;

  TasksList({required this.taskService, required this.filter});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: taskService.getTasks("A20EC0224"),
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
                  .where((task) => task.dueDateTime.isBefore(DateTime.now()))
                  .toList();
              break;
            case TaskFilter.Today:
              filteredTasks = snapshot.data!.where((task) =>
                  task.dueDateTime.day == DateTime.now().day &&
                  task.dueDateTime.month == DateTime.now().month &&
                  task.dueDateTime.year == DateTime.now().year).toList();
              break;
            case TaskFilter.Future:
              filteredTasks = snapshot.data!
                  .where((task) => task.dueDateTime.isAfter(DateTime.now()))
                  .toList();
              break;
          }

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              Task task = filteredTasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.category),
              );
            },
          );
        }
      },
    );
  }
}

