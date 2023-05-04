//หน้า Order
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'downloadExcel/download.dart';

class Demand extends StatefulWidget {
  String? Token; //Token
  int? farmnum; // farm id
  Demand({
    Key? key,
    this.Token,
    this.farmnum,
  }) : super(key: key);

  @override
  State<Demand> createState() => _DemandState();
}

class _DemandState extends State<Demand> {
  var _selectedValue = DateTime.now();
  List<dynamic> nowresult1_23 = [];

  List<dynamic> nowresult1_233(List<dynamic> lat1) {
    var seen = Set<String>();
    List uniquelist =
        lat1.where((student) => seen.add(student['c_order'])).toList();
    nowresult1_23 = uniquelist
        .map((e) => {
              'c_order': e['c_order'],
              'c_formula': e['c_formula'],
              'house': lat1
                  .where((element) =>
                      element['c_order']
                          .toString()
                          .compareTo(e['c_order'].toString()) ==
                      0)
                  .toList(),
            })
        .toList();

    return nowresult1_23;
  }

  List<dynamic> nowresult1_2333(List<dynamic> lat1, index) {
    nowresult1_23 = lat1
        .map((e) => {
              'c_order': e['c_order'],
              'c_formula': e['c_formula'],
              'house': lat1[index]["List"]
                  .where((element) =>
                      element['c_order']
                          .toString()
                          .compareTo(e['c_order'].toString()) ==
                      0)
                  .toList(),
            })
        .toList();
    return nowresult1_23;
  }

