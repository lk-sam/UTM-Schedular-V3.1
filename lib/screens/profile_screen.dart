import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '../components/custom_appBar.dart';
import '../components/custom_drawer.dart';
import '../models/DTO/userDTO.dart';

class ProfileScreen extends StatefulWidget {
  final UserDTO user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(children: [
              Container(
                height: Get.height * 0.15,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(300)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    'https://th.bing.com/th/id/OIP.3ifK-ZYFdTTPIm1jiGIeZwAAAA?pid=ImgDet&rs=1',
                                    height: 120,
                                    width: 120,
                                  )))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 75.0),
                        child: Text("Name"),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                              initialValue: '  ' + widget.user.getFullName(),
                              readOnly: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  prefixIcon: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color:
                                            Color.fromARGB(255, 255, 216, 226),
                                      ),
                                      child: Icon(
                                        Icons.person_outline,
                                        color: primaryColor,
                                      ))))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 75.0),
                        child: Text("Matric No"),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                              initialValue: '  ' + widget.user.getMatricNo(),
                              readOnly: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  prefixIcon: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color:
                                            Color.fromARGB(255, 255, 216, 226),
                                      ),
                                      child: Icon(
                                        Icons.contact_emergency_outlined,
                                        color: primaryColor,
                                      ))))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 75.0),
                        child: Text("Role"),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                              readOnly: true,
                              initialValue: '  ' + widget.user.getRole(),
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  prefixIcon: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color:
                                            Color.fromARGB(255, 255, 216, 226),
                                      ),
                                      child: Icon(
                                        Icons.face_outlined,
                                        color: primaryColor,
                                      )))))
                    ]),
              )
            ])));
  }
}
