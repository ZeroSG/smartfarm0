//หน้าเมนูหลัก

import 'dart:async';
import 'dart:convert';

import 'dart:math';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'Widget/API_E_B/notifications.dart';
import 'Widget/Demand.dart';
import 'Widget/House.dart';
import 'Widget/Main.dart';
import 'Widget/Order.dart';
import 'Widget/Setting.dart';
import 'Widget/Summry.dart';
import 'Widget/login.dart';
import 'Widget/shared_preferences/shared_preferences.dart';

const _kPages = <String, IconData>{
  'Main': MdiIcons.lightbulbOn,
  'Summary': Icons.linear_scale_sharp,
  'House': Icons.house_siding,
  'Demand': Icons.car_repair,
  'Order': Icons.add_shopping_cart_sharp,
  'Setting': Icons.settings,
};

class Drawer1 extends StatefulWidget {
  String? Token;
  int? num1;
  String? User;
  String? Password;
  int? HOUSE1;
  String? HOUSE2;
  int? farmnum;
  
  int? numIndex;
  int? nummune;
  int? cropnum2;
  int? cropnum1;
  int? cropnum;
  List<dynamic>? Feed;
  Drawer1(
      {Key? key,
      this.Feed,
      this.cropnum2,
      this.Token,
      this.num1,
      this.Password,
      this.User,
      this.HOUSE1,
      this.HOUSE2,
      this.farmnum,
      this.numIndex,
      this.cropnum1,
      this.cropnum,
      this.nummune})
      : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawer1> {
  TabStyle _tabStyle = TabStyle.reactCircle;
  late String name = 'Main';
  late double screenW, screenH;
  late int? num = widget.num1;
  bool loading = true;
  bool loading1 = true;
  bool loading0 = true;
  // หน้า Order
  List<dynamic>? default_unit;
  List<dynamic>? cmiid;

  // หน้า Setting
  List<dynamic>? default_species;
  List<dynamic>? house;
  List<dynamic>? default_planning;
  List<dynamic>? default_formula;
  List<dynamic>? default_ship;

  // หน้า Summry
  List<dynamic>? View_by;
  List<dynamic>? sex;
  List<dynamic>? type;
  // หน้า House // Inrake&Order
  List<dynamic>? samount2;
  List<dynamic>? samount1;
  List<dynamic>? View;
  List<dynamic>? day;
  // หน้า House
  List<dynamic>? HOUSE;
  List<dynamic>? farm, farm0, crop;
  late int? cropnum1 = widget.cropnum1, cropnum = widget.cropnum;
  String? farmname, cropname;
  String? email;
  int? id;
  late int? farmnum = widget.farmnum, cropnum2;
  // cropnum2 = widget.cropnum2;
  Usersharedpreferences _p = Usersharedpreferences();
  bool Nocropbool = true;

  List<dynamic>? NocropnumList = ['Not StartCrop'];
  String? Nocropnum = 'Not StartCrop';

  late String? user = widget.User;
  late String? password = widget.Password;
  late String? token0;
//      late  String? email1 = Usersharedpreferences.getUserEmail();
//  late String? password1 = Usersharedpreferences1.getUserPassword();

  late TextEditingController from = TextEditingController();

  // API login
  Future<void> getjaon_login() async {
    try {
      loading = true;
      loading1 = true;
      token0 = '${widget.Token}';
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/security/login");
      var ressum;

      ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $token0",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(
              <String, dynamic>{"user": user, "password": password}));

      if (ressum.statusCode == 200) {
        var result3 = json.decode(ressum.body)['result']['farm'];
        var id1 = json.decode(ressum.body)['result']['user'];
        var species = json.decode(ressum.body)['result']['default_species'];
        var ship = json.decode(ressum.body)['result']['default_ship'];
        var unit = json.decode(ressum.body)['result']['default_unit'];
        setState(() {
          if (cropnum1 == null) {
            cropnum1 = 0;
          }
          if (cropnum == null) {
            cropnum = 0;
          }

          email = id1['email'];
          id = id1['id'];
          if (farmnum == null) {
            farmnum = result3[0]['id'];
          }
          if (widget.cropnum2 == null) {
            if (result3[cropnum1]['crop'] == null) {
              Nocropbool = false;
              cropnum2 = null;
            } else {
              Nocropbool = true;

              cropname = result3[cropnum1]['crop'][cropnum]['name'];
              crop = result3[cropnum1]['crop'];
              cropnum2 = result3[0]['crop'][0]['id'];
            }
          } else {
            cropnum2 = widget.cropnum2;
            cropname = result3[cropnum1]['crop'][cropnum]['name'];
            crop = result3[cropnum1]['crop'];
            Nocropbool = true;
          }

          //print('cropnum1 $cropnum1');
          farmname = result3[cropnum1]['name'];
          farm = result3;
          farm0 = result3;

          // farmname = A[cropnum1!]['name'];

          // farm = A;
          // cropname = users[cropnum1!][cropnum]['name'];
          // crop = users[cropnum1!];
          // หน้า Summry
          sex = result3[cropnum1]['default_formula'];
          type = result3[cropnum1]['summary_view1'];
          View_by = result3[cropnum1]['summary_view2'];
          // หน้า House
          HOUSE = result3[cropnum1]['house'];

          // หน้า House // Inrake&Order
          samount1 = result3[cropnum1]['house_view1'];
          View = result3[cropnum1]['house_view2'];
          day = result3[cropnum1]['house_view0'];
          // View = result3[0]['house_view2'];

          // หน้า Setting
          default_species = species;
          house = result3[cropnum1]['house'];
          default_planning = result3[cropnum1]['default_planning'];
          default_formula = result3[cropnum1]['default_formula'];

          default_ship = ship;

          // หน้า Order
          cmiid = result3[cropnum1]['cmiid'];
          default_ship = ship;
          default_unit = unit;

          loading = false;
          loading1 = false;
        });
        if (default_formula != null) {
          late List<String> formula = [];
          for (int i = 0; i < default_formula!.length; i++) {
            formula += [default_formula![i]["name"]];
          }
          await _p.setListdefault_formula(formula);
        } else {
          late List<String> formula = [''];
          await _p.setListdefault_formula(formula);
        }
        if (default_planning != null) {
          late List<String> planning = [];
          for (int i = 0; i < default_planning!.length; i++) {
            planning += [default_planning![i]["name"]];
          }
          await _p.setListdefault_planning(planning);
        } else {
          late List<String> planning = [''];
          await _p.setListdefault_planning(planning);
        }
        late List<String> NameCrop = [];
        if (cmiid == null) {
          NameCrop = [''];
          await _p.setListNameCrop(NameCrop);
        } else {
          for (int i = 0; i < cmiid!.length; i++) {
            NameCrop += [cmiid![i]];
            await _p.setListNameCrop(NameCrop);
          }
        }

        // //print('ressum ========>  ${ressum.body}');
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
            (route) => false);
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

//  int starter = 0;

//   void checkForNewSharedLists(){

//      showNot('1','$starter');
//     // do request here
//     setState((){
//       starter = starter+1;
//       // change state according to result of request
//     });

//   }
//   Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getjaon_login();
  }