  List<Color> C = [
    Colors.orange,
    Color.fromARGB(255, 255, 0, 128),
    Colors.blue,
    Colors.green,
    Colors.deepPurple,
    Color.fromARGB(255, 156, 58, 183),
    Color.fromARGB(255, 0, 255, 195),
    Color.fromARGB(255, 195, 255, 0),
    Color.fromARGB(255, 255, 208, 0),
    Color.fromARGB(255, 160, 50, 55),
    Color.fromARGB(255, 0, 63, 164),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 254, 72, 0),
    Color.fromARGB(255, 255, 0, 89),
    Color.fromARGB(255, 0, 72, 255),
    Color.fromARGB(255, 216, 0, 254),
    Color.fromARGB(255, 183, 58, 110),
    Color.fromARGB(255, 98, 255, 0),
    Color.fromARGB(255, 129, 193, 118),
    Color.fromARGB(255, 92, 0, 250),
  ];

  late double screenW, screenH;
  bool loading1 = true;
  List uniquelist1 = [];
  List<dynamic> nowresult1_1 = [];
  List<dynamic> nowresult1_21 = [];
  List<dynamic> nowresult12_1 = [];
  late List<dynamic> _products1 = [];
  late List<dynamic> _products2 = [];
  List<dynamic> now1 = [];
  List<dynamic> now2 = [];

  //API demand_information
  Future<void> getjaon1_demand_information() async {
    try {
      loading1 = true;
      var urlsum1 =
          Uri.https("smartfarmpro.com", "/v1/api/setting/setting-farm");
      var ressum1 = await http.post(urlsum1,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
          }));
      if (ressum1.statusCode == 200) {
        var result1_1 = json.decode(ressum1.body)['result']['view1'];

        setState(() {
          nowresult1_21 = result1_1;
        });
      }

      var urlsum =
          Uri.https("smartfarmpro.com", "/v1/api/demand/estimate-info");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "Date_Start": "$Y-$M-${_selectedValue.day}",
            "Date_End": "$Y-$M-${_selectedValue.day}"
          }));
      if (ressum.statusCode == 200) {
        var result1_2 = json.decode(ressum.body)['result']['view1'];

        setState(() {
          nowresult1_1 = result1_2;
        });

        if (nowresult1_1 != null) {
          if (nowresult1_1[0]["n_refill"].split(' ').last == 'Bag') {
            var seen = Set<String>();
            List uniquelist = nowresult1_1
                .where((student) => seen.add(student['c_order']))
                .toList();

            setState(() {
              uniquelist1 = uniquelist;
            });

            List<dynamic> nowresult1_2 = uniquelist
                .map((e) => {
                      for (int i = 0; i < uniquelist[0].keys.length; i++)
                        '${nowresult1_1[0].keys.elementAt(i)}':
                            e['${nowresult1_1[0].keys.elementAt(i)}'],
                      'house': nowresult1_1
                          .where((element) =>
                              element['c_order']
                                  .toString()
                                  .compareTo(e['c_order'].toString()) ==
                              0)
                          .toList(),
                    })
                .toList();

            setState(() {
              nowresult12_1 = nowresult1_2;
              loading1 = false;
            });
          } else {
            var seen = Set<String>();
            List uniquelist = nowresult1_1
                .where((student) => seen.add(student['c_order']))
                .toList();
            // //print('c_order===> $uniquelist');

            setState(() {
              uniquelist1 = uniquelist;
            });

            List<dynamic> nowresult1_2 = uniquelist
                .map((e) => {
                      for (int i = 0; i < uniquelist[0].keys.length; i++)
                        '${nowresult1_1[0].keys.elementAt(i)}':
                            e['${nowresult1_1[0].keys.elementAt(i)}'],
                      'house': nowresult1_1
                          .where((element) =>
                              element['c_order']
                                  .toString()
                                  .compareTo(e['c_order'].toString()) ==
                              0)
                          .toList(),
                    })
                .toList();

            setState(() {
              nowresult12_1 = nowresult1_2;
              _products1 = List.generate(nowresult1_1.length, (i) {
                return {
                  "Numder": 0,
                  'c_order': '',
                  'c_formula': '',
                  'List': []
                };
              });

              double D = 0.0, D1 = 0;
              int S = 0, S1 = 0;

              if (nowresult1_21[0]['n_tow'] == 1) {
                for (int j = 0; j < _products1.length; j++) {
                  for (int i = S; i < nowresult1_1.length; i++) {
                    if ((_products1[j]["Numder"] <
                            (nowresult1_21[0]['n_weight'] *
                                nowresult1_21[0]['n_box'])) &&
                        ((_products1[j]["Numder"] +
                                int.parse(
                                    '${nowresult1_1[i]["n_refill"].split(' ').first.replaceAll(',', '')}')) <=
                            (nowresult1_21[0]['n_weight'] *
                                nowresult1_21[0]['n_box']))) {
                      _products1[j]["List"] += [nowresult1_1[i]];
                      _products1[j]["c_order"] = nowresult1_1[S]['c_order'];
                      _products1[j]["c_formula"] = nowresult1_1[S]['c_formula'];
                      _products1[j]["Numder"] += int.parse(
                          '${nowresult1_1[i]["n_refill"].split(' ').first.replaceAll(',', '')}');
                    }
                  }
                  D = double.parse('${_products1[j]["List"].length}');
                  S += D.toInt();
                }

                List<dynamic> nowresult3_42_ =
                    _products1.where((x) => (x['Numder']) != 0).toList();
                now1 = nowresult3_42_;
              }

              if (nowresult1_21[0]['n_tow'] == 2) {
                for (int j = 0; j < _products1.length; j++) {
                  for (int i = S; i < nowresult1_1.length; i++) {
                    if ((_products1[j]["Numder"] <
                            (nowresult1_21[0]['n_weight'] *
                                nowresult1_21[0]['n_box'])) &&
                        ((_products1[j]["Numder"] +
                                int.parse(
                                    '${nowresult1_1[i]["n_refill"].split(' ').first.replaceAll(',', '')}')) <=
                            (nowresult1_21[0]['n_weight'] *
                                nowresult1_21[0]['n_box']))) {
                      _products1[j]["List"] += [nowresult1_1[i]];

                      _products1[j]["c_order"] = nowresult1_1[S]['c_order'];
                      _products1[j]["c_formula"] = nowresult1_1[S]['c_formula'];
                      _products1[j]["Numder"] += int.parse(
                          '${nowresult1_1[i]["n_refill"].split(' ').first.replaceAll(',', '')}');
                    }
                  }
                  D = double.parse('${_products1[j]["List"].length}');
                  S += D.toInt();
                }

                List<dynamic> nowresult3_42_ =
                    _products1.where((x) => ((x['Numder']) != 0)).toList();
                _products2 = List.generate(nowresult3_42_.length, (i) {
                  return {"Numder": 0, 'List': []};
                });

                for (int j = 0; j < _products2.length; j++) {
                  for (int i = S1; i < nowresult3_42_.length; i++) {
                    if ((_products2[j]["Numder"] <
                            ((nowresult1_21[0]['n_weight'] *
                                    nowresult1_21[0]['n_box']) *
                                nowresult1_21[0]['n_tow'])) &&
                        ((_products2[j]["Numder"] +
                                nowresult3_42_[i]['Numder']) <=
                            ((nowresult1_21[0]['n_weight'] *
                                    nowresult1_21[0]['n_box']) *
                                nowresult1_21[0]['n_tow']))) {
                      _products2[j]["List"] += [nowresult3_42_[i]];
                      _products2[j]["Numder"] += nowresult3_42_[i]['Numder'];
                    }
                  }
                  D1 = double.parse('${_products2[j]["List"].length}');
                  S1 += D1.toInt();
                }

                List<dynamic> nowresult3_42_1 =
                    _products2.where((x) => ((x['Numder']) != 0)).toList();

                now2 = nowresult3_42_1;
              }

              loading1 = false;
            });
          }
        } else {
          loading1 = false;
        }
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {}
  }

  late var itemController = ItemScrollController();
  int item = 0;
  DateTime itemdmy = DateTime.now();
  DateTime itemdmy1 = DateTime.now();
  //กำหนดจำนวนวันของเดือน
  Future scrollToitem() async {
    print(item);
    if (item == 0) {
      DateTime day1 = DateTime.now();
      itemController.jumpTo(index: day1.day - 1, alignment: 0.6);
      setState(() {
        item = day1.day;
        itemdmy = DateTime.parse('$Y-$M-${item.toString().padLeft(2, '0')}');
      });
    } else {
      if (day == 31) {
        if (item < 4 || item > 28) {
        } else {
          itemController.jumpTo(index: item, alignment: 0.6);
        }
      }
      if (day == 28) {
        if (item < 4 || item > 25) {
        } else {
          itemController.jumpTo(index: item, alignment: 0.6);
        }
      }
      if (day == 29) {
        if (item < 4 || item > 26) {
        } else {
          itemController.jumpTo(index: item, alignment: 0.6);
        }
      }
      if (day == 30) {
        if (item < 4 || item > 27) {
        } else {
          itemController.jumpTo(index: item, alignment: 0.6);
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getjaon1_demand_information();
    if (int.parse(M) > 0 && int.parse(M) < 10) {
      setState(() {
        M = '0$M';
      });
    }

    if (int.parse(Y) > 0 && int.parse(Y) < 10) {
      Y = '000$Y';
    }
    if (int.parse(Y) >= 10 && int.parse(Y) < 100) {
      Y = '00$Y';
    }
    if (int.parse(Y) >= 100 && int.parse(Y) < 1000) {
      Y = '0$Y';
    }
    if (int.parse(Y) >= 1000) {
      Y = '$Y';
    }
    // _createSampleData();
  }

  late String Y = '${_selectedValue.year}';
  late int YY = int.parse('${_selectedValue.year}');
  late String M = '${_selectedValue.month}';
  late String M2 = '${_selectedValue.month}';
  late int MM = int.parse('${_selectedValue.month}');
  late int day = 31;

  //กำหนดจำนวนวันเดือนปี
  void M3() {
    switch (MM) {
      case 1:
        setState(() {
          M2 = 'JANUARY';
          day = 31;
        });
        break;
      case 2:
        setState(() {
          M2 = 'FEBRUARY';
          // late double DF = double.parse('${_selectedValue.year}');
          late double DF = YY.toDouble();
          print(DF);
          DF = YY / 4.0;
          String DDF = DF.toStringAsFixed(2).toString();

          print(DDF);
          if ('${DDF.split('.').last}' == '00') {
            day = 29;
          } else {
            day = 28;
          }
        });
        break;

      case 3:
        setState(() {
          M2 = 'MARCH';
          day = 31;
        });
        break;

      case 4:
        setState(() {
          M2 = 'APRIL';
          day = 30;
        });
        break;
      case 5:
        setState(() {
          M2 = 'MAY';
          day = 31;
        });
        break;
      case 6:
        setState(() {
          M2 = 'JUNE';
          day = 30;
        });
        break;
      case 7:
        setState(() {
          M2 = 'JULT';
          day = 31;
        });
        break;
      case 8:
        setState(() {
          M2 = 'AUGUST';
          day = 31;
        });
        break;
      case 9:
        setState(() {
          M2 = 'SEPTEMBER';
          day = 30;
        });
        break;
      case 10:
        setState(() {
          M2 = 'OCTOBER';
          day = 31;
        });
        break;
      case 11:
        setState(() {
          M2 = 'NOVEMBER';
          day = 30;
        });
        break;
      case 12:
        setState(() {
          M2 = 'DECEMBER';
          day = 31;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    scrollToitem();
    M3();
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        'Demand by house',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Color(0xff44bca3),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  YY--;
                                  if (YY > 1 && YY < 10) {
                                    Y = '000$YY';
                                  }
                                  if (YY >= 10 && YY < 100) {
                                    Y = '00$YY';
                                  }
                                  if (YY >= 100 && YY < 1000) {
                                    Y = '0$YY';
                                  }
                                  if (YY >= 1000) {
                                    Y = '$YY';
                                  }
                                });
                              },
                              child: Text(
                                '<',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff44bca3),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(left: 1, right: 1),
                                child: Text(
                                  '$Y',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff44bca3),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    YY++;
                                    if (YY > 1 && YY < 10) {
                                      Y = '000$YY';
                                    }
                                    if (YY >= 10 && YY < 100) {
                                      Y = '00$YY';
                                    }
                                    if (YY >= 100 && YY < 1000) {
                                      Y = '0$YY';
                                    }
                                    if (YY >= 1000) {
                                      Y = '$YY';
                                    }
                                  });
                                },
                                child: Text(
                                  '>',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff44bca3),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (MM > 1) {
                                MM--;
                                if (MM > 0 && MM < 10) {
                                  M = '0$MM';
                                } else if (MM >= 10) {
                                  M = '$MM';
                                }
                              } else {}
                              M3();
                            });
                          },
                          child: Text(
                            '<',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Color(0xff44bca3),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: 120,
                              child: Center(
                                  child: Text(
                                '$M2',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff44bca3),
                                ),
                              ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (MM < 12) {
                                MM++;
                                if (MM > 0 && MM < 10) {
                                  M = '0$MM';
                                } else if (MM >= 10) {
                                  M = '$MM';
                                } else {
                                  setState(() {
                                    MM = 12;
                                    M = '$MM';
                                  });
                                }
                              }
                              M3();
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Text(
                                '>',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff44bca3),
                                ),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // stops: [0.3, 1],
                            colors: [
                              Color.fromARGB(255, 160, 193, 238),
                              Color.fromARGB(255, 94, 157, 228)
                            ])),
                    height: 32,
                    width: 90,
                    margin: EdgeInsets.only(top: 5, right: 10),
                    child: TextButton(
                      onPressed: () {
                        saveExcelAgeinformation(nowresult1_1, 'Demand');
                      },
                      child: Text(
                        'Download',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blueAccent,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.3,
                            1
                          ],
                          colors: [
                            Color.fromARGB(255, 160, 193, 238),
                            Color.fromARGB(255, 94, 157, 228)
                          ])),
                  margin: EdgeInsets.only(top: 5),
                  height: 80,
                  child: ScrollablePositionedList.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: day,
                      itemScrollController: itemController,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                item = index + 1;
                                itemdmy = DateTime.parse(
                                    '$Y-$M-${(index + 1).toString().padLeft(2, '0')}');
                                DateTime date = DateTime.parse(
                                    '$Y-$M-${(index + 1).toString().padLeft(2, '0')}');

                                _selectedValue = date;
                                getjaon1_demand_information();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: itemdmy.year != YY
                                      ? Color.fromARGB(0, 255, 214, 64)
                                      : itemdmy.month != MM
                                          ? Color.fromARGB(0, 255, 214, 64)
                                          : itemdmy.day != (index + 1)
                                              ? Color.fromARGB(0, 255, 214, 64)
                                              : Color.fromARGB(
                                                  255, 255, 0, 208),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [
                                        0.3,
                                        1
                                      ],
                                      colors: [
                                        Color.fromARGB(255, 255, 0, 208),
                                        Color.fromARGB(255, 255, 255, 255)
                                      ])),
                              width: 70,
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 40,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
              loading1
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      height: screenH * 0.57,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                  : nowresult1_1 == null
                      ? Container()
                      : Demand(),
            ],
          ),
        ),
      ),
    );
  }

  // หน้าตารางข้อมูล Demand
  Container Demand() {
    if (nowresult1_1[0]["n_refill"].split(' ').last == 'Bag') {
      return Container(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: nowresult12_1.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order : ${nowresult12_1[index]['c_order']}',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                color: Color(0xff44bca3)),
                          ),
                          Text(
                            'No.${nowresult12_1[index]['c_formula']}',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: nowresult12_1[index]['house'].length,
                          itemBuilder: (BuildContext context, int index1) {
                            return Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "${nowresult12_1[index]['house'][index1]['c_house'] ?? 'OVER'}",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                            color: nowresult12_1[index]['house']
                                                        [index1]['c_house'] ==
                                                    null
                                                ? Color.fromARGB(255, 255, 0, 0)
                                                : C[index1]),
                                      ),
                                      Text(
                                        "${nowresult12_1[index]['house'][index1]['c_silo'] ?? ''}",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 166, 165, 165)),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Day${nowresult12_1[index]['house'][index1]['n_day'] ?? ''}',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'Montserrat',
                                        color: nowresult12_1[index]['house']
                                                    [index1]['c_house'] ==
                                                null
                                            ? Color.fromARGB(255, 255, 0, 0)
                                            : C[index1]),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${nowresult12_1[index]['house'][index1]['n_refill']}",
                                        textScaleFactor: 1.0,
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: nowresult12_1[index]['house']
                                                        [index1]['c_house'] ==
                                                    null
                                                ? Color.fromARGB(255, 255, 0, 0)
                                                : C[index1]),
                                      ),
                                      Text(
                                        'Filling Date:${nowresult12_1[index]['house'][index1]['d_gdate']}',
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 166, 165, 165)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            'Demand by truck',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Color(0xff44bca3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    nowresult12_1[index]['c_house'] == null
                        ? Container(
                            width: 380,
                            height: 220,
                            child: Center(
                                child: Text(
                              'No data to display.',
                              textScaleFactor: 1.0,
                              style: TextStyle(fontSize: 18),
                            )))
                        : Container(
                            width: 380,
                            height: 220,
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Image(
                                  image: AssetImage(
                                    'images/sacks3.png',
                                  ),
                                  width: 240,
                                  height: 170,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            width: 15,
                            height: 15,
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              'Over Usage',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color(0xff44bca3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            }),
      );
    } else {
      if (nowresult1_21[0]['n_tow'] == 1) {
        return Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: now1.length,
              itemBuilder: (BuildContext context, int index) {
                nowresult1_233(now1[index]["List"]);

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: nowresult1_23.length,
                              itemBuilder: (BuildContext context, int index0) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Order : ${nowresult1_23[index0]['c_order']}',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                fontFamily: 'Montserrat',
                                                color: Color(0xff44bca3)),
                                          ),
                                          Text(
                                            'No.${nowresult1_23[index0]['c_formula']}',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 10, left: 10),
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: nowresult1_23[index0]
                                                    ['house']
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index1) {
                                              return Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "${nowresult1_23[index0]['house'][index1]['c_house'] ?? 'OVER'}",
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: nowresult1_23[index0]['house']
                                                                              [index1]
                                                                          [
                                                                          'c_house'] ==
                                                                      null
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          0,
                                                                          0)
                                                                  : index0 == 0
                                                                      ? C[
                                                                          index1]
                                                                      : C[index1 +
                                                                          int.parse(
                                                                              '${now1[index0]['List'].length}')]),
                                                        ),
                                                        Text(
                                                          "${nowresult1_23[index0]['house'][index1]['c_silo'] ?? ''}",
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      166,
                                                                      165,
                                                                      165)),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'Day${nowresult1_23[index0]['house'][index1]['n_day'] ?? ''}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: nowresult1_23[index0]
                                                                              ['house']
                                                                          [index1]
                                                                      [
                                                                      'c_house'] ==
                                                                  null
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  0,
                                                                  0)
                                                              : index0 == 0
                                                                  ? C[index1]
                                                                  : C[index1 +
                                                                      int.parse(
                                                                          '${now1[index0]['List'].length}')]),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "${nowresult1_23[index0]['house'][index1]['n_refill']}",
                                                          textScaleFactor: 1.0,
                                                          style: new TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: nowresult1_23[index0]['house']
                                                                              [index1]
                                                                          [
                                                                          'c_house'] ==
                                                                      null
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          0,
                                                                          0)
                                                                  : index0 == 0
                                                                      ? C[
                                                                          index1]
                                                                      : C[index1 +
                                                                          int.parse(
                                                                              '${now1[index0]['List'].length}')]),
                                                        ),
                                                        Text(
                                                          'Filling Date:${nowresult1_23[index0]['house'][index1]['d_gdate']}',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      166,
                                                                      165,
                                                                      165)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              'Demand by truck',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color(0xff44bca3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 380,
                        height: 220,
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 21),
                                child: Image(
                                  image: AssetImage(
                                    'images/s1.jpg',
                                  ),
                                  width: 360,
                                  //  width: screenW*0.7,
                                  height: 170,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: 265,
                                height: 170,
                                margin: EdgeInsets.only(left: 73),
                                child: charts.BarChart(
                                  _createSampleDataBar1(index),
                                  animate: false,
                                  vertical: false,
                                  defaultRenderer: new charts.BarRendererConfig(
                                      groupingType:
                                          charts.BarGroupingType.stacked,
                                      strokeWidthPx: 1.0),
                                  behaviors: [
                                    new charts.PercentInjector<String>(
                                        totalType: charts
                                            .PercentInjectorTotalType.domain)
                                  ],
                                  primaryMeasureAxis:
                                      new charts.NumericAxisSpec(
                                          renderSpec:
                                              new charts.NoneRenderSpec()),
                                  domainAxis: new charts.OrdinalAxisSpec(
                                      showAxisLine: false,
                                      renderSpec: new charts.NoneRenderSpec()),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              width: 15,
                              height: 15,
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                'Over Usage',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff44bca3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              }),
        );
      } else if (nowresult1_21[0]['n_tow'] == 2) {
        return Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: now2.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: now2[index]["List"].length,
                            itemBuilder: (BuildContext context, int index1) {
                              nowresult1_233(
                                  now2[index]["List"][index1]["List"]);

                              return Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: nowresult1_23.length,
                                        itemBuilder:
                                            (BuildContext context, int index0) {
                                          return Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Order : ${nowresult1_23[index0]['c_order']}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Color(
                                                              0xff44bca3)),
                                                    ),
                                                    Text(
                                                      'No.${nowresult1_23[index0]['c_formula']}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          right: 10,
                                                          left: 10),
                                                  child: ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          nowresult1_23[index0]
                                                                  ['house']
                                                              .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index2) {
                                                        return Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${nowresult1_23[index0]['house'][index2]['c_house'] ?? 'OVER'}",
                                                                    textScaleFactor:
                                                                        1.0,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 15,
                                                                        fontFamily: 'Montserrat',
                                                                        color: nowresult1_23[index0]['house'][index2]['c_house'] == null
                                                                            ? Color.fromARGB(255, 255, 0, 0)
                                                                            : index1 != 0
                                                                                ? C[index2 + int.parse('${now2[index]['List'][index1 - 1]['List'].length}')]
                                                                                : index0 == 0
                                                                                    ? C[index2]
                                                                                    : C[index2 + int.parse('${now2[index0]['List'].length}')]),
                                                                  ),
                                                                  Text(
                                                                    "${nowresult1_23[index0]['house'][index2]['c_silo'] ?? ''}",
                                                                    textScaleFactor:
                                                                        1.0,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            166,
                                                                            165,
                                                                            165)),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                'Day${nowresult1_23[index0]['house'][index2]['n_day'] ?? ''}',
                                                                textScaleFactor:
                                                                    1.0,
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 15,
                                                                    fontFamily: 'Montserrat',
                                                                    color: nowresult1_23[index0]['house'][index2]['c_house'] == null
                                                                        ? Color.fromARGB(255, 255, 0, 0)
                                                                        : index1 != 0
                                                                            ? C[index2 + int.parse('${now2[index]['List'][index1 - 1]['List'].length}')]
                                                                            : index0 == 0
                                                                                ? C[index2]
                                                                                : C[index2 + int.parse('${now2[index0]['List'].length}')]),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${nowresult1_23[index0]['house'][index2]['n_refill']}",
                                                                    textScaleFactor:
                                                                        1.0,
                                                                    style: new TextStyle(
                                                                        fontSize: 15.0,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: nowresult1_23[index0]['house'][index2]['c_house'] == null
                                                                            ? Color.fromARGB(255, 255, 0, 0)
                                                                            : index1 != 0
                                                                                ? C[index2 + int.parse('${now2[index]['List'][index1 - 1]['List'].length}')]
                                                                                : index0 == 0
                                                                                    ? C[index2]
                                                                                    : C[index2 + int.parse('${now2[index0]['List'].length}')]),
                                                                  ),
                                                                  Text(
                                                                    'Filling Date:${nowresult1_23[index0]['house'][index2]['d_gdate']}',
                                                                    textScaleFactor:
                                                                        1.0,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            166,
                                                                            165,
                                                                            165)),
                                                                  ),
                                                                ],
                                                              ),
                                                              //               //  Text('dddd'),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                                ],
                              );
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                'Demand by truck',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff44bca3),
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataChartBar2_1(index),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                width: 15,
                                height: 15,
                                color: Color.fromARGB(255, 255, 0, 0),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  'Over Usage',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff44bca3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      }
    }

    return Container();
  }

  // ChartBar และ รูปภาพ  Demand
  Container DataChartBar2_1(int index) {
    if (now2[index]["List"].length == 1) {
      return Container(
        width: 380,
        height: 220,
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Image(
                        image: AssetImage(
                          'images/s2.jpg',
                        ),
                        width: 180,
                        height: 143,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 149,
                      margin: EdgeInsets.only(
                        left: 28,
                      ),
                      child: charts.BarChart(
                        _createSampleDataBar2(index, 0),
                        animate: false,
                        vertical: false,
                        defaultRenderer: new charts.BarRendererConfig(
                            groupingType: charts.BarGroupingType.stacked,
                            strokeWidthPx: 1.0),
                        behaviors: [
                          charts.PercentInjector<String>(
                              totalType: charts.PercentInjectorTotalType.domain)
                        ],
                        primaryMeasureAxis: new charts.NumericAxisSpec(
                            renderSpec: new charts.NoneRenderSpec()),
                        domainAxis: new charts.OrdinalAxisSpec(
                            showAxisLine: false,
                            renderSpec: new charts.NoneRenderSpec()),
                      ),
                    )
                  ],
                ),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 21, left: 180),
                        child: Image(
                          image: AssetImage(
                            'images/s1_cleanup.jpg',
                          ),
                          width: 180,
                          //  width: screenW*0.7,
                          height: 143,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: 175,
                        height: 149,
                        margin: EdgeInsets.only(
                          left: 179,
                        ),
                        child: charts.BarChart(
                          _createSampleDataBar2(index, 0),
                          animate: false,
                          vertical: false,
                          defaultRenderer: new charts.BarRendererConfig(
                              groupingType: charts.BarGroupingType.stacked,
                              strokeWidthPx: 1.0),
                          behaviors: [
                            new charts.PercentInjector<String>(
                                totalType:
                                    charts.PercentInjectorTotalType.domain)
                          ],
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                              renderSpec: new charts.NoneRenderSpec()),
                          domainAxis: new charts.OrdinalAxisSpec(
                              showAxisLine: false,
                              renderSpec: new charts.NoneRenderSpec()),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 380,
        height: 220,
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Image(
                        image: AssetImage(
                          'images/s2.jpg',
                        ),
                        width: 190,
                        height: 130,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: 157,
                      height: 138,
                      margin: EdgeInsets.only(
                        left: 30,
                      ),
                      child: charts.BarChart(
                        _createSampleDataBar2(index, 0),
                        animate: false,
                        vertical: false,
                        defaultRenderer: new charts.BarRendererConfig(
                            groupingType: charts.BarGroupingType.stacked,
                            strokeWidthPx: 1.0),
                        behaviors: [
                          new charts.PercentInjector<String>(
                              totalType: charts.PercentInjectorTotalType.domain)
                        ],
                        primaryMeasureAxis: new charts.NumericAxisSpec(
                            renderSpec: new charts.NoneRenderSpec()),
                        domainAxis: new charts.OrdinalAxisSpec(
                            showAxisLine: false,
                            renderSpec: new charts.NoneRenderSpec()),
                      ),
                    )
                  ],
                ),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 21, left: 190),
                        child: Image(
                          image: AssetImage(
                            'images/s1_cleanup.jpg',
                          ),
                          width: 180,
                          //  width: screenW*0.7,
                          height: 130,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: 175,
                        height: 140,
                        margin: EdgeInsets.only(
                          left: 188,
                        ),
                        child: charts.BarChart(
                          _createSampleDataBar2(index, 1),
                          animate: false,
                          vertical: false,
                          defaultRenderer: new charts.BarRendererConfig(
                              groupingType: charts.BarGroupingType.stacked,
                              strokeWidthPx: 1.0),
                          behaviors: [
                            new charts.PercentInjector<String>(
                                totalType:
                                    charts.PercentInjectorTotalType.domain)
                          ],
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                              renderSpec: new charts.NoneRenderSpec()),
                          domainAxis: new charts.OrdinalAxisSpec(
                              showAxisLine: false,
                              renderSpec: new charts.NoneRenderSpec()),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  //ข้อมูล Chart Demand ที่เป็น Bag
  List<charts.Series<dynamic, String>> _createSampleDataBar1(int index) {
    List<dynamic> color = [
      for (int i = 0; i < now1[index]['List'].length; i++)
        {'c_house': now1[index]['List'][i]['c_house'], 'color': C[i]},
    ];
    List<dynamic> nowresult1_22 = now1[index]['List']
        .map((e) => {
              for (int i = 0; i < now1[index]['List'].length; i++) 'int': '$i',
              'c_order': e['c_order'],
              'c_house': e['c_house'],
              'n_refill':
                  int.parse(e['n_refill'].split(' ').first.replaceAll(',', '')),
              'diff': e['diff'],
              'color': color
                      .where((element) =>
                          element['c_house']
                              .toString()
                              .compareTo(e['c_house'].toString()) ==
                          0)
                      .first['color'] ??
                  null,
            })
        .toList();

    if (nowresult1_22.length > 1) {
      for (int i = 1; i < nowresult1_22.length; i++) {
        if (nowresult1_22[i]['color'] == nowresult1_22[i - 1]['color']) {
          nowresult1_22[i]['color'] = color[i]['color'];
        }
      }
    }

    for (int i = 0; i < nowresult1_22.length; i++) {
      if (nowresult1_22[i]['c_house'] == null) {
        nowresult1_22[i]['color'] = Color.fromARGB(255, 255, 0, 0);
      }
    }
    return [
      charts.Series<dynamic, String>(
          data: nowresult1_22,
          id: '${nowresult1_22[0]['int']}',
          colorFn: (dynamic daily20, __) =>
              charts.ColorUtil.fromDartColor(daily20['color']),
          domainFn: (dynamic daily20, _) => daily20['int'],
          measureFn: (dynamic daily20, _) => daily20['n_refill']),
    ];
  }

  //ข้อมูล Chart Demand ที่เป็น kg
  List<charts.Series<dynamic, String>> _createSampleDataBar2(int index, int A) {
    List<dynamic> color = [
      for (int i = 0; i < now2[index]['List'][A]['List'].length; i++)
        {
          'id': '$i',
          'c_house': now2[index]['List'][A]['List'][i]['c_house'],
          'color': A == 0
              ? C[i]
              : C[i + int.parse('${now2[index]['List'][0]['List'].length}')]
        },
    ];

    List<dynamic> nowresult1_22;

    nowresult1_22 = now2[index]['List'][A]['List']
        .map((e) => {
              for (int i = 0; i < now2[index]['List'][A]['List'].length; i++)
                'int': '$i',
              'c_house': e['c_house'],
              'id': color
                      .where((element) =>
                          element['c_house']
                              .toString()
                              .compareTo(e['c_house'].toString()) ==
                          0)
                      .first['id'] ??
                  null,
              'c_order': e['c_order'],
              'n_refill':
                  int.parse(e['n_refill'].split(' ').first.replaceAll(',', '')),
              'diff': e['diff'],
              'color': color
                      .where((element) =>
                          element['c_house']
                              .toString()
                              .compareTo(e['c_house'].toString()) ==
                          0)
                      .first['color'] ??
                  null,
            })
        .toList();

    if (nowresult1_22.length > 1) {
      for (int i = 1; i < nowresult1_22.length; i++) {
        if (nowresult1_22[i]['color'] == nowresult1_22[i - 1]['color']) {
          nowresult1_22[i]['color'] = color[i]['color'];
        }
      }
    }

    for (int i = 0; i < nowresult1_22.length; i++) {
      if (nowresult1_22[i]['c_house'] == null) {
        nowresult1_22[i]['color'] = Color.fromARGB(255, 255, 0, 0);
      }
    }

    return [
      charts.Series<dynamic, String>(
          data: nowresult1_22,
          id: '${color[0]['id']}',
          colorFn: (dynamic daily20, __) =>
              charts.ColorUtil.fromDartColor(daily20['color']),
          domainFn: (dynamic daily20, _) => daily20['int'],
          measureFn: (dynamic daily20, _) => daily20['n_refill']),
    ];
  }
}
