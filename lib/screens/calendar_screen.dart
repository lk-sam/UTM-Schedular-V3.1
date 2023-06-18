import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:utmschedular/utils/utils.dart';
import 'package:utmschedular/models/domain/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getMatricNo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? matricNo = prefs.getString('matricNo');
  return matricNo ??
      ''; // returns the stored matricNo if it exists, else an empty string
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by long pressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    _loadTasks();
  }

  void _loadTasks() async {
    final matricNo = await getMatricNo();
    final taskService = TaskService();
    final taskStream = taskService.getTasks(matricNo);
    taskStream.listen((taskList) {
      setState(() {
        tasks = taskList;
      });
    });
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Task> _getTasksForSelectedDate(DateTime selectedDate, List<Task> tasks) {
    return tasks
        .where((task) =>
            task.dueDateTime.year == selectedDate.year &&
            task.dueDateTime.month == selectedDate.month &&
            task.dueDateTime.day == selectedDate.day)
        .toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  Widget _buildMarker(BuildContext context, DateTime day, List<Event> events) {
    final tasksCount = _getTasksForSelectedDate(day, tasks).length;

    if (tasksCount == 0) {
      return SizedBox(); // Return an empty SizedBox if tasksCount is 0
    }

    return Positioned(
      bottom: 4,
      right: 4,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(color: Colors.amber[800]),
        child: Center(
          child: Text(
            '$tasksCount',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<String> matricNo = getMatricNo();
    print(_calendarFormat);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: "Calendar", scaffoldKey: _scaffoldKey),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            calendarBuilders: CalendarBuilders(
              markerBuilder: _buildMarker,
            ),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 92, 0, 31), //Color(0xFF81163F),
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                  print("change to ${_calendarFormat}");
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: FutureBuilder<String>(
              future: getMatricNo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final matricNo = snapshot.data ?? '';
                  return StreamBuilder<List<Task>>(
                    stream: TaskService().getTasks(matricNo),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final tasks = snapshot.data!;
                        final selectedTasks =
                            _getTasksForSelectedDate(_selectedDay!, tasks);
                        return ListView.builder(
                          itemCount: selectedTasks.length,
                          itemBuilder: (context, index) {
                            final task = selectedTasks[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                onTap: () => print('${task.title} tapped'),
                                title: Text(task.title),
                                subtitle: Text(task.dueDateTime.toString()),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
