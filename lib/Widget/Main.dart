//หน้า Main
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../drawer.dart';

class Main1 extends StatefulWidget {
  String? Token; //Token
  String? User; // อีเมล User
  String? Password; // รหัสผ่าน User
  List<dynamic>? HOUSE; //ข้อมูล HOUSE
  int? farmnum; // เลข farm
  int? cropnum2,
      cropnum1,
      cropnum; // cropnum2 ==  farm [index]หรือ id farm / cropnum1 == crop [index]หรือ id crop / cropnum == Main crop id
  Main1(
      {Key? key,
      this.Token,
      this.User,
      this.Password,
      this.HOUSE,
      this.farmnum,
      this.cropnum2,
      this.cropnum1,
      this.cropnum})
      : super(key: key);

  @override
  State<Main1> createState() => _MainState();
}

class _MainState extends State<Main1> {
  TextEditingController _Numder = TextEditingController();
  late String S = '1';
  int selected1 = 0;
  int Col1 = 0;
  int selected2 = 0;
  bool loading = true;
  late List<dynamic>? result0;
  late List<dynamic>? result2;
  late List<dynamic>? result3;
  late var HOUSEnum;
  late var HOUSEname;
  late List<dynamic>? feed;

  var name;
  var age;
  var largestGeekValue;
  var sum = 0.0, sum1 = 0.0;
  var formula1 = 'default', formula2 = 'default';
  var E_Refill1, E_Refill2;
  var A_Refill1, A_Refill2;
  double? percent1, percent2;
  var siloname1, siloname2;
  var kg1, kg2;
  Color? Col11, Col2;
  late var num;
  late String? user = widget.User;
  late String? password = widget.Password;

