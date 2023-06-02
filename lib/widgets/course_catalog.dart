import 'package:flutter/material.dart';

class CourseCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
          children: [
            Icon(Icons.book),
            SizedBox(width: 8),
            Text(
              'Course Catalog',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
         Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Course Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Course Code',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  labelText: 'Section No',
                                  border: OutlineInputBorder(),
                                ),
                                value: 1,
                                onChanged: (int? newValue) {
                                  print('Selected section: $newValue');
                                },
                                items: List<DropdownMenuItem<int>>.generate(
                                  10,
                                  (int index) => DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Text('${index + 1}'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Lecturer',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ],
    );
  }
}
