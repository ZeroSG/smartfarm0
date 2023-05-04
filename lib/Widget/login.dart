import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../drawer.dart';
import 'Summry.dart';
import 'shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // String Username = 'Orange';
  // String Password = 'SmartFarm@Orange2022';
  double? screenW, screenH;
  String? Token;
  bool loading = true;

  // API Token
  Future<void> getToken(String Username, String Password) async {
    var url = Uri.https("smartfarmpro.com", "/v1/api/security/token");
    var res = await http.post(url, headers: <String, String>{
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "Grant_Type": 'password',
      "Username": 'Orange',
      "Password": 'SmartFarm@Orange2022'
    });
    if (res.statusCode == 200) {
      print("token => ${res.body}");
      var token = jsonDecode(res.body);
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/security/login");
      var ressum;

      ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${token['access_token']}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(
              <String, dynamic>{"user": Username, "password": Password}));

      if (ressum.statusCode == 200) {
        setState(() async {
          Token = token['access_token'];
          Usersharedpreferences _p = Usersharedpreferences();
          // await Usersharedpreferences.init();
          await _p.setUserEmail(Username, Password);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Drawer1(
                  Token: Token,
                  User: Username,
                  Password: Password,
                ),
              ),
              (route) => false);
          loading = false;
        });
      } else {
        var Message;
        if (ressum.statusCode == 500) {
          Message = jsonDecode(ressum.body)['Message'];
        } else {
          Message = jsonDecode(ressum.body)['message'];
        }
        showDialog(
            barrierColor: Color.fromARGB(255, 148, 174, 149).withOpacity(0.3),
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      height: screenH! * 0.4,
                      width: screenW! * 0.5,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 15, left: 10),
                                  height: screenH! * 0.06,
                                  child: Text(
                                    "ข้อมูล",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'THSarabun',
                                        color: Color(0xff44bca3)),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                //  color: Colors.white,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'X',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            height: screenH! * 0.2,
                            decoration: BoxDecoration(
                              //  color: Colors.amberAccent
                              image: DecorationImage(
                                  image: AssetImage("images/B1.jpg"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Center(
                            child: Text('$Message',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 16)),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);

                                setState(() {
                                  // result = false;
                                  // email ='';
                                  // password1 ='';
                                });
                              },
                              child: Text('OK',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(fontFamily: 'Montserrat')),
                            ),
                          ),
                        ],
                      ),
                    ));
              });
            });
        throw Exception('Failed to download');
      }
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                height: screenH! * 1,
                width: screenW! * 1,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.33),
                    radius: 1.0,
                    colors: <Color>[Colors.white, Colors.green],
                  ),
                ),
              ),
              Container(
                height: screenH! * 1,
                width: screenW! * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/B.jpg"), fit: BoxFit.fill),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          height: screenH! * 0.4,
                          width: screenW! * 1,
                          decoration: BoxDecoration(
                            //  color: Colors.amberAccent
                            image: DecorationImage(
                                image: AssetImage("images/B2.png"),
                                fit: BoxFit.fill),
                          ),
                        )
                      ]),
                    ),
                    Center(
                      // child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          buildLogin(),
                          buildSignUp(),
                          SizedBox(
                            height: screenH! * 0.2,
                          ),

                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Text(
                          //     'Forgor Password ?', textScaleFactor: 1.0,
                          //     style: TextStyle(
                          //         fontFamily: 'Montserrat',
                          //         fontSize: 14,
                          //         color: Color.fromARGB(255, 255, 255, 255)),
                          //   ),
                          // ),
                          SizedBox(
                            height: screenH! * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: screenW! * 0.6,
    );
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Summary(Token: Token),
        ));
  }

  Home() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenW! * 0.75,
      height: screenH! * 0.07,
      child: ElevatedButton(
        onPressed: () {
          try {
            showDialog(
                barrierColor:
                    Color.fromARGB(255, 148, 174, 149).withOpacity(0.3),
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: 270,
                          width: screenW! * 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 15, left: 10),
                                      // height: 20,
                                      child: Text(
                                        "Log in",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            color: Color(0xff44bca3)),
                                      )),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    //  color: Colors.white,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'X',
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  newMethodEmail(),
                                  newMethodPassword(setState),
                                  newMethodLogin(),
                                ],
                              )
                            ],
                          ),
                        ));
                  });
                });
          } catch (e) {}
        },
        child: Text(
          'Log In',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff35b499)),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  late bool? statusRedEye = true;
  Container newMethodPassword(StateSetter setState) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffcfcfcf), width: 1),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      height: 50,
      margin: EdgeInsets.only(top: 16),
      width: screenW! * 0.7,
      child: TextField(
        controller: _password1Controller,
        obscureText: statusRedEye!, //ไม่ให้เห็นข้อความ
        obscuringCharacter: '●',
        // enableIMEPersonalizedLearning          :false,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              //ทำปุ่ม RedEye
              icon: statusRedEye!
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye!;
                });
                print('$statusRedEye');
              }),
          filled: true,
          contentPadding: EdgeInsets.only(top: 10),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          hintText: 'รหัสผ่าน',
          hintStyle: TextStyle(
              fontFamily: 'THSarabun',
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 23),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xffcfcfcf)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xffcfcfcf)),
          ),
        ),
      ),
    );
  }

  Container newMethodEmail() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffcfcfcf), width: 1),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      height: 50,
      margin: EdgeInsets.only(top: 16),
      width: screenW! * 0.7,
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16),
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.only(top: 10),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.person_outline_rounded,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          hintText: 'อีเมล',
          hintStyle: TextStyle(
              fontFamily: 'THSarabun',
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 23),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xffcfcfcf)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xffcfcfcf)),
          ),
        ),
      ),
    );
  }

  Container newMethodLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenW! * 0.7,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          getToken(_emailController.text, _password1Controller.text);
          // getToken(_emailController.text,_password1Controller.text);
        },
        child: Text(
          'Log in',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        style: ElevatedButton.styleFrom(
            primary: Color(0xff35b499),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }

  Container buildSignUp() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenW! * 0.75,
      height: screenH! * 0.07,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 3),
        borderRadius: BorderRadius.circular(30),
        // color: Colors.white,r
      ),
      child: ElevatedButton(
        onPressed: () async {
          String smartfarmpro = 'https://smartfarmpro.com/Regis_Farm.aspx';
          if (await canLaunch(smartfarmpro)) {
            await launch(
              smartfarmpro,
              forceSafariVC: true,
              forceWebView: true,
              enableJavaScript: true,
              universalLinksOnly: true,
            );
          } else {
            print('object');
          }
        },
        //  Navigator.pushNamed(context, '/showMapPresent'),
        child: Text(
          'Sign Up',
          textScaleFactor: 1.0,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Color(0xff35b499),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
