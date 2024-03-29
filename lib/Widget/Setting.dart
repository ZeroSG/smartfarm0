//หน้า Setting
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Setting/Farm.dart';
import 'Setting/Feed.dart';
import 'Setting/House.dart';
import 'Setting/Planning.dart';
import 'Setting/Production.dart';
import 'Setting/standard.dart';

import 'package:http/http.dart' as http;

class Setting extends StatefulWidget {
  int? cropnum2;
  int? cropnum1;
  int? cropnum;
  String? Token; // Token
  String? farmname; // farm name
  GlobalKey? navigatorKey;
  int? farmnum; // farm id
  List<dynamic>? default_species; //ข้อมูล default_species
  List<dynamic>? house; //ข้อมูล house
  List<dynamic>? default_planning; //ข้อมูล default_planning
  List<dynamic>? default_formula; //ข้อมูล default_formula
  List<dynamic>? default_ship; //ข้อมูล default_ship
  int? id; //id user
  Setting(
      {Key? key,
      this.id,
      this.Token,
      this.navigatorKey,
      this.farmnum,
      this.default_species,
      this.default_formula,
      this.default_planning,
      this.house,
      this.default_ship,
      this.farmname,
      this.cropnum,
      this.cropnum1,
      this.cropnum2})
      : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late List<dynamic>? default_species = widget.default_species;
  late List<dynamic>? default_ship = widget.default_ship;
  late List<dynamic>? house = widget.house;
  late List<dynamic>? default_planning = widget.default_planning;
  late List<dynamic>? default_formula = widget.default_formula;
  late double screenW, screenH;

  bool loading1 = true;
  List<dynamic> nowresult1_1 = [];

  //API setting_farm
  Future<void> getjaon1_setting_farm() async {
    try {
      loading1 = true;
      var urlsum =
          Uri.https("smartfarmpro.com", "/v1/api/setting/setting-farm");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
          }));
      if (ressum.statusCode == 200) {
        var result1_1 = json.decode(ressum.body)['result']['view1'];

        setState(() {
          nowresult1_1 = result1_1;

          loading1 = false;
        });
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getjaon1_setting_farm();
  }

  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Column(children: [
                              Container(
                                width: screenW * 0.9,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      Color.fromARGB(255, 148, 184, 233),
                                      Color(0xff84b6fd),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${widget.farmname}',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'THSarabun',
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                ),
                              ),
                              Container(
                                height: 90,
                                width: screenW * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: loading1
                                      ? Text('')
                                      : nowresult1_1[0]['c_address'] == null
                                          ? Text('')
                                          : Text(
                                              '${nowresult1_1[0]['c_address']}',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily: 'THSarabun',
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              // ปุ่มกดหน้าFarm
                              newMethod('Farm', 'Farm Name', (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Farm(
                                          cropnum1: widget.cropnum1,
                                          cropnum: widget.cropnum,
                                          cropnum2: widget.cropnum2,
                                          farmnum: widget.farmnum,
                                          Token: widget.Token,
                                          default_species: default_species,
                                          default_ship: default_ship),
                                    ));
                              })),
                              // ปุ่มกดหน้า House
                              newMethod('House', 'House', (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => House(
                                        farmnum: widget.farmnum,
                                        Token: widget.Token,
                                        house: house),
                                  ),
                                );
                              })),
                              // ปุ่มกดหน้า Feed
                              newMethod('Feed', 'Feeds In Farm', (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Feed(
                                      farmnum: widget.farmnum,
                                      Token: widget.Token,
                                    ),
                                  ),
                                );
                              })),
                              // ปุ่มกดหน้า standard
                              newMethod('standard', 'standard Formula', (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => standard(
                                        farmnum: widget.farmnum,
                                        Token: widget.Token,
                                        default_formula: default_formula),
                                  ),
                                );
                              })),
                              // ปุ่มกดหน้า Planning
                              newMethod('Planning', 'Farming Plan', (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Planning(
                                        farmnum: widget.farmnum,
                                        Token: widget.Token,
                                        default_planning: default_planning),
                                  ),
                                );
                              })),
                              // ปุ่มกดหน้า Production
                              newMethod('Production', 'Production Set', (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Production(
                                        farmnum: widget.farmnum,
                                        Token: widget.Token,
                                        default_formula: default_formula,
                                        default_planning: default_planning),
                                  ),
                                );
                              })),

                              buildDeleteUser(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Container buildDeleteUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenW * 0.75,
      height: screenH * 0.07,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 3),
        borderRadius: BorderRadius.circular(30),
        // color: Colors.white,r
      ),
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => SimpleDialog(
              title: ListTile(
                // leading: Image.asset('images/maps.png',height: 600,),
                title: Text('ลบบัญชี',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'THSarabun',
                    )),
                subtitle: Text('คุณต้องการลบบัญชีนี้ใช่หรือไม่ ?',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontFamily: 'THSarabun',
                      color: Colors.black,
                    )),
              ),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('ยกเลิก',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontFamily: 'THSarabun',
                              color: Colors.black,
                            ))),
                    TextButton(
                        onPressed: () async {
                          print('${widget.id}');
                          String smartfarmpro =
                              'https://smartfarmpro.com/DeleteUser.aspx?ID=${widget.id}';
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
                        child: Text('ตกลง',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontFamily: 'THSarabun',
                              color: Colors.black,
                            ))),
                  ],
                )
              ],
            ),
          );
        },
        //  Navigator.pushNamed(context, '/showMapPresent'),
        child: Text(
          'Delete User',
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

  // Method ปุ่มกด
  Container newMethod(String name, data, Function()? onTap1) {
    return Container(
      child: GestureDetector(
          onTap: onTap1,
          child: Container(
            width: screenW * 1,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffcfcfcf), width: 1),
              // borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text(
                    name,
                    textScaleFactor: 1.0,
                    style: new TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 15,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          )),
    );
  }
}
