import 'package:flutter/material.dart';
import 'package:utmschedular/components/custom_appBar.dart';
import 'package:utmschedular/components/custom_drawer.dart';
import 'package:utmschedular/widgets/timetable_container.dart';
import 'package:utmschedular/screens/testing_data.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: "TimeTable", scaffoldKey: _scaffoldKey),
      drawer: CustomDrawer(),
      body: TimetableContainer(timetables: timetables),
    );
  }
}

class ExampleTimetable extends StatefulWidget {
  const ExampleTimetable({Key? key}) : super(key: key);

  @override
  State<ExampleTimetable> createState() => _ExampleTimetableState();
}

class _ExampleTimetableState extends State<ExampleTimetable> {
  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('products');

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: "TimeTable", scaffoldKey: _scaffoldKey),
      // Using StreamBuilder to display all products from Firestore in real-time
      drawer: CustomDrawer(),
      body: StreamBuilder(
        stream: _productss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['price'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async =>{await FirebaseAPI.createOrUpdate( _nameController, _priceController,context,_productss,documentSnapshot)}
                          ),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async =>{await FirebaseAPI.deleteProduct(documentSnapshot.id,_productss,context)})
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseAPI.createOrUpdate(_nameController, _priceController,context,_productss),
        child: const Icon(Icons.add),
      ),
    );
  }
}
