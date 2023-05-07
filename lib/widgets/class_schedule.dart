import 'package:flutter/material.dart';

class ClassSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.schedule),
              SizedBox(width: 8),
              Text(
                'Class Schedule',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // ... rest of the Class Schedule header row ...
            ],
          ),
        ),
         Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Day',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Time Start',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Time End',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Venue',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                // Add functionality for deleting the class schedule
                                print('Delete class schedule button pressed');
                              },
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red, 
                                side: BorderSide(
                                    color: Colors.red,
                                    width: 1.0), // Set the border color to red
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
      ],
    );
  }
}
