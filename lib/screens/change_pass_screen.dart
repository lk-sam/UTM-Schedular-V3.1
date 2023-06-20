import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/custom_appBar.dart';
import '../components/custom_drawer.dart';
import '../models/DTO/userDTO.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late Future<UserDTO> userInfo = Future.value();
  String c_pass = '';
  String n_pass = '';
  String cn_pass = '';
  bool check_pass = false;
  var userID;

  // text fields' controllers
  final TextEditingController _cpassController = TextEditingController();
  final TextEditingController _npassController = TextEditingController();
  final TextEditingController _cnpassController = TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance;

  var _isObscured;

  final CollectionReference _user =
      FirebaseFirestore.instance.collection('User');

  final users = FirebaseFirestore.instance;

  //Use to get username and password form firestore.
  Future<UserDTO> getUserAuth(matricNo) async {
    firestoreInstance
        .collection("User")
        .where("MatricNo", isEqualTo: matricNo)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                userID = element.id;
                print(userID);
              })
            });
    final snapshot = await users
        .collection('User')
        .where("MatricNo", isEqualTo: matricNo)
        .get();
    final userData = snapshot.docs.map((e) => UserDTO.fromSnapshot(e)).single;
    return userData;
  }

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              //Username
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Current Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2125,
                          color: Color(0xff000000),
                        ))
                  ])),
          Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextFormField(
                controller: _cpassController,
                cursorColor: primaryColor,
                obscureText: _isObscured,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: _isObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        }),
                    suffixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? const Color(0xff81163f)
                            : Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81163f))),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xff81163f)),
                    )),
                onChanged: (value) {
                  setState(() {
                    c_pass = value;
                  });
                },
              )),
          Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              //Username
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('New Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2125,
                          color: Color(0xff000000),
                        ))
                  ])),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextFormField(
                controller: _npassController,
                cursorColor: primaryColor,
                obscureText: _isObscured,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: _isObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        }),
                    suffixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? const Color(0xff81163f)
                            : Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81163f))),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xff81163f)),
                    )),
                onChanged: (value) {
                  setState(() {
                    n_pass = value;
                  });
                },
              )),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              //Username
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Confimred New Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2125,
                          color: Color(0xff000000),
                        ))
                  ])),
          Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextFormField(
                controller: _cnpassController,
                cursorColor: primaryColor,
                obscureText: _isObscured,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: _isObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        }),
                    suffixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? const Color(0xff81163f)
                            : Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81163f))),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xff81163f)),
                    )),
                onChanged: (value) {
                  setState(() {
                    cn_pass = value;
                  });
                },
              )),
          Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff81163f),
                  shadowColor: Colors.black,
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final matricNo = prefs.getString('matricNo');
                  setState(() {
                    userInfo = getUserAuth(matricNo);
                  });
                  UserDTO convertUserInfo = await userInfo;
                  checkEmptyField(c_pass, n_pass, cn_pass);
                  check_pass = validateCurrentPass(c_pass, convertUserInfo);
                  if (check_pass == true) {
                    if (n_pass == cn_pass) {
                      //update new password
                      await _user.doc(userID).update({"Password": n_pass});

                      // Clear the text fields
                      _cpassController.text = '';
                      _npassController.text = '';
                      _cnpassController.text = '';

                      // add a message to notify the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration:
                              const Duration(seconds: 1, milliseconds: 500),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 30, 16, 30),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(16, 255, 206, 218),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Center(
                                  child: Text(
                                "Password Changed Successfully...",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ))),
                        ),
                      );

                      //navigate back to previous page
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration:
                              const Duration(seconds: 1, milliseconds: 200),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 157, 27, 60),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Center(
                                  child: Text(
                                      "New Password and Confirmed New Password not Identical! Please check again"))),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1, milliseconds: 200),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        content: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 157, 27, 60),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Center(
                                child: Text(
                                    "Wrong Current Password! Please check again"))),
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ))
        ],
      )),
    );
  }

  //check empty field
  void checkEmptyField(c_pass, n_pass, cn_pass) {
    if (c_pass == '' || n_pass == '' || cn_pass == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1, milliseconds: 200),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 157, 27, 60),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Center(
                  child: Text(
                      "Incomplete Infomation! Please Fill All Information"))),
        ),
      );
    }
  }

  bool validateCurrentPass(String c_pass, UserDTO convertUserInfo) {
    if (c_pass == convertUserInfo.getPassword()) {
      return true;
    } else {
      return false;
    }
  }
}
