import 'package:flutter/material.dart';
import 'package:utmschedular/screens/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                          vertical: 50.0, horizontal: 20.0),
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
                                        padding:
                                            EdgeInsets.fromLTRB(10, 20, 10, 10),
                                        //Username
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text('Name',
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
                                            children: const [
                                              TextField(
                                                  decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ))
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
                                            children: const [
                                              TextField(
                                                  decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ))
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
                                            children: const [
                                              TextField(
                                                  decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff81163f))),
                                              ))
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
                                            children: const [
                                              TextField(
                                                  decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff81163f))),
                                              ))
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()));
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
