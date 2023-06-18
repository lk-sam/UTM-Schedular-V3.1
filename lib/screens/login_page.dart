import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:utmschedular/screens/home_screen.dart';
import 'package:utmschedular/screens/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utmschedular/constants/routes.dart';

import '../models/DTO/userDTO.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<UserDTO> userInfo = Future.value();
  String matricNo = ''; // Get matric no. from user
  String password = ''; // Get password from user

  final users = FirebaseFirestore.instance;

  //Use to get username and password form firestore.
  Future<UserDTO> getUserAuth(matricNo) async {
    final snapshot = await users
        .collection('User')
        .where("matric no", isEqualTo: matricNo)
        .get();
    final userData = snapshot.docs.map((e) => UserDTO.fromSnapshot(e)).single;
    return userData;
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
                          vertical: 100.0, horizontal: 20.0),
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
                                                        0, 7, 7, 0),
                                                width: 35,
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
                                                  child: const Text('Login',
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
                                        padding:
                                            EdgeInsets.fromLTRB(10, 20, 10, 10),
                                        //Username
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text('Matric No.',
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
                                            EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        //Username
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
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
                                              userInfo = getUserAuth(matricNo);
                                            });
                                            UserDTO convertUserInfo =
                                                await userInfo;
                                            print(
                                                convertUserInfo.getPassword());
                                            if (matricNo == '' ||
                                                password == '') {
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
                                                              "Incomplete Infomation! Please Fill All Information"))),
                                                ),
                                              );
                                            } else {
                                              if ((matricNo ==
                                                      convertUserInfo
                                                          .getMatricNo()) &&
                                                  (password ==
                                                      convertUserInfo
                                                          .getPassword())) {
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
                                                        padding: const EdgeInsets
                                                                .fromLTRB(
                                                            16, 30, 16, 30),
                                                        decoration: const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    16,
                                                                    255,
                                                                    206,
                                                                    218),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: const Center(
                                                            child: Text(
                                                          "Successful Login...",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                          ),
                                                        ))),
                                                  ),
                                                );
                                                SharedPreferences prefs = await _prefs;  // await the Future<SharedPreferences>
                                                prefs.setString('matricNo', matricNo); 

                                                Navigator.pushNamed(
                                                    context,
                                                    taskRoute,
                                                   );
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
                                                                "Wrong Password or Matric No.! Please check again"))),
                                                  ),
                                                );
                                              }
                                            }
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const HomePage()));
                                          },
                                          child: const Text('Log in'),
                                        ))
                                  ])))))),
            ],
          ))),
    );
  }

  Row signUpOption() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      const Text("Don't have account? ", style: TextStyle(color: Colors.black)),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterPage()));
        },
        child: const Text("Register",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]);
  }
}