  //API feed_information
  Future<void> getjaon_feed_information() async {
    try {
      loading = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/main/main-info");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{"farm": widget.farmnum}));
      if (ressum.statusCode == 200) {
        var result11 = jsonDecode(ressum.body);
        setState(() {
          result0 = result11['result']['view1'];
          result2 = result11['result']['view2'];
          loading = false;

          if (result2 == null) {
            result3 = null;
          } else {
            late List<dynamic> _products0 = List.generate(result2!.length, (i) {
              return {'HOUSEname': ''};
            });

            _products0[0]['HOUSEname'] = result2![0]['c_name'];
            for (int i = 1; i < result2!.length; i++) {
              if (result2![i]['c_name'] != result2![i - 1]['c_name']) {
                _products0[i]['HOUSEname'] = result2![i]['c_name'];
              }
            }

            List<dynamic> nowresult3_42_ =
                _products0.where((x) => ((x['HOUSEname']) != '')).toList();

            late List<dynamic> _products1 =
                List.generate(nowresult3_42_.length, (i) {
              return {'HOUSEname': '', 'n_day': '', 'HOUSE': []};
            });
            for (int i = 0; i < nowresult3_42_.length; i++) {
              for (int j = 0; j < result2!.length; j++) {
                if (nowresult3_42_[i]['HOUSEname'] == result2![j]['c_name']) {
                  _products1[i]['HOUSEname'] = nowresult3_42_[i]['HOUSEname'];
                  _products1[i]['n_day'] = result2![j]['n_day'];
                  _products1[i]['HOUSE'] += [result2![j]];
                }
              }
            }

            int numder = 16;
            int sum = 0;
            double a = _products1.length / numder;
            String d1 = a.toStringAsFixed(1).toString().split('.').last;
            String d2 = a.toStringAsFixed(1).toString().split('.').first;
            if (d1 == '0') {
              sum = int.parse('$d2');
            } else {
              sum = int.parse('$d2') + 1;
            }

            late List<dynamic> _products2 = List.generate(sum, (i) {
              return {'Numder': i + 1, 'HOUSE': []};
            });
            int S = 0;
            int D = 0;

            for (int j = 0; j < _products2.length; j++) {
              for (int i = S; i < _products1.length; i++) {
                if (i < S + numder) {
                  _products2[j]['HOUSE'] += [_products1[i]];
                }
              }
              D = _products2[j]['HOUSE'].length;

              S += D;
            }

//

            result3 = _products2;

            loading = false;
            var num1 = result2!.length / 2;
            num = int.parse('${num1.toInt()}');
          }
        });
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print('e ===> ${e.toString()} ');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getjaon_feed_information();
  }

  late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: loading
            ? Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator()))
            : Column(
                children: [
                  result0 == null
                      ? Text('')
                      : Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Column(
                              children: [
                                Container(
                                    width: screenW * 1,
                                    height: 45,
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
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'Summary Feeds',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    )),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    key:
                                        Key('builder1 ${selected1.toString()}'),
                                    itemCount: result0!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        child: Summary_Feeds(index),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                  result3 == null
                      ? Container()
                      : Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Column(
                              children: [
                                Container(
                                    width: screenW * 1,
                                    height: 60,
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
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'HOUSE GROUP',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                          Container(
                                            width: 170,
                                            height: 60,
                                            child: result3!.length == 1
                                                ? Container()
                                                : ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: result3!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Card(
                                                        elevation: 10,
                                                        child: Container(
                                                          width: 50,
                                                          height: 60,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                Duration(
                                                                    seconds:
                                                                        20000);
                                                                Col1 = index;
                                                              });
                                                            },
                                                            child: Text(
                                                              '${result3![index]['Numder']}',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 16,
                                                                color: index ==
                                                                        Col1
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0)
                                                                    : Color(
                                                                        0xff9d9d9d),
                                                              ),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: index ==
                                                                      Col1
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          111,
                                                                          209,
                                                                          186)
                                                                  : Color(
                                                                      0xfffefefe),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                          ),
                                        ],
                                      ),
                                    )),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    key:
                                        Key('builder2 ${selected2.toString()}'),
                                    itemCount: result3![Col1]['HOUSE'].length,
                                    itemBuilder:
                                        (BuildContext context, int index1) {
                                      return Container(
                                        child: HOUSE_GROUP(index1),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }

  //Summary_Feeds
  Summary_Feeds(int index) {
    return Container(
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(0).copyWith(top: 0),
        backgroundColor: Colors.white,
        maintainState: true,
        initiallyExpanded: index == selected1,
        title: ListTile(
          title: Text(
            '${result0![index]['c_formula']}',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: Color(0xff44bca3)),
          ),
        ),
        children: [
          Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 30, 147, 124),
                height: 70,
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                color: Colors.white,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(10.0).copyWith(top: 0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                                width: screenW * 0.4,
                                child: Text(
                                    'Remain : ${NumberFormat("#,###,##0.00").format(result0![index]['a_remain'])}kg')),
                            Text(
                                'Usage : ${NumberFormat("#,###,##0.00").format(result0![index]['a_usage'])}kg'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Container(
                                width: screenW * 0.4,
                                child: Text(
                                    'Refll(Today) : ${NumberFormat("#,###,##0.00").format(result0![index]['a_refill'])}kg')),
                            Text(
                                'Refll(Yedterday) : ${NumberFormat("#,###,##0.00").format(result0![index]['b_refill'])}kg'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  var upper_percent1, lower_percent1;
  var upper_percent2, lower_percent2;
  //HOUSE_GROUP
  HOUSE_GROUP(int index1) {
    name = result3![Col1]['HOUSE'][index1]['HOUSEname'];
    if (result3![Col1]['HOUSE'][index1]['n_day'] == '' ||
        result3![Col1]['HOUSE'][index1]['n_day'] == -1000) {
      age = 'no live';
    } else {
      age = 'age ${result3![Col1]['HOUSE'][index1]['n_day']} day';
    }
    if (result3![Col1]['HOUSE'][index1]['HOUSE'].length == 1) {
      var capacity1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_capacity'];
      var remain1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_remain'];
      E_Refill1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['e_refill'];
      A_Refill1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['a_refill'];
      upper_percent1 =
          result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_upper_percent'];
      lower_percent1 =
          result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_lower_percent'];
      percent1 = (remain1 / capacity1) * 100;
      kg1 = percent1! * 100;
      sum = percent1! / 100;
      if (sum < 0.0) {
        sum = 0.0;
      }
      if (sum > 1.0) {
        sum = 1.0;
      }

      siloname1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['c_silo_name'];

      if (result3![Col1]['HOUSE'][index1]['HOUSE'][0]['c_formula'] == '' ||
          result3![Col1]['HOUSE'][index1]['HOUSE'][0]['c_formula'] == null) {
        formula1 = 'default';
      } else {
        formula1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['c_formula'];
      }
      return ExpansionTile(
          backgroundColor: Colors.white,
          maintainState: true,
          // key: Key(index1.toString()),
          initiallyExpanded: index1 == selected2,
          // onExpansionChanged: (value) {
          //   if (value) {
          //     setState(() {
          //       Duration(seconds: 20000);
          //       selected2 = index1;
          //     });
          //   } else {
          //     setState(() {
          //       selected2 = -1;
          //     });
          //   }
          // },
          title: ListTile(
            title: Text(
              '$name [$age]',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: Color(0xff44bca3)),
            ),
          ),
          children: [
            Stack(
              children: [
                Container(
                  color: Color.fromARGB(255, 30, 147, 124),
                  height: 170,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  color: Colors.white,
                  height: 170,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 55,
                              height: 70,
                              child: CustomPaint(
                                painter: ColorCircle(
                                    S: percent1,
                                    upper_percent: upper_percent1,
                                    lower_percent: lower_percent1),
                              ),
                            ),
                            Container(
                              width: (screenW * 0.85) - 55,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Container(
                                    width: (screenW * 0.85) - 55,
                                    margin: EdgeInsets.only(top: 1),
                                    child: Text(
                                      '$siloname1($formula1)',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: (screenW * 0.85) - 55,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${NumberFormat("#,###,##0.00").format(result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_remain'])} kg',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: (screenW * 0.85) - 55,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${percent1!.toStringAsFixed(2)} %',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Estimate Refill :${NumberFormat("#,###,##0.00").format(E_Refill1)} kg.',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 166, 165, 165)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, right: 10),
                              child: Text(
                                'Actual Refill :${NumberFormat("#,###,##0.00").format(A_Refill1)} kg.',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 166, 165, 165)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 5,
                              ),
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.blueAccent,
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      // stops: [0.3, 1],
                                      colors: [
                                        Color.fromARGB(255, 160, 193, 238),
                                        Color.fromARGB(255, 94, 157, 228)
                                      ])),

                              //  width: screenW*0.5,
                              child: TextButton(
                                onPressed: () {
                                  for (int i = 0;
                                      i < widget.HOUSE!.length;
                                      i++) {
                                    if (result3![Col1]['HOUSE'][index1]
                                            ['HOUSEname'] ==
                                        widget.HOUSE![i]['name']) {
                                      setState(() {
                                        HOUSEnum = widget.HOUSE![i]['id'];
                                        HOUSEname = widget.HOUSE![i]['name'];
                                        feed = widget.HOUSE![i]['feed'];
                                      });
                                    }
                                  }
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Drawer1(
                                          Token: widget.Token,
                                          num1: 2,
                                          User: user,
                                          Password: password,
                                          HOUSE1: HOUSEnum,
                                          HOUSE2: HOUSEname,
                                          cropnum1: widget.cropnum1,
                                          cropnum: widget.cropnum,
                                          cropnum2: widget.cropnum2,
                                          farmnum: widget.farmnum,
                                          Feed: feed,
                                        ),
                                      ),
                                      (route) => false);
                                },
                                child: Text(
                                  'view',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]);
    } else if (result3![Col1]['HOUSE'][index1]['HOUSE'].length == 2) {
      var capacity1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_capacity'];
      var remain1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_remain'];
      upper_percent1 =
          result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_upper_percent'];
      lower_percent1 =
          result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_lower_percent'];
      var capacity2 = result3![Col1]['HOUSE'][index1]['HOUSE'][1]['n_capacity'];
      var remain2 = result3![Col1]['HOUSE'][index1]['HOUSE'][1]['n_remain'];
      upper_percent2 =
          result3![Col1]['HOUSE'][index1]['HOUSE'][1]['n_upper_percent'];
      lower_percent2 =
          result3![Col1]['HOUSE'][index1]['HOUSE'][1]['n_lower_percent'];
      E_Refill1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['e_refill'];
      A_Refill1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['a_refill'];
      percent1 = (remain1 / capacity1) * 100;
      kg1 = percent1! * 100;
      sum = percent1! / 100;

      if (sum < 0.0) {
        sum = 0.0;
      }
      if (sum > 1.0) {
        sum = 1.0;
      }
      if (percent1! >= upper_percent1) {
        Col11 = Color.fromARGB(255, 0, 25, 249);
      } else if (percent1! <= lower_percent1) {
        Col11 = Colors.red;
      } else {
        Col11 = Color.fromARGB(255, 0, 255, 51);
      }
      siloname1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['c_silo_name'];
      percent2 = (remain2 / capacity2) * 100;
      kg2 = percent2! * 100;
      sum1 = percent2! / 100;

      if (sum1 < 0.0) {
        sum1 = 0.0;
      }
      if (sum1 > 1.0) {
        sum1 = 1.0;
      }
      if (percent2! >= upper_percent2) {
        Col2 = Color.fromARGB(255, 0, 25, 249);
      } else if (percent2! <= lower_percent2) {
        Col2 = Colors.red;
      } else {
        Col2 = Color.fromARGB(255, 0, 255, 51);
      }
      siloname2 = result3![Col1]['HOUSE'][index1]['HOUSE'][1]['c_silo_name'];

      // 1
      if (result3![Col1]['HOUSE'][index1]['HOUSE'][0]['c_formula'] == '' ||
          result3![Col1]['HOUSE'][index1]['HOUSE'][0]['c_formula'] == null) {
        formula1 = 'default';
      } else {
        formula1 = result3![Col1]['HOUSE'][index1]['HOUSE'][0]['c_formula'];
      }
      // 2
      if (result3![Col1]['HOUSE'][index1]['HOUSE'][1]['c_formula'] == '' ||
          result3![Col1]['HOUSE'][index1]['HOUSE'][1]['c_formula'] == null) {
        formula2 = 'default';
      } else {
        formula2 = result3![Col1]['HOUSE'][index1]['HOUSE'][1]['c_formula'];
      }
      return ExpansionTile(
          backgroundColor: Colors.white,
          maintainState: true,
          // key: Key(index1.toString()),
          initiallyExpanded: index1 == selected2,
          // onExpansionChanged: (value) {
          //   if (value) {
          //     setState(() {
          //       Duration(seconds: 20000);
          //       selected2 = index1;
          //     });
          //   } else {
          //     setState(() {
          //       selected2 = -1;
          //     });
          //   }
          // },
          title: ListTile(
            title: Text(
              '$name [$age]',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: Color(0xff44bca3)),
            ),
          ),
          children: [
            Stack(
              children: [
                Container(
                  color: Color.fromARGB(255, 30, 147, 124),
                  height: 170,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  color: Colors.white,
                  height: 170,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: screenW * 0.463,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: 55,
                                    height: 70,
                                    child: CustomPaint(
                                      painter: ColorCircle(
                                          S: percent1,
                                          upper_percent: upper_percent1,
                                          lower_percent: lower_percent1),
                                    ),
                                  ),
                                  Container(
                                    width: (screenW * 0.46) - 55,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: (screenW * 0.46) - 55,
                                          margin: EdgeInsets.only(top: 1),
                                          child: Text(
                                            '$siloname1($formula1)',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: (screenW * 0.46) - 55,
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${NumberFormat("#,###,##0.00").format(result3![Col1]['HOUSE'][index1]['HOUSE'][0]['n_remain'])} kg',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: (screenW * 0.46) - 55,
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${percent1!.toStringAsFixed(2)} %',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenW * 0.463,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: 55,
                                    height: 70,
                                    child: CustomPaint(
                                      painter: ColorCircle(
                                          S: percent2,
                                          upper_percent: upper_percent2,
                                          lower_percent: lower_percent2),
                                    ),
                                  ),
                                  Container(
                                    width: (screenW * 0.46) - 55,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: (screenW * 0.46) - 55,
                                          height: 13,
                                          margin: EdgeInsets.only(top: 1),
                                          child: Text(
                                            '$siloname2($formula2)',
                                            style: TextStyle(
                                                // overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: (screenW * 0.46) - 55,
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${NumberFormat("#,###,##0.00").format(result3![Col1]['HOUSE'][index1]['HOUSE'][1]['n_remain'])} kg',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: (screenW * 0.46) - 55,
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${percent2!.toStringAsFixed(2)} %',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Text(
                                'Estimate Refill :${NumberFormat("#,###,##0.00").format(E_Refill1)} kg',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 166, 165, 165)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, right: 10),
                              child: Text(
                                'Actual Refill :${NumberFormat("#,###,##0.00").format(A_Refill1)} kg.',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 166, 165, 165)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.blueAccent,
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      // stops: [0.3, 1],
                                      colors: [
                                        Color.fromARGB(255, 160, 193, 238),
                                        Color.fromARGB(255, 94, 157, 228)
                                      ])),
                              child: TextButton(
                                onPressed: () {
                                  for (int i = 0;
                                      i < widget.HOUSE!.length;
                                      i++) {
                                    if (result3![Col1]['HOUSE'][index1]
                                            ['HOUSEname'] ==
                                        widget.HOUSE![i]['name']) {
                                      setState(() {
                                        HOUSEnum = widget.HOUSE![i]['id'];
                                        HOUSEname = widget.HOUSE![i]['name'];
                                        feed = widget.HOUSE![i]['feed'];
                                      });
                                    }
                                  }

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Drawer1(
                                          Token: widget.Token,
                                          num1: 2,
                                          User: user,
                                          Password: password,
                                          HOUSE1: HOUSEnum,
                                          HOUSE2: HOUSEname,
                                          cropnum1: widget.cropnum1,
                                          cropnum: widget.cropnum,
                                          cropnum2: widget.cropnum2,
                                          farmnum: widget.farmnum,
                                          Feed: feed,
                                        ),
                                      ),
                                      (route) => false);
                                },
                                child: Text(
                                  'view',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]);
    }
  }
}

//รูปภาพ
class ColorCircle extends CustomPainter {
  MaterialColor? myColor;
  double? S;
  double? upper_percent;
  double? lower_percent;

  ColorCircle(
      {@required this.myColor, this.S, this.lower_percent, this.upper_percent});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = Color.fromARGB(255, 95, 95, 95);
    paint.style = PaintingStyle.fill;
    var paint1 = new Paint();
    paint1.color = Color.fromARGB(255, 0, 255, 51);
    paint1.style = PaintingStyle.fill;
    if (S! >= upper_percent!) {
      paint1.color = Color.fromARGB(255, 0, 25, 249);
    }
    if (S! <= lower_percent!) {
      paint1.color = Colors.red;
    }

    var path = new Path();
    path.moveTo(10, -0);
    path.lineTo(10, 45);
    path.lineTo(25, 70);
    path.lineTo(35, 70);
    path.lineTo(50, 45);
    path.lineTo(50, 0);
    path.lineTo(40, -10);
    path.lineTo(20, -10);
    path.close();
    var path1 = new Path();
    if (S! >= 100.0) {
      path1.moveTo(10, -0);
      path1.lineTo(10, 45);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(50, 45);
      path1.lineTo(50, 0);
      path1.lineTo(40, -10);
      path1.lineTo(20, -10);
      path1.close();
      // path1.moveTo(30, -0);
      // path1.lineTo(30, 70);
      // path1.lineTo(50, 100);
      // path1.lineTo(60, 100);
      // path1.lineTo(80, 70);
      // path1.lineTo(80, 0);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      // path1.close();
    }
    if (S! < 100.0 && S! >= 90.0) {
      path1.moveTo(10, -0);
      path1.lineTo(10, 45);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(50, 45);
      path1.lineTo(50, 0);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 90.0 && S! >= 80.0) {
      path1.moveTo(10, 10);
      path1.lineTo(10, 45);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(50, 45);
      path1.lineTo(50, 10);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 80.0 && S! >= 70.0) {
      path1.moveTo(10, 20);
      path1.lineTo(10, 45);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(50, 45);
      path1.lineTo(50, 20);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 70.0 && S! >= 60.0) {
      path1.moveTo(10, 25);
      path1.lineTo(10, 45);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(50, 45);
      path1.lineTo(50, 25);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 60.0 && S! >= 50.0) {
      path1.moveTo(10, 27);
      path1.lineTo(10, 45);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(50, 45);
      path1.lineTo(50, 27);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 50.0 && S! >= 40.0) {
      path1.moveTo(10, 35);
      path1.lineTo(10, 45);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(50, 45);
      path1.lineTo(50, 35);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 40.0 && S! >= 30.0) {
      // path1.moveTo(30, 55);
      path1.moveTo(10, 45);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(50, 45);
      // path1.lineTo(80, 55);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 30.0 && S! >= 20.0) {
      //  path1.moveTo(30, 55);
      path1.moveTo(13.3, 50);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(46.7, 50);
      // path1.lineTo(80, 55);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 20.0 && S! >= 10.0) {
      //  path1.moveTo(30, 62);
      // path1.moveTo(40, 85);
      // path1.lineTo(50, 100);
      // path1.lineTo(60, 100);
      // path1.lineTo(70, 85);
      path1.moveTo(17, 57);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(43, 57);
      // path1.lineTo(80, 62);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 10.0 && S! > 0) {
      //  path1.moveTo(30, 62);
      path1.moveTo(22, 65);
      path1.lineTo(25, 70);
      path1.lineTo(35, 70);
      path1.lineTo(38, 65);
      // path1.lineTo(80, 62);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! == 0.0) {
      //  path1.moveTo(30, 62);
      // path1.lineTo(30, 98);
      // path1.lineTo(50, 100);
      // path1.lineTo(60, 100);
      // path1.lineTo(80, 98);
      // path1.lineTo(80, 62);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
