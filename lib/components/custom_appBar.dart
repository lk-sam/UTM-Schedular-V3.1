import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utmschedular/screens/profile_screen.dart';

import '../constants/routes.dart';
import '../models/DTO/userDTO.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  late Future<UserDTO> userInfo = Future.value();
  final users = FirebaseFirestore.instance;

  //Use to get username and password form firestore.
  Future<UserDTO> getUserAuth(matricNo) async {
    final snapshot = await users
        .collection('User')
        .where("MatricNo", isEqualTo: matricNo)
        .get();
    final userData = snapshot.docs.map((e) => UserDTO.fromSnapshot(e)).single;
    return userData;
  }

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
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final matricNo = prefs.getString('matricNo');
                            userInfo = getUserAuth(matricNo);
                            UserDTO convertUserInfo = await userInfo;
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileScreen(user: convertUserInfo)),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.lock_reset_outlined),
                          title: Text('Change Password'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, changePassRoute);
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
}

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('matricNo');
  Navigator.pushReplacementNamed(context, '/');
}
