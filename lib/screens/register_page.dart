import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utmschedular/models/DTO/userDTO.dart';
import 'package:utmschedular/screens/login_page.dart';
import 'package:utmschedular/models/domain/user.dart';
import 'package:utmschedular/services/api_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:utmschedular/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Future<String> JsonMatric = Future.value();
  late Future<String> JsonName = Future.value();
  late Future<String> JsonRole = Future.value();
  String matricNo = ''; // Get matric no. from user
  String IC = ''; // Get IC from user
  String password = ''; // Get password from user
  String confirmedPassword = ''; // Get confirmed password from user

  var nameController = new TextEditingController();
  var matricController = new TextEditingController();
  var passwordController = new TextEditingController();
  var confirmedPasswordController = new TextEditingController();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('User');

  var _isObscured1;
  var _isObscured2;

  @override
  void initState() {
    super.initState();
    _isObscured1 = true;
    _isObscured2 = true;
  }

  //Fetch student name based on the provided matric number and ic number
  Future<String> getStudentName(String matricNo, String ic) async {
    String name = await ApiService.fetchName(matricNo, ic);
    return name;
  }

  // Fetch student matric no. based on the provided matric number and ic number
  Future<String> getStudentInfo(String matricNo, String ic) async {
    String matric = await ApiService.fetchMatricNo(matricNo, ic);
    return matric;
  }

  // Fetch student role based on the provided matric number and ic number
  Future<String> getStudentRole(String matricNo, String ic) async {
    String matric = await ApiService.fetchRole(matricNo, ic);
    return matric;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color.fromARGB(255, 214, 213, 213)),
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                //header
                width: double.infinity,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xff81163f),
                ),
              ),
              Container(
                  child: Container(
                      margin: new EdgeInsets.symmetric(
                          vertical: 60.0, horizontal: 20.0),
                      //Login Box
                      child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffffffff),
                                  ),
                                  child: Column(children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 20, 20, 0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                //image logo
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 7, 0, 0),
                                                width: 34,
                                                height: 35,
                                                child: Image.network(
                                                  'https://upload.wikimedia.org/wikipedia/commons/8/81/UTM-LOGO.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                  //Login Title
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 7, 0, 0.24),
                                                  child: const Text('Register',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.2125,
                                                        color:
                                                            Color(0xff000000),
                                                      )))
                                            ])),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        //Username
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text('Matric No',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.2125,
                                                    color: Color(0xff000000),
                                                  ))
                                            ])),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        //Username
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                controller: matricController,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    matricNo = value;
                                                  });
                                                },
                                              )
                                            ])),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        //Username
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text('IC No.',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.2125,
                                                    color: Color(0xff000000),
                                                  ))
                                            ])),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        //Username
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    IC = value;
                                                  });
                                                },
                                              )
                                            ])),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        //Username
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text('Password',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.2125,
                                                    color: Color(0xff000000),
                                                  ))
                                            ])),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        //Username
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextFormField(
                                                obscureText: _isObscured1,
                                                controller: passwordController,
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                      icon: _isObscured1
                                                          ? const Icon(
                                                              Icons.visibility)
                                                          : const Icon(Icons
                                                              .visibility_off),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscured1 =
                                                              !_isObscured1;
                                                        });
                                                      }),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff81163f))),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    password = value;
                                                  });
                                                },
                                              )
                                            ])),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        //Username
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text('Confirmed Password',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.2125,
                                                    color: Color(0xff000000),
                                                  ))
                                            ])),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        //Username
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextFormField(
                                                obscureText: _isObscured2,
                                                controller:
                                                    confirmedPasswordController,
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                      icon: _isObscured2
                                                          ? const Icon(
                                                              Icons.visibility)
                                                          : const Icon(Icons
                                                              .visibility_off),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscured2 =
                                                              !_isObscured2;
                                                        });
                                                      }),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff81163f))),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    confirmedPassword = value;
                                                  });
                                                },
                                              )
                                            ])),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 15, 20, 10),
                                        //Username
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [signUpOption()])),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 20),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff81163f),
                                            shadowColor: Colors.black,
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              JsonMatric =
                                                  getStudentInfo(matricNo, IC);
                                              JsonName =
                                                  getStudentName(matricNo, IC);
                                              JsonRole =
                                                  getStudentRole(matricNo, IC);
                                            });
                                            String StringJsonMatric =
                                                await JsonMatric;
                                            String StringJsonName =
                                                await JsonName;
                                            String StringJsonRole =
                                                await JsonRole;
                                            print(StringJsonName);

                                            // Checking all TextFields.
                                            if (matricNo == '' ||
                                                IC == '' ||
                                                password == '' ||
                                                confirmedPassword == '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(
                                                      seconds: 1,
                                                      milliseconds: 200),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                  content: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 157, 27, 60),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10))),
                                                      child: const Center(
                                                          child: Text(
                                                              "Incomplete Infomation! Please Fill All Data"))),
                                                ),
                                              );
                                            } else {
                                              if ((matricNo.toString() ==
                                                  await JsonMatric)) {
                                                if (password ==
                                                    confirmedPassword) {
                                                  final String? matric =
                                                      matricController.text;
                                                  final String? password =
                                                      passwordController.text;
                                                  await users.add({
                                                    "Fullname": StringJsonName,
                                                    "MatricNo": matric,
                                                    "Password": password,
                                                    "Role": StringJsonRole,
                                                    "IC": IC,
                                                  });

                                                  //clear the test fields
                                                  nameController.text = '';
                                                  matricController.text = '';
                                                  passwordController.text = '';

                                                  // add a message to notify the user
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      duration: const Duration(
                                                          seconds: 1,
                                                          milliseconds: 500),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                      content: Container(
                                                          padding: const EdgeInsets
                                                                  .fromLTRB(
                                                              16, 30, 16, 30),
                                                          decoration: const BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      16,
                                                                      255,
                                                                      206,
                                                                      218),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          child: const Center(
                                                              child: Text(
                                                            "Please login using the correct registered information...",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ))),
                                                    ),
                                                  );

                                                  //navigate to login page if register successfully
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoginPage()));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      duration: const Duration(
                                                          seconds: 1,
                                                          milliseconds: 200),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                      content: Container(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  16),
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      157,
                                                                      27,
                                                                      60),
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          10))),
                                                          child: const Center(
                                                              child: Text(
                                                                  "Password and confirmed password not identical! Please check again"))),
                                                    ),
                                                  );
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Invalid Matric No. or IC! Please try again."),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: const Text('Register'),
                                        ))
                                  ])))))),
            ],
          ))),
    );
  }

  Row signUpOption() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      const Text("Have an account? ", style: TextStyle(color: Colors.black)),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Text("Login",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]);
  }
}
