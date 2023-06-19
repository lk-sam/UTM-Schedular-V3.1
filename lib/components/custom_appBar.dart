import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utmschedular/constants/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('User');
  String name = "";
  String matric = "";
  String role = "";

  CustomAppBar({required this.title, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF81163F),
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return Container(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('View Profile'),
                          onTap: () {
                            showProfileDialog(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Change Password'),
                          onTap: () {
                            showChangePasswordDialog();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Log Out'),
                          onTap: () {
                            logout(context);
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void showProfileDialog(BuildContext context) => showDialog(
      builder: (context) => Dialog(
          insetPadding: EdgeInsets.fromLTRB(30, 130, 30, 130),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(children: [
            Container(
                height: 80,
                alignment: Alignment.center,
                child: const Text('User Profile',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
            Row(children: [
              Container(
                  width: Get.width * 0.30,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                  alignment: Alignment.centerLeft,
                  child: const Text('Name:',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: const Text(':',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ]),
            Row(children: [
              Container(
                  width: Get.width * 0.30,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                  alignment: Alignment.centerLeft,
                  child: const Text('Matric No',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: const Text(':',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ]),
            Row(children: [
              Container(
                  width: Get.width * 0.30,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                  alignment: Alignment.centerLeft,
                  child: const Text('Role:',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: const Text(':',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ]),
          ])),
      context: context);

  void showChangePasswordDialog() {}

  void getUserID() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      name = userDoc.get('fullname');
    });
  }
}

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('matricNo');
    Navigator.pushReplacementNamed(context, '/');
  }