  GlobalKey? navigatorKeys = GlobalKey();
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    if (num == null) {
      setState(() {
        num = 0;
      });
    }

    return DefaultTabController(
      length: 6,
      initialIndex: num!,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              name,
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () {
                        if (loading == false) {
                          newindex1(context);
                          getjaon_login();
                        }
                      },
                      child: Icon(MdiIcons.accountSettings,
                          size: 40, color: Color(0xffd4d4d4)),
                    ),
                  )),
            ],
            backgroundColor: Color(0xff44bca3)),
        body: loading
            ? Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator()))
            : Column(
                children: [
                  PhatthanaNikhomBroilerFarm(context),
                  line(),
                  // _buildStyleSelector(),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Main1(
                          cropnum: cropnum, // crop id
                          cropnum1: cropnum1, // crop [index]
                          Token: widget.Token, // Token
                          User: user, // Email
                          Password: password, // Password
                          HOUSE: HOUSE, // data HOUSE
                          farmnum: farmnum, // farm id
                          cropnum2: cropnum2, //  farm [index]
                        ),
                        Summary(
                          Token: widget.Token, // Token
                          sex: sex, //data formula
                          type: type, //data type
                          View_by: View_by, //data summary_view2
                          farmnum: farmnum, // farm id
                          cropnum2: cropnum2, //  farm [index]
                        ),
                        House(
                           farmname:farmname, //ชื่อ farm
                            User: user, // Email
                            Password: password, // Password
                            Feed: widget.Feed, //  Feed
                            cropnum: cropnum, // crop id
                            cropnum1: cropnum1, // crop [index]
                            Token: widget.Token, // Token
                            HOUSE: HOUSE, // data HOUSE
                            HOUSE1: widget.HOUSE1, // data HOUSE id
                            HOUSE2: widget.HOUSE2, // data HOUSE
                            farmnum: farmnum, // farm id
                            cropnum2: cropnum2, //  farm [index]
                            samount1: samount1, // data house_view1
                            View: View, // data house_view2
                            day: day, // data house_view0
                            numIndex: widget.numIndex // numder หน้า house
                            ),
                        Demand(
                            Token: widget.Token, // Token
                            farmnum: farmnum // farm id
                            ),
                        Order(
                            farmnum: farmnum, // farm id
                            Token: widget.Token, // Token
                            default_unit: default_unit, //data default_unit
                            default_ship: default_ship, //data default_ship
                            cmiid: cmiid, //data cmiid
                            id: id),
                        Setting(
                            id: id,
                            cropnum1: widget.cropnum1,
                            cropnum: widget.cropnum,
                            cropnum2: widget.cropnum2,
                            farmname: farmname, // farm name
                            Token: widget.Token, // Token
                            navigatorKey: navigatorKeys,
                            farmnum: farmnum, // farm id
                            default_species:
                                default_species, //data default_species
                            house: house, // data HOUSE
                            default_planning:
                                default_planning, // data default_planning
                            default_formula:
                                default_formula, // data default_formula
                            default_ship: default_ship // data default_ship
                            ),
                      ],
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: ConvexAppBar.badge(
          const <int, dynamic>{},
          style: TabStyle.reactCircle,
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(icon: entry.value, title: entry.key),
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          activeColor: Color.fromARGB(255, 253, 253, 253),
          backgroundColor: Color(0xff44bca3),
          onTap: (int i) async {
            setState(() {
              num = i;
             
            });
            print('num ==> $num');
           if(num != 2){
                 DateTime? dateTime1_ = DateTime.now();
                  Usersharedpreferences _p = Usersharedpreferences();
                 await _p.setUserT(dateTime1_.toString());
                 print('dateTime1_ ==> $dateTime1_');
              }
            //print('click index=$i');
            if (i == 0) {
              setState(() {
                name = 'Main';
              });
            }
            if (i == 1) {
              setState(() {
                name = 'Summry';
              });
            }
            if (i == 2) {
              setState(() {
                name = 'House';
              });
            }
            if (i == 3) {
              setState(() {
                name = 'Demand';
              });
            }
            if (i == 4) {
              setState(() {
                name = 'Order';
              });
            }
            if (i == 5) {
              setState(() {
                name = 'Setting';
              });
            }
          },
        ),
      ),
    );
  }

  Container line() {
    return Container(
        width: screenW * 1, height: screenH * 0.001, color: Color(0xff44bca3));
  }

  Container PhatthanaNikhomBroilerFarm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$farmname',
            textScaleFactor: 1.0,
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'THSarabun',
                fontWeight: FontWeight.bold,
                color: Color(0xff44bca3)),
          ),
          // Container(
          //   width: 70,
          //   height: 32,
          //   child: TextButton(
          //     onPressed: () {
          //       newday(context);
          //     },
          //     child: Text(
          //       '$day1',
          //       style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.bold,
          //           fontFamily: 'THSarabun',
          //           color: Colors.black),
          //     ),
          //   ),
          // ),
          GestureDetector(
              onTap: () {
                if (loading == false) {
                  newindex2(context);
                }
              },
              child: new Icon(
                MdiIcons.dotsHorizontal,
                size: 30,
              )),

          // Text(
          //   '***',
          //   style: TextStyle(fontSize: 17),
          // )
        ],
      ),
    );
  }

  Future<dynamic> search(BuildContext context) {
    return showDialog(
        barrierColor: Color.fromARGB(255, 148, 174, 149).withOpacity(0.3),
        // barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              // child:  SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 15, left: 10),
                              // height: 40,
                              child: Text(
                                "Choose search From",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 25,
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
                          width: screenW * 1,
                          height: screenH * 0.001,
                          color: Color.fromARGB(255, 220, 220, 220)),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 10),
                        // height: 40,
                        width: screenW * 0.8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color(0xfff1f1f1),
                              border: Border.all(
                                  color: Color(0xffe0eaeb), width: 3),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.57),
                                    blurRadius: 5)
                              ]),
                          child: TextField(
                            onTap: () {
                              from.text = '';
                            },
                            onChanged: ((value) {
                              farm0 = farm;

                              final sugges = farm0!.where((element) {
                                final farmtext = element['name']!.toLowerCase();
                                final index = value.toLowerCase();

                                return farmtext!.contains(index);
                              }).toList();

                              setState(() {
                                farm0 = sugges;
                              });
                            }),
                            controller: from,
                            keyboardType: TextInputType.emailAddress,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xffd4d4d4),
                              ),
                              // filled: true,
                              contentPadding:
                                  EdgeInsets.only(top: 10, left: 10),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Color(0xffcfcfcf)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Color(0xffcfcfcf)),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ]),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: farm0!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                farm0![index]['name'],
                                textScaleFactor: 1.0,
                              ),
                              onTap: () {
                                farmname = farm0![index]['name'];
                                //print(farm!.length);

                                for (int i = 0; i < farm!.length; i++) {
                                  if (farm![i]['name'] ==
                                      farm0![index]['name']) {
                                    setState(() {
                                      cropnum1 = i;

                                      farmnum = farm![i]['id'];

                                      if (farm![i]['crop'] == null) {
                                        cropnum2 = null;
                                      } else {
                                        cropnum2 = farm![i]['crop'][0]['id'];
                                      }

                                      cropnum1 = i;
                                      cropnum = 0;
                                      // //print(farmnum);
                                      // //print(cropnum2);
                                      farmname = farm![i]['name'];
                                      if (farm![i]['crop'] == null) {
                                        cropname = null;
                                      } else {
                                        cropname = farm![i]['crop'][0]['name'];
                                      }

                                      crop = farm![i]['crop'];

                                      Navigator.pop(context);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Drawer1(
                                                num1: num,
                                                Token: widget.Token,
                                                User: user,
                                                Password: password,
                                                cropnum1: i,
                                                cropnum2: cropnum2,
                                                farmnum: farmnum,
                                                cropnum: cropnum),
                                          ),
                                          (route) => false);
                                    });
                                  }

                                  //  Navigator.pop(context);
                                  // if(farm![i]['name'] == farm1){
                                  //   setState(() {
                                  //     cropnum1 = i;
                                  //     farmnum = farm![i]['id'];
                                  //     //print(farmnum);
                                  //      Navigator.pop(context);
                                  //   });

                                  // }
                                }
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
              // )
            );
          });
        });
  }

  void searchfarmname(String farmnameid) {
    final sugges = farm0!.where((element) {
      final farmtext = element['name']!.toLowerCase();
      final index = farmnameid.toLowerCase();

      return farmtext!.contains(index);
    }).toList();

    setState(() {
      farm0 = sugges;
    });
  }

  Future<dynamic> newindex1(BuildContext context) {
    return showDialog(
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
                  height: 250,
                  width: screenW * 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 15, left: 10),
                              height: screenH * 0.06,
                              child: Text(
                                "Choose Farm",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 25,
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
                          width: screenW * 1,
                          height: screenH * 0.001,
                          color: Color.fromARGB(255, 220, 220, 220)),
                      GestureDetector(
                        onTap: () {
                          search(context);
                        },
                        child: Center(
                            child: Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 40,
                          width: screenW * 0.75,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Color(0xfff1f1f1),
                                border: Border.all(
                                    color: Color(0xffe0eaeb), width: 3),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.57),
                                      blurRadius: 5)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '$farmname',
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          color:
                                              Color.fromARGB(255, 25, 25, 25),
                                        ),
                                      ),
                                      Icon(Icons.search),
                                    ],
                                  )),
                            ),
                          ),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: screenW * 0.49,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: screenW * 0.40,
                                    child: Text(
                                      email!,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Montserrat',
                                        overflow: TextOverflow.ellipsis,
                                        color: Color.fromARGB(255, 68, 188, 90),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '|',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                color: Color(0xff44bca3),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  Usersharedpreferences _p =
                                      Usersharedpreferences();
                                  // await Usersharedpreferences.init();
                                  await _p.setUserEmail('', '');
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                      (route) => false);
                                },
                                child: new Text(
                                  'Logout',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 0, 0),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                          child: Text(
                        '${dateTime!.day}/${dateTime!.month}/${dateTime!.year} ${dateTime!.hour}:${dateTime!.minute}:${dateTime!.second}',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          color: Color(0xff44bca3),
                        ),
                      )),
                    ],
                  ),
                ));
          });
        });
  }

  Future<dynamic> newindex2(BuildContext context) {
    return showDialog(
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
                  height: 200,
                  width: screenW * 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 15, left: 10),
                              height: 40,
                              child: Text(
                                "Choose Crop",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 25,
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
                          width: screenW * 1,
                          height: screenH * 0.001,
                          color: Color.fromARGB(255, 220, 220, 220)),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 40,
                        width: screenW * 0.75,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color(0xfff1f1f1),
                              border: Border.all(
                                  color: Color(0xffe0eaeb), width: 3),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.57),
                                    blurRadius: 5)
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonHideUnderline(
                              child: Nocropbool
                                  ? DropdownButton<String>(
                                      value: cropname,
                                      items: crop!
                                          .map((crop) =>
                                              DropdownMenuItem<String>(
                                                  value: crop['name'],
                                                  child: Container(
                                                    width: screenW * 0.64,
                                                    child: Text(
                                                      crop['name'],
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Color.fromARGB(
                                                            255, 25, 25, 25),
                                                      ),
                                                    ),
                                                  )))
                                          .toList(),
                                      onChanged: (crop1) {
                                        for (int i = 0; i < crop!.length; i++) {
                                          // cropname = crop1;
                                          if (crop![i]['name'] == crop1) {
                                            setState(() {
                                              cropnum2 = crop![i]['id'];
                                              cropnum = i;
                                              // //print(cropnum2);
                                              getjaon_login();
                                              Navigator.pop(context);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Drawer1(
                                                            num1: num,
                                                            Token: widget.Token,
                                                            User: user,
                                                            Password: password,
                                                            cropnum1: cropnum1,
                                                            cropnum2: cropnum2,
                                                            farmnum: farmnum,
                                                            cropnum: i),
                                                  ),
                                                  (route) => false);
                                              //      Navigator.pushReplacement(
                                              // context,
                                              // MaterialPageRoute(
                                              //   builder: (context) => Drawer1(Token: widget.Token,User: user,Password: password,cropnum1:cropnum1,cropnum2:cropnum2,farmnum:farmnum,cropnum:i),
                                              // ));
                                            });
                                          }
                                        }
                                      })
                                  : DropdownButton<String>(
                                      value: Nocropnum,
                                      items: NocropnumList!
                                          .map((crop) =>
                                              DropdownMenuItem<String>(
                                                  value: crop,
                                                  child: Text(
                                                    crop,
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 25, 25, 25),
                                                    ),
                                                  )))
                                          .toList(),
                                      onChanged: (crop1) {}),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ));
          });
        });
  }

  DateTime? dateTime = DateTime.now();

  Widget _buildStyleSelector() {
    final dropdown = DropdownButton<TabStyle>(
      value: _tabStyle,
      onChanged: (newStyle) {
        if (newStyle != null) setState(() => _tabStyle = newStyle);
        // //print(TabStyle.values);
      },
      items: [
        for (final style in TabStyle.values)
          DropdownMenuItem(
            value: style,
            child: Text(style.toString()),
          )
      ],
    );

    return ListTile(
      title: const Text(
        'appbar style:',
        textScaleFactor: 1.0,
      ),
      trailing: dropdown,
    );
  }
}
