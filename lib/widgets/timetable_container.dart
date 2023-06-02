import 'package:flutter/material.dart';
import '../models/domain/timetable.dart';
import '../widgets/timetable_card.dart';

class TimetableContainer extends StatelessWidget {
  final List<Timetable> timetables;

  const TimetableContainer({Key? key, required this.timetables})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
        toolbarHeight: 0,
      ),
      body: Column(
          //screnn container
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  //body
                  Expanded(
                    /*1*/
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          color: const Color.fromARGB(0, 255, 255, 255),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "images/timetable_icon.png",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            const Text(
                              "My Timetable",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          // space
                          height: 10,
                          color: const Color.fromARGB(0, 33, 149, 243),
                        ),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.0,
                                      // assign the color to the border color
                                      color: const Color.fromARGB(
                                          255, 240, 62, 62),
                                    ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("images/plus_icon.png",
                                            fit: BoxFit.cover),
                                        const Text("New"),
                                      ]),
                                ),
                                Container(
                                  height: 30,
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.0,
                                      // assign the color to the border color
                                      color: const Color.fromARGB(
                                          255, 240, 62, 62),
                                    ),
                                  ),
                                  child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Search...       "),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   //search bar
                        //   height: 70,
                        //   child:
                        // ),
                        Container(
                          height: 10,
                          color: const Color.fromARGB(0, 33, 149, 243),
                        ),
                        Container(
                          //body
                          height: 450,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: ListView.builder(
                            itemCount: timetables.length,
                            itemBuilder: (context, index) {
                              return TimetableCard(
                                  timetable: timetables[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
