import 'dart:convert';

// import 'package:bezier_chart/bezier_chart.dart';
// import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:charts_flutter_new/src/text_element.dart' as chartText;
import 'package:charts_flutter_new/src/text_style.dart' as chartStyle;

import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'dart:math';

import '../../dialog.dart';
import '../../drawer.dart';
import '../API_E_B/API_B.dart';
import '../API_E_B/API_E.dart';

import 'package:intl/intl.dart';

import '../downloadExcel/download.dart';

class Inrake_Order extends StatefulWidget {
  String? Token;
  String? User;
  String? Password;
  int? num;
  // หน้า House // Inrake&Order
  List<dynamic>? samount1;
  List<dynamic>? View;
  List<dynamic>? day;
  List<dynamic>? Feed;

  int? farmnum, cropnum2, cropnum1, cropnum;
  String? HOUSEname;
  Inrake_Order(
      {Key? key,
      this.Token,
      this.User,
      this.Password,
      this.View,
      this.samount1,
      this.num,
      this.day,
      this.cropnum,
      this.cropnum1,
      this.cropnum2,
      this.farmnum,
      this.HOUSEname,
      this.Feed})
      : super(key: key);

  @override
  State<Inrake_Order> createState() => _Inrake_OrderState();
}

class _Inrake_OrderState extends State<Inrake_Order> {
  late String? user = widget.User;
  late String? password = widget.Password;
  var linesalesdata0;
  var linesalesdata1;
  var linesalesdata2;
  var linesalesdata4;
  var secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  int selected2 = 0;
  bool Age = true;
  bool Daily = false;
  var pointerValue1, pointerValue2, pointerValue3, date;
  var _pointerValue1, _pointerValue2, _pointerValue3, _date;
  late String sDefault = 'Default';
  List<String> Default = ['Default'];
  late String sPlot = 'แสดงทั้งหมด';
  List<String> Plot = ['แสดงทั้งหมด', 'แสดงถึงวันปัจจุบัน'];

  int Allnum = 7;
  late String samount1 = widget.samount1![1]['name'];
  late int numamount1 = widget.samount1![1]['id'];
  late List<dynamic>? amount;
  late String samount2 = widget.samount1![0]['name'];
  late int numamount2 = widget.samount1![0]['id'];

  late String sFeed1;
  late String sFeed2;
  // late int Feed = widget.Feed![0]['id'];

  late String sView = widget.View![0]['name'];
  late int numView = widget.View![0]['id'];

  late String nameday = widget.day![0]['name'];
  late String? codeday = widget.day![0]['code'];
  String kg1 = 'gram/ea.';
  String kg2 = '';
  late String sGraph = 'กราฟแท่งแบบเป็นกลุ่ม';
  List<String> Graph = [
    'กราฟแท่งแบบเป็นกลุ่ม',
    'กราฟแท่งแบบเลื่อนได้',
  ];
  final List<Map> _products1 = List.generate(1, (i) {
    return {"id": '', "name": "", "price": ''};
  });
  List<dynamic>? NoList = [''];
  String? Noname = '';
  var num;
  late double screenW, screenH;

  //ข้อมูล Chart Plot_Graph
  List<charts.Series<dynamic, String>> _createSampleData1() {
    if (numamount2 == 0 || numamount1 == numamount2) {
      for (int j = 0; j < widget.samount1!.length; j++) {
        if (samount1 == widget.samount1![j]['name']) {
          return [
            for (int i = 0; i < nowresult2_1[0].keys.length; i++)
              if (nowresult2_1[0].keys.elementAt(i) !=
                  nowresult2_1[0].keys.elementAt(0))
                charts.Series<dynamic, String>(
                  colorFn: (__, _) => charts.ColorUtil.fromDartColor(C[i]),
                  id: '${nowresult2_1[0].keys.elementAt(i)}',
                  data: nowresult2_1,
                  // measureOffsetFn : (__, _) => 3,
                  domainFn: (dynamic daily20, _) =>
                      daily20['n_day'] ??
                      daily20['${nowresult2_1[0].keys.elementAt(0)}']
                          .toString(),
                  measureFn: (dynamic daily20, _) =>
                      daily20['${nowresult2_1[0].keys.elementAt(i)}'] ?? null,
                )..setAttribute(charts.rendererIdKey, 'customLine'),
          ];
        }
      }
    }
    if (samount2 != 'ไม่เลือกชุดข้อมูล') {
      if (samount2 != samount1) {
        for (int j = 0; j < widget.samount1!.length; j++) {
          if (samount1 == widget.samount1![j]['name']) {
            return [
              for (int i = 0; i < nowresult2_1[0].keys.length; i++)
                if (nowresult2[0].keys.elementAt(i) !=
                    nowresult2[0].keys.elementAt(0))
                  charts.Series<dynamic, String>(
                    colorFn: (__, _) => charts.ColorUtil.fromDartColor(C[i]),
                    id: '${nowresult2[0].keys.elementAt(i)}',
                    data: nowresult2,
                    domainFn: (dynamic daily20, _) =>
                        daily20['n_day'] ??
                        daily20['${nowresult2[0].keys.elementAt(0)}']
                            .toString(),
                    measureFn: (dynamic daily20, _) =>
                        daily20['${nowresult2[0].keys.elementAt(i)}'] ?? null,
                  )..setAttribute(charts.rendererIdKey, 'customLine'),
              for (int i = nowresult2_1[0].keys.length;
                  i < nowresult2[0].keys.length;
                  i++)
                charts.Series<dynamic, String>(
                  colorFn: (__, _) => charts.ColorUtil.fromDartColor(C[i]),
                  id: '${nowresult2[0].keys.elementAt(i)}',
                  data: nowresult2,
                  domainFn: (dynamic daily20, _) =>
                      daily20['n_day'] ??
                      daily20['${nowresult2[0].keys.elementAt(0)}'].toString(),
                  measureFn: (dynamic daily20, _) =>
                      daily20['${nowresult2[0].keys.elementAt(i)}'] ?? null,
                )
                  ..setAttribute(charts.rendererIdKey, 'customLine')
                  ..setAttribute(
                      charts.measureAxisIdKey, 'secondaryMeasureAxisId'),
            ];
          }
        }
      }
    }
    return [];
  }

  var size;

  List<Color> C = [
    Color.fromARGB(255, 255, 230, 0),
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 131, 0, 116),
    Color.fromARGB(255, 255, 0, 221),
    Color.fromARGB(255, 24, 0, 179),
    Color.fromARGB(255, 200, 117, 164),
    Color.fromARGB(255, 234, 242, 162),
    Color.fromARGB(255, 222, 143, 214),
    Color.fromARGB(255, 164, 57, 148),
    Color.fromARGB(255, 81, 184, 81),
    Color.fromARGB(255, 255, 85, 0),
    Color.fromARGB(255, 125, 193, 202)
  ];
  bool loading1 = true;
  bool loading2 = true;
  bool loading3 = true;

  late List<dynamic> nowresult3 = [];
  late List<dynamic> nowresult1_3 = [];
  List<dynamic> nowresult2_1 = [];
  List<dynamic> nowresult2_2 = [];
  List<dynamic> nowresult2 = [];
  late List<String> nums = [];
  late var nowresult1_1, nowresult1_2, splitted;
  UniqueKey? K1;
  UniqueKey? K2;
  UniqueKey? K3;
  UniqueKey? K4;
  UniqueKey? K5;

  late TextEditingController Date = TextEditingController();
  late TextEditingController Death_Unit = TextEditingController();
  late TextEditingController Reject_Unit = TextEditingController();
  late TextEditingController Usage_Bag = TextEditingController();
  late TextEditingController AddOn_Unit = TextEditingController();
  late TextEditingController Weight_Unit = TextEditingController();
  late TextEditingController Silo1Usage = TextEditingController();
  late TextEditingController Silo1Remain = TextEditingController();
  late TextEditingController Silo1Refill = TextEditingController();
  late TextEditingController Silo2Usage = TextEditingController();
  late TextEditingController Silo2Remain = TextEditingController();
  late TextEditingController Silo2Refill = TextEditingController();
  late String Crop;
  late Color color;
  late bool Crop1;
  late int Crop2;

  late var sum1, percent1, upper_percent1, lower_percent1;
  late var sum2, percent2, upper_percent2, lower_percent2;
  var silo1;
  var silo2;
  //API house_information
  Future<void> getjaon1_house_information() async {
    try {
      loading1 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/house-info");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "Crop": widget.cropnum2,
            "House": widget.num,
            //             "Farm": 1,
            // "Crop": 41,
            // "House": 9
          }));
      if (ressum.statusCode == 200) {
        // //print("ressum211 => ${json.decode(ressum.body)['result']['view1']}");
        // var result1_1 = jsonDecode(ressum.body);
        var result1_1 = json.decode(ressum.body)['result']['view1'];
        // var result1_1 = jsonDecode(ressum.body);
        var result1_2 = json.decode(ressum.body)['result']['view2'];
        var result1_3 = json.decode(ressum.body)['result']['view3'];
        // //print("ressum211 => ${result1_1.length}");
        if (result1_1.length == 2) {
          late String? namef1;
          if (result1_2 != null) {
            namef1 = result1_2[0]['c_datestart'].split('T').first;
          }

          var n_silo1 = result1_1[0]['n_silo'];
          var n_silo2 = result1_1[1]['n_silo'];
          var capacity1 = result1_1[0]['n_capacity'];
          var remain1 = result1_1[0]['n_remain'];
          var capacity2 = result1_1[1]['n_capacity'];
          var remain2 = result1_1[1]['n_remain'];
          //  //print("ressum211 => ${result1_1}");
          setState(() {
            silo1 = n_silo1;
            silo2 = n_silo2;
            sFeed1 = result1_1[0]['c_formula'];
            sFeed2 = result1_1[1]['c_formula'];
            if (widget.Feed != null) {
              if (sFeed1 == '') {
                if (sFeed1 != widget.Feed![0]['name']) {
                  sFeed1 = 'Default';
                } else {}
              }
              if (sFeed2 == '') {
                if (sFeed2 != widget.Feed![0]['name']) {
                  sFeed2 = 'Default';
                } else {}
              }
            }

            upper_percent1 = result1_1[0]['n_upper_percent'];
            lower_percent1 = result1_1[0]['n_lower_percent'];
            percent1 = (remain1 / capacity1) * 100;
            sum1 = remain1;
            upper_percent2 = result1_1[1]['n_upper_percent'];
            lower_percent2 = result1_1[1]['n_lower_percent'];
            percent2 = (remain2 / capacity2) * 100;
            sum2 = remain2;
            if (result1_2 != null) {
              splitted = namef1!.split("-");
            }

            nowresult1_1 = result1_1;
            nowresult1_2 = result1_2;
            nowresult1_3 = result1_3;
            loading1 = false;
          });
        }
        if (result1_1.length == 1) {
          late String? namef1;
          if (result1_2 != null) {
            namef1 = result1_2[0]['c_datestart'].split('T').first;
          }

          var n_silo1 = result1_1[0]['n_silo'];
          var capacity1 = result1_1[0]['n_capacity'];
          var remain1 = result1_1[0]['n_remain'];
          // //print("ressum211 => ${result1_1}");

          setState(() {
            silo1 = n_silo1;
            sFeed1 = result1_1[0]['c_formula'];

            // print(widget.Feed);

            if (widget.Feed != null) {
              if (sFeed1 == '') {
                if (sFeed1 != widget.Feed![0]['name']) {
                  sFeed1 = 'Default';
                } else {}
              }
            }

            upper_percent1 = result1_1[0]['n_upper_percent'];
            lower_percent1 = result1_1[0]['n_lower_percent'];
            percent1 = (remain1 / capacity1) * 100;
            sum1 = remain1;
            if (result1_2 != null) {
              splitted = namef1!.split("-");
            }

            nowresult1_1 = result1_1;
            nowresult1_2 = result1_2;
            nowresult1_3 = result1_3;
            print('widget.Feed');
            print('sFeed1');
            loading1 = false;
          });
        }
        //  //print('result1_1 =====>$nowresult1_1');
        // //print('result1_2 =====>$nowresult1_2');
        // //print('result1_3 =====>$nowresult1_3');
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  //API house_compare
  Future<void> getjaon2_house_compare() async {
    try {
      loading2 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/house-compare");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "Crop": widget.cropnum2,
            "House": widget.num,
            "View0": codeday,
            "View1": numamount1,
            "View2": numamount2
            //             "Farm": 1,
            // "Crop": 1,
            // "House": 1,
            // "View0": "Day",
            // "View1": 1,
            // "View2": 1
          }));
      if (ressum.statusCode == 200) {
        var result2_1 = json.decode(ressum.body)['result']['view1'];
        var result2_2 = json.decode(ressum.body)['result']['view2'];

        setState(() {
          nowresult2_1 = result2_1;
          nowresult2_2 = result2_2;
          loading2 = false;
        });

        if (numamount2 != 0) {
          if (codeday == 'Day') {
            if (sPlot == 'แสดงถึงวันปัจจุบัน') {
              DateTime? dateTime1_ = DateTime.now();
              var newDate = new DateTime(
                  dateTime1_.year, dateTime1_.month - 8, dateTime1_.day - 10);

              List<dynamic> _products1 = [];
              for (int i = 0; i < nowresult2_1.length; i++) {
                var splitted = nowresult2_1[i]
                        ['${nowresult2_1[i].keys.elementAt(0)}']
                    .split('(')
                    .first;
                var splitted1 = splitted.split('-');

                if (int.parse("20${splitted1[2]}") < dateTime1_.year) {
                  _products1 += [nowresult2_1[i]];
                }
                if ((int.parse(splitted1[1]) < dateTime1_.month) &&
                    (int.parse("20${splitted1[2]}") == dateTime1_.year)) {
                  _products1 += [nowresult2_1[i]];
                }
                if ((int.parse(splitted1[0]) <= dateTime1_.day &&
                    int.parse(splitted1[1]) == dateTime1_.month)) {
                  _products1 += [nowresult2_1[i]];
                }
              }

              List<dynamic> _products2 = [];
              for (int i = 0; i < nowresult2_2.length; i++) {
                var splitted = nowresult2_2[i]
                        ['${nowresult2_2[i].keys.elementAt(0)}']
                    .split('(')
                    .first;
                var splitted1 = splitted.split('-');

                if (int.parse("20${splitted1[2]}") < dateTime1_.year) {
                  _products2 += [nowresult2_2[i]];
                }
                if ((int.parse(splitted1[1]) < dateTime1_.month) &&
                    (int.parse("20${splitted1[2]}") == dateTime1_.year)) {
                  _products2 += [nowresult2_2[i]];
                }
                if ((int.parse(splitted1[0]) <= dateTime1_.day &&
                    int.parse(splitted1[1]) == dateTime1_.month)) {
                  _products2 += [nowresult2_2[i]];
                }
              }

              setState(() {
                nowresult2_1 = _products1;
                nowresult2_2 = _products2;
              });
            } else {}
          }
          List<dynamic> nowresult2_ = nowresult2_1
              .map((e) => {
                    for (int i = 0; i < nowresult2_1[0].keys.length; i++)
                      '${nowresult2_1[0].keys.elementAt(i)}':
                          e['${nowresult2_1[0].keys.elementAt(i)}'],
                    for (int i = 1; i < nowresult2_2[0].keys.length; i++)
                      '${nowresult2_2[0].keys.elementAt(i)}': nowresult2_2
                              .where((element) =>
                                  element['${nowresult2_1[0].keys.elementAt(0)}']
                                      .toString()
                                      .compareTo(
                                          e['${nowresult2_1[0].keys.elementAt(0)}']
                                              .toString()) ==
                                  0)
                              .first['${nowresult2_2[0].keys.elementAt(i)}'] ??
                          null,
                  })
              .toList();

          setState(() {
            nowresult2 = nowresult2_;
          });
        } else {
          if (codeday == 'Day') {
            if (sPlot == 'แสดงถึงวันปัจจุบัน') {
              DateTime? dateTime1_ = DateTime.now();
              var newDate = new DateTime(
                  dateTime1_.year, dateTime1_.month - 8, dateTime1_.day - 10);

              List<dynamic> _products1 = [];
              for (int i = 0; i < nowresult2_1.length; i++) {
                var splitted = nowresult2_1[i]
                        ['${nowresult2_1[i].keys.elementAt(0)}']
                    .split('(')
                    .first;
                var splitted1 = splitted.split('-');

                if (int.parse("20${splitted1[2]}") < dateTime1_.year) {
                  _products1 += [nowresult2_1[i]];
                }
                if ((int.parse(splitted1[1]) < dateTime1_.month) &&
                    (int.parse("20${splitted1[2]}") == dateTime1_.year)) {
                  _products1 += [nowresult2_1[i]];
                }
                if ((int.parse(splitted1[0]) <= dateTime1_.day &&
                    int.parse(splitted1[1]) == dateTime1_.month)) {
                  _products1 += [nowresult2_1[i]];
                }
              }

              setState(() {
                nowresult2_1 = _products1;
              });
            } else {}
          }
        }
        List<dynamic>? nowresult2__;

        for (int i = 0; i < nowresult2_1.length; i++) {
          if (i * 12 < nowresult2_1.length && i * 12 >= 0) {
            List<dynamic>? nowresult2_12 = new List.from(nowresult2_1);
            setState(() {
              nowresult2__ = nowresult2_12;
            });
          }
          // //print('j=====> ${nowresult2__}');
        }

        // for(int i = 0;i<nowresult2_1.length;i++){
        //   String result = nowresult2_1[i]['n_day'].split('(').last;
        //    String result1 = result.split(')').first;
        //    //print(result1.toString());
        //    setState(() {
        //     //  nums = result1;
        //    });
        // }

      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  //API house_silo
  Future<void> getjaon3_house_silo() async {
    try {
      loading3 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/house-silo");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "Crop": widget.cropnum2,
            "House": widget.num,
            "View0": codeday,
            "View1": numView
          }));
      if (ressum.statusCode == 200) {
        var result3 = json.decode(ressum.body)['result']['view1'];
        // //print('result3 ===>${ressum.body}');
        setState(() {
          nowresult3 = result3;
          loading3 = false;
        });
        if (codeday == 'Day') {
          if (sPlot == 'แสดงถึงวันปัจจุบัน') {
            DateTime? dateTime1_ = DateTime.now();
            var newDate = new DateTime(
                dateTime1_.year, dateTime1_.month - 8, dateTime1_.day - 10);

            List<dynamic> _products1 = [];
            for (int i = 0; i < nowresult3.length; i++) {
              var splitted = nowresult3[i]['${nowresult3[i].keys.elementAt(0)}']
                  .toString()
                  .split('(')
                  .first;
              var splitted1 = splitted.split('-');

              if (int.parse("20${splitted1[2]}") < dateTime1_.year) {
                _products1 += [nowresult3[i]];
              }
              if ((int.parse(splitted1[1]) < dateTime1_.month) &&
                  (int.parse("20${splitted1[2]}") == dateTime1_.year)) {
                _products1 += [nowresult3[i]];
              }
              if ((int.parse(splitted1[0]) <= dateTime1_.day &&
                  int.parse(splitted1[1]) == dateTime1_.month)) {
                _products1 += [nowresult3[i]];
              }
            }

            setState(() {
              nowresult3 = _products1;
            });
          } else {}
        }
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.farmnum);
    print(widget.cropnum2);
    print(widget.num);
    if (widget.cropnum2 != null) {
      getjaon1_house_information();
      getjaon2_house_compare();
      getjaon3_house_silo();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    size = MediaQuery.of(context).size;
    for (int i = 1; i < widget.samount1!.length; i++) {
      setState(() {
        amount = widget.samount1!;
      });
    }
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:
            // loading1
            //     ? Container(
            //         width: screenW * 1,
            //         height: screenW * 1,
            //         child: Center(child: CircularProgressIndicator()))
            //     :
            Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'RealTime',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(255, 194, 194, 194),
                            width: screenW * 0.005),
                        color: Color.fromARGB(255, 235, 235, 235)),
                    height: 50,
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        API_button_house_estimate(widget.Token, widget.farmnum);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Drawer1(
                                Token: widget.Token,
                                num1: 2,
                                User: user,
                                Password: password,
                                HOUSE1: widget.num,
                                HOUSE2: widget.HOUSEname,
                                cropnum1: widget.cropnum1,
                                cropnum: widget.cropnum,
                                cropnum2: widget.cropnum2,
                                farmnum: widget.farmnum,
                                Feed: widget.Feed,
                              ),
                            ),
                            (route) => false);

                        //     Navigator.pushReplacement(
                        // context,
                        // MaterialPageRoute(
                        //   builder: (context) =>
                        //       Drawer1(Token: widget.Token, num1: 2,User: user,Password: password,HOUSE1:widget.num,HOUSE2: widget.HOUSEname,cropnum1: widget.cropnum1,cropnum:widget.cropnum,cropnum2:widget.cropnum2,farmnum:widget.farmnum,Feed: widget.Feed,),
                        // ));
                      },
                      child: Text(
                        'Estimate',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(child: Age_lnformation1(context)),
            Card(child: Formula2(context)),
            Card(child: Report3(context)),
            Card(child: Plot_Graph4(context)),
            Card(child: Daily_Information_Usage5(context)),
            Container(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  //Age_lnformation
  Widget Age_lnformation1(BuildContext context) => ExpansionTile(
        // key: K1,
        // onExpansionChanged: (value) {
        //   if (value) {
        //     setState(() {
        //       Duration(seconds: 1000);
        //       selected2 = 0;
        //       K2 = UniqueKey();
        //       K3 = UniqueKey();
        //       K4 = UniqueKey();
        //       K5 = UniqueKey();
        //     });
        //   } else {
        //     setState(() {
        //       selected2 = -1;
        //       K2 = UniqueKey();
        //       K3 = UniqueKey();
        //       K4 = UniqueKey();
        //       K5 = UniqueKey();
        //     });
        //   }
        // },
        initiallyExpanded: 0 == selected2,
        title: Text(
          'Age lnformation',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          widget.cropnum2 == null
              ? Container(
                  height: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenW * 0.45,
                        height: 170,
                        child: Column(
                          children: [
                            Center(
                              child: DropdownButtonHideUnderline(
                                child: widget.Feed == null
                                    ? DropdownButton<String>(
                                        value: sDefault,
                                        items: Default.map((Default) =>
                                            DropdownMenuItem<String>(
                                                value: Default,
                                                child: Text(
                                                  Default,
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 25, 25, 25),
                                                  ),
                                                ))).toList(),
                                        onChanged: (Default) {
                                          setState(() {
                                            sDefault = Default!;
                                          });
                                        })
                                    : DropdownButton<String>(
                                        value: sDefault,
                                        items: Default.map((Default) =>
                                            DropdownMenuItem<String>(
                                                value: Default,
                                                child: Text(
                                                  Default,
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 25, 25, 25),
                                                  ),
                                                ))).toList(),
                                        onChanged: (Default) {
                                          setState(() {
                                            sDefault = Default!;
                                            // API_edit_house_silo(widget.Token,widget.farmnum,widget.num,,sFeed1);
                                          });
                                        }),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 100,
                                  height: 100,
                                  child: CustomPaint(
                                    painter: ColorCircle(
                                        S: 0,
                                        upper_percent: 20,
                                        lower_percent: 100),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '0kg',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: Color.fromARGB(255, 25, 25, 25),
                                      ),
                                    ),
                                    Text(
                                      '0.00%',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        color: Color.fromARGB(255, 25, 25, 25),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //   ],
                  // )
                )
              : loading1
                  ? Container(
                      width: screenW * 0.45,
                      height: 170,
                      child: Center(child: CircularProgressIndicator()))
                  : nowresult1_1.length == 1
                      ? Row(
                          children: [
                            Container(
                              width: screenW * 0.47,
                              height: 170,
                              child: Column(
                                children: [
                                  Center(
                                    child: DropdownButtonHideUnderline(
                                      child: widget.Feed == null
                                          ? DropdownButton<String>(
                                              value: sDefault,
                                              items: Default.map((Default) =>
                                                  DropdownMenuItem<String>(
                                                      value: Default,
                                                      child: Text(
                                                        Default,
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Color.fromARGB(
                                                              255, 25, 25, 25),
                                                        ),
                                                      ))).toList(),
                                              onChanged: (Default) {
                                                setState(() {
                                                  sDefault = Default!;
                                                });
                                              })
                                          : DropdownButton<String>(
                                              value: sFeed1,
                                              items: widget.Feed!
                                                  .map((Feed1) =>
                                                      DropdownMenuItem<String>(
                                                          value: Feed1["name"],
                                                          child: Text(
                                                            Feed1["name"],
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      25,
                                                                      25,
                                                                      25),
                                                            ),
                                                          )))
                                                  .toList(),
                                              onChanged: (Feed1) {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                    title: ListTile(
                                                      // leading: Image.asset('images/maps.png',height: 600,),
                                                      title: Text(
                                                          'แก้ไขข้อมูล Feed',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            // fontFamily: fonts,
                                                          )),
                                                      subtitle: Text(
                                                          'คุณต้องการแก้ไขข้อมูล Feed รายการนี้ใช่หรือไม่ ? ',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              // fontFamily: fonts,
                                                              )),
                                                    ),
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Text(
                                                                'ยกเลิก',
                                                                textScaleFactor:
                                                                    1.0,
                                                                style:
                                                                    TextStyle(
                                                                        // fontFamily: fonts,

                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0)),
                                                              )),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                for (int i = 0;
                                                                    i <
                                                                        widget
                                                                            .Feed!
                                                                            .length;
                                                                    i++) {
                                                                  if (widget.Feed![
                                                                              i]
                                                                          [
                                                                          'name'] ==
                                                                      Feed1) {
                                                                    String? F =
                                                                        widget.Feed![i]
                                                                            [
                                                                            'code'];

                                                                    API_edit_house_silo(
                                                                        widget
                                                                            .Token,
                                                                        widget
                                                                            .farmnum,
                                                                        widget
                                                                            .num,
                                                                        silo1.toStringAsFixed(
                                                                            0),
                                                                        F);
                                                                  }
                                                                }
                                                                setState(() {
                                                                  sFeed1 =
                                                                      Feed1!;
                                                                });
                                                              },
                                                              child: Text(
                                                                'ตกลง',
                                                                textScaleFactor:
                                                                    1.0,
                                                                style:
                                                                    TextStyle(
                                                                        // fontFamily: fonts,

                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0)),
                                                              )),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 100,
                                        height: 100,
                                        child: CustomPaint(
                                          painter: ColorCircle(
                                              S: percent1,
                                              upper_percent: upper_percent1,
                                              lower_percent: lower_percent1),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${NumberFormat("#,###,##0.00").format(sum1)}kg',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              color: Color.fromARGB(
                                                  255, 25, 25, 25),
                                            ),
                                          ),
                                          Text(
                                            '${percent1.toStringAsFixed(2)}%',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                              color: Color.fromARGB(
                                                  255, 25, 25, 25),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              width: screenW * 0.45,
                              height: 170,
                              child: Column(
                                children: [
                                  Center(
                                    child: DropdownButtonHideUnderline(
                                      child: widget.Feed == null
                                          ? DropdownButton<String>(
                                              value: sDefault,
                                              items: Default.map((Default) =>
                                                  DropdownMenuItem<String>(
                                                      value: Default,
                                                      child: Text(
                                                        Default,
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Color.fromARGB(
                                                              255, 25, 25, 25),
                                                        ),
                                                      ))).toList(),
                                              onChanged: (Default) {
                                                setState(() {
                                                  sDefault = Default!;
                                                });
                                              })
                                          : DropdownButton<String>(
                                              value: sFeed1,
                                              items: widget.Feed!
                                                  .map((Feed1) =>
                                                      DropdownMenuItem<String>(
                                                          value: Feed1["name"],
                                                          child: Text(
                                                            Feed1["name"],
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      25,
                                                                      25,
                                                                      25),
                                                            ),
                                                          )))
                                                  .toList(),
                                              onChanged: (Feed1) {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                    title: ListTile(
                                                      // leading: Image.asset('images/maps.png',height: 600,),
                                                      title: Text(
                                                          'แก้ไขข้อมูล Feed',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            // fontFamily: fonts,
                                                          )),
                                                      subtitle: Text(
                                                          'คุณต้องการแก้ไขข้อมูล Feed รายการนี้ใช่หรือไม่ ? ',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              // fontFamily: fonts,
                                                              )),
                                                    ),
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Text(
                                                                'ยกเลิก',
                                                                textScaleFactor:
                                                                    1.0,
                                                                style:
                                                                    TextStyle(
                                                                        // fontFamily: fonts,

                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0)),
                                                              )),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                for (int i = 0;
                                                                    i <
                                                                        widget
                                                                            .Feed!
                                                                            .length;
                                                                    i++) {
                                                                  if (widget.Feed![
                                                                              i]
                                                                          [
                                                                          'name'] ==
                                                                      Feed1) {
                                                                    String? F =
                                                                        widget.Feed![i]
                                                                            [
                                                                            'code'];

                                                                    API_edit_house_silo(
                                                                        widget
                                                                            .Token,
                                                                        widget
                                                                            .farmnum,
                                                                        widget
                                                                            .num,
                                                                        silo1.toStringAsFixed(
                                                                            0),
                                                                        F);
                                                                  }
                                                                }
                                                                setState(() {
                                                                  sFeed1 =
                                                                      Feed1!;
                                                                });
                                                              },
                                                              child: Text(
                                                                'ตกลง',
                                                                textScaleFactor:
                                                                    1.0,
                                                                style:
                                                                    TextStyle(
                                                                        // fontFamily: fonts,

                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0)),
                                                              )),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 100,
                                        height: 100,
                                        child: CustomPaint(
                                          painter: ColorCircle(
                                              S: percent1,
                                              upper_percent: upper_percent1,
                                              lower_percent: lower_percent1),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: screenW * 0.18,
                                            child: Text(
                                              '${NumberFormat("#,###,##0.00").format(sum1)}kg',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 25, 25, 25),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: screenW * 0.18,
                                            child: Text(
                                              '${percent1.toStringAsFixed(2)}%',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 25, 25, 25),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenW * 0.45,
                              height: 170,
                              child: Column(
                                children: [
                                  Center(
                                    child: DropdownButtonHideUnderline(
                                      child: widget.Feed == null
                                          ? DropdownButton<String>(
                                              value: sDefault,
                                              items: Default.map((Default) =>
                                                  DropdownMenuItem<String>(
                                                      value: Default,
                                                      child: Text(
                                                        Default,
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Color.fromARGB(
                                                              255, 25, 25, 25),
                                                        ),
                                                      ))).toList(),
                                              onChanged: (Default) {
                                                setState(() {
                                                  // sDefault = Default!;
                                                });
                                              })
                                          : DropdownButton<String>(
                                              value: sFeed2,
                                              items: widget.Feed!
                                                  .map((Feed2) =>
                                                      DropdownMenuItem<String>(
                                                          value: Feed2["name"],
                                                          child: Text(
                                                            Feed2["name"],
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      25,
                                                                      25,
                                                                      25),
                                                            ),
                                                          )))
                                                  .toList(),
                                              onChanged: (Feed2) {
                                                setState(() {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) =>
                                                        SimpleDialog(
                                                      title: ListTile(
                                                        // leading: Image.asset('images/maps.png',height: 600,),
                                                        title: Text(
                                                            'แก้ไขข้อมูล Feed',
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              // fontFamily: fonts,
                                                            )),
                                                        subtitle: Text(
                                                            'คุณต้องการแก้ไขข้อมูล Feed รายการนี้ใช่หรือไม่ ? ',
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                                // fontFamily: fonts,
                                                                )),
                                                      ),
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                                child: Text(
                                                                  'ยกเลิก',
                                                                  textScaleFactor:
                                                                      1.0,
                                                                  style:
                                                                      TextStyle(
                                                                          // fontFamily: fonts,

                                                                          fontSize:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0)),
                                                                )),
                                                            TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                  sFeed2 =
                                                                      Feed2!;
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          widget
                                                                              .Feed!
                                                                              .length;
                                                                      i++) {
                                                                    if (widget.Feed![i]
                                                                            [
                                                                            'name'] ==
                                                                        sFeed2) {
                                                                      API_edit_house_silo(
                                                                          widget
                                                                              .Token,
                                                                          widget
                                                                              .farmnum,
                                                                          widget
                                                                              .num,
                                                                          silo2.toStringAsFixed(
                                                                              0),
                                                                          widget.Feed![i]
                                                                              [
                                                                              'code']);
                                                                    }
                                                                  }
                                                                  // Navigator.pop(context);
                                                                },
                                                                child: Text(
                                                                  'ตกลง',
                                                                  textScaleFactor:
                                                                      1.0,
                                                                  style:
                                                                      TextStyle(
                                                                          // fontFamily: fonts,

                                                                          fontSize:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0)),
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                              }),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 100,
                                        height: 100,
                                        child: CustomPaint(
                                          painter: ColorCircle(
                                              S: percent2,
                                              upper_percent: upper_percent2,
                                              lower_percent: lower_percent2),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: screenW * 0.18,
                                            child: Text(
                                              '${NumberFormat("#,###,##0.00").format(sum2)}kg',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 25, 25, 25),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: screenW * 0.18,
                                            child: Text(
                                              '${percent2.toStringAsFixed(2)}%',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 25, 25, 25),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color(0xfffff1f1f1)),
        ],
      );
  //Formula
  Widget Formula2(BuildContext context) => ExpansionTile(
        // key: K2,
        // onExpansionChanged: (value) {
        //   if (value) {
        //     setState(() {
        //       Duration(seconds: 1000);
        //       selected2 = 1;
        //       K1 = UniqueKey();
        //       K3 = UniqueKey();
        //       K4 = UniqueKey();
        //       K5 = UniqueKey();
        //     });
        //   } else {
        //     setState(() {
        //       selected2 = -1;
        //       K1 = UniqueKey();
        //       K3 = UniqueKey();
        //       K4 = UniqueKey();
        //       K5 = UniqueKey();
        //     });
        //   }
        // },
        // initiallyExpanded: 1 == selected2,
        maintainState: true,
        title: Text(
          'Formula',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          widget.cropnum2 == null
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 135,
                  width: screenW * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Color(0xff9ac7c2), width: screenW * 0.008)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            'Formula: ',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 115, 114, 114)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            'Farming Plan:',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 115, 114, 114)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            'Date Start: ',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 115, 114, 114)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            'Broiler: ',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 115, 114, 114)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            'Age: ',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 115, 114, 114)),
                          ),
                        ),
                      ],
                    ),
                  ))
              : loading1
                  ? Container(
                      width: screenW * 0.45,
                      height: 170,
                      child: Center(child: CircularProgressIndicator()))
                  : nowresult1_2 == null
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 135,
                          width: screenW * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Color(0xff9ac7c2),
                                  width: screenW * 0.008)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: Text(
                                    'Formula: ',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Farming Plan:',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Date Start: ',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Broiler: ',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Age: ',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      : Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 135,
                          width: screenW * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Color(0xff9ac7c2),
                                  width: screenW * 0.008)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: Text(
                                    'Formula: ${nowresult1_2[0]['c_feedtype']}',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Farming Plan: ${nowresult1_2[0]['c_plan']}',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Date Start: ${splitted[2]}-${splitted[1]}-${splitted[0]}',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Broiler: start = ${nowresult1_2[0]['n_number']} , Remain = ${nowresult1_2[0]['n_number']}',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Age: ${nowresult1_2[0]['n_day']}',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 115, 114, 114)),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: nowresult1_2[0]['c_remark'] != null
                                        ? Text(
                                            '${nowresult1_2[0]['c_remark']}',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 115, 114, 114)),
                                          )
                                        : Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 115, 114, 114)),
                                          )),
                              ],
                            ),
                          )),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );
  // Manual Setting
  Future<dynamic> DialogManual(BuildContext context, dynamic nowresult) {
    List<String> clist = nowresult['d_pdate'].split("-");
    DateTime D = DateTime.parse('20${clist[2]}-${clist[1]}-${clist[0]}');
    Date.text = D.toString();
    Death_Unit.text =
        '${nowresult['n_death'] == "" ? '0' : nowresult['n_death']}';
    Reject_Unit.text =
        '${nowresult['n_reject'] == "" ? '0' : nowresult['n_reject']}';
    Usage_Bag.text =
        '${nowresult['n_bag'] == "" ? '0.0' : double.parse(nowresult['n_bag'].split(' ').first) * 1000}';
    Weight_Unit.text =
        '${nowresult['n_weight'] == "" ? '0.00' : nowresult['n_weight'].split(' ').first}';
    AddOn_Unit.text =
        '${nowresult['n_addon'] == "" ? '0' : nowresult['n_addon']}';

    Crop2 = int.parse(
        '${nowresult['n_using_refill'] == "" ? '0' : nowresult['n_using_refill'].split('.').first}');

    Silo1Usage.text =
        '${nowresult['n_usage_1'] == "" ? '0.00' : double.parse(nowresult['n_usage_1'].split(' ').first) * 1000}';
    Silo1Remain.text =
        '${nowresult['n_remain_1'] == "" ? '0.00' : double.parse(nowresult['n_remain_1'].split(' ').first) * 1000}';

    Silo1Refill.text =
        '${nowresult['n_refill_1'] == "" ? '0.00' : double.parse(nowresult['n_refill_1'].split(' ').first) * 1000}';
    Silo2Usage.text =
        '${nowresult['n_usage_2'] == "" ? '0.00' : double.parse(nowresult['n_usage_2'].split(' ').first) * 1000}';
    Silo2Remain.text =
        '${nowresult['n_remain_2'] == "" ? '0.00' : double.parse(nowresult['n_remain_2'].split(' ').first) * 1000}';

    Silo2Refill.text =
        '${nowresult['n_refill_2'] == "" ? '0.00' : double.parse(nowresult['n_refill_2'].split(' ').first) * 1000}';
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                // height: screenH,
                width: screenW * 1,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 8, left: 10),
                              // height: screenH * 0.04,
                              child: Text(
                                'Manual Setting #${widget.HOUSEname}',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 15,
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
                      Date1(setState, nowresult),
                      Death_Reject2(setState, nowresult),
                      Usage_Weight3(setState, nowresult),
                      Usage_Weight3_2(setState, nowresult),
                      False_True4(setState, nowresult),
                      SiloUsage5(setState, nowresult),
                      SiloRemain6(setState, nowresult),
                      SiloRefill7(setState, nowresult),
                      Container(
                        margin: EdgeInsets.only(
                            top: 20, right: 10, left: 10, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              height: 35,
                              width: 110,
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
                                  //                               showDialog(
                                  //   barrierColor: Color.fromARGB(255, 148, 174, 149).withOpacity(0.3),
                                  //   barrierDismissible: false,
                                  //   context: context,
                                  //   builder: (context) {
                                  //     return StatefulBuilder(
                                  //         builder: (BuildContext context, StateSetter setState) {
                                  //       return SimpleDialog(
                                  // title: ListTile(
                                  //   // leading: Image.asset('images/maps.png',height: 600,),
                                  //   title: Text('แก้ไขข้อมูล', textScaleFactor: 1.0,
                                  //   style: TextStyle(
                                  //     color: Colors.green,
                                  //   // fontFamily: fonts,
                                  //   )
                                  //     ),
                                  //   subtitle: Text( textScaleFactor: 1.0,'คุณต้องการแก้ไขข้อมูลรายการนี้ใช่หรือไม่ ? ', style: TextStyle(
                                  //   // fontFamily: fonts,
                                  //   )),

                                  // ),
                                  // children: [
                                  //   Row(
                                  //     mainAxisAlignment: MainAxisAlignment.end,
                                  //     children: [
                                  //       TextButton(onPressed: () => Navigator.pop(context), child: Text( textScaleFactor: 1.0,'ยกเลิก',
                                  //     style: TextStyle(
                                  //       // fontFamily: fonts,

                                  //         fontSize: 15,
                                  //         color: Color.fromARGB(255, 0, 0, 0)),
                                  //   )),
                                  //          TextButton(onPressed: (){
                                  //             Navigator.pop(context);

                                  //                                API_edit_house_usage(
                                  //                                 widget.Token,
                                  //                                 widget.farmnum,
                                  //                                 widget.num,
                                  //                                 nowresult['id'],
                                  //                                 Date.text,
                                  //                                 double.parse(Usage_Bag.text),
                                  //                                 int.parse(Death_Unit.text),
                                  //                                 int.parse(Reject_Unit.text),
                                  //                                 int.parse(AddOn_Unit.text),
                                  //                                 double.parse(Weight_Unit.text),
                                  //                                 double.parse(Silo1Usage.text),
                                  //                                 double.parse(Silo2Usage.text),
                                  //                                 double.parse(Silo1Remain.text),
                                  //                                 double.parse(Silo2Remain.text),
                                  //                                 double.parse(Silo1Refill.text),
                                  //                                 double.parse(Silo2Refill.text),
                                  //                                 Crop2);
                                  //                             if (widget.cropnum2 != null) {
                                  //                               getjaon1_house_information();
                                  //                             }

                                  //                    } , child: Text('ตกลง', textScaleFactor: 1.0,
                                  //     style: TextStyle(
                                  //       // fontFamily: fonts,

                                  //         fontSize: 15,
                                  //         color: Color.fromARGB(255, 0, 0, 0)),
                                  //   )),
                                  //     ],
                                  //   )
                                  // ],

                                  //           );

                                  //     });
                                  //   });
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                      title: ListTile(
                                        // leading: Image.asset('images/maps.png',height: 600,),
                                        title: Text('แก้ไขข้อมูล',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              color: Colors.green,
                                              // fontFamily: fonts,
                                            )),
                                        subtitle: Text(
                                            'คุณต้องการแก้ไขข้อมูลรายการนี้ใช่หรือไม่ ? ',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                // fontFamily: fonts,
                                                )),
                                      ),
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  'ยกเลิก',
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      // fontFamily: fonts,

                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0)),
                                                )),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  API_edit_house_usage(
                                                      widget.Token,
                                                      widget.farmnum,
                                                      widget.num,
                                                      nowresult['id'],
                                                      Date.text,
                                                      double.parse(
                                                          Usage_Bag.text),
                                                      int.parse(
                                                          Death_Unit.text),
                                                      int.parse(
                                                          Reject_Unit.text),
                                                      int.parse(
                                                          AddOn_Unit.text),
                                                      double.parse(
                                                          Weight_Unit.text),
                                                      double.parse(
                                                          Silo1Usage.text),
                                                      double.parse(
                                                          Silo2Usage.text),
                                                      double.parse(
                                                          Silo1Remain.text),
                                                      double.parse(
                                                          Silo2Remain.text),
                                                      double.parse(
                                                          Silo1Refill.text),
                                                      double.parse(
                                                          Silo2Refill.text),
                                                      Crop2);
                                                  if (widget.cropnum2 != null) {
                                                    getjaon1_house_information();
                                                  }
                                                },
                                                child: Text(
                                                  'ตกลง',
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      // fontFamily: fonts,

                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0)),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  'Save',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Container SiloRefill7(StateSetter setState, nowresult) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Silo 1 Refill (kg.):',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Crop1 == false
                        ? Colors.white
                        : Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    onChanged: (text1) {
                      Silo1Remain.text =
                          '${double.parse(Silo1Refill.text == "" ? '0.00' : Silo1Refill.text) - double.parse(Silo1Usage.text == "" ? '0.00' : Silo1Usage.text)}';
                    },
                    controller: Silo1Refill,
                    readOnly: Crop1,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Silo 2 Refill (kg.):',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Crop1 == false
                        ? Colors.white
                        : Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    onChanged: (text1) {
                      Silo2Remain.text =
                          '${double.parse(Silo2Refill.text == "" ? '0.00' : Silo2Refill.text) - double.parse(Silo2Usage.text == "" ? '0.00' : Silo2Usage.text)}';
                    },
                    controller: Silo2Refill,
                    readOnly: Crop1,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container SiloRemain6(StateSetter setState, nowresult) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Silo 1 Remain (kg.):',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Crop1 == false
                        ? Colors.white
                        : Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    onChanged: (text1) {
                      Silo1Usage.text =
                          '${double.parse(Silo1Refill.text == "" ? '0.00' : Silo1Refill.text) - double.parse(Silo1Remain.text == "" ? '0.00' : Silo1Remain.text)}';
                    },
                    controller: Silo1Remain,
                    readOnly: Crop1,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Silo 2 Remain (kg.):',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Crop1 == false
                        ? Colors.white
                        : Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    onChanged: (text1) {
                      Silo2Usage.text =
                          '${double.parse(Silo2Refill.text == "" ? '0.00' : Silo2Refill.text) - double.parse(Silo2Remain.text == "" ? '0.00' : Silo2Remain.text)}';
                    },
                    controller: Silo2Remain,
                    readOnly: Crop1,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container SiloUsage5(StateSetter setState, nowresult) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Silo 1 Usage (kg.):',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Crop1 == false
                        ? Colors.white
                        : Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    onChanged: (text1) {
                      Silo1Remain.text =
                          '${double.parse(Silo1Refill.text == "" ? '0.00' : Silo1Refill.text) - double.parse(Silo1Usage.text == "" ? '0.00' : Silo1Usage.text)}';
                    },
                    controller: Silo1Usage,
                    readOnly: Crop1,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Silo 2 Usage (kg.):',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Crop1 == false
                        ? Colors.white
                        : Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    onChanged: (text1) {
                      Silo2Remain.text =
                          '${double.parse(Silo2Refill.text == "" ? '0.00' : Silo2Refill.text) - double.parse(Silo2Usage.text == "" ? '0.00' : Silo2Usage.text)}';
                    },
                    controller: Silo2Usage,
                    readOnly: Crop1,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container False_True4(StateSetter setState, nowresult) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.74,
            child: Column(
              children: [
                GestureDetector(
                    onTap: (() {
                      if (Crop2 == 1) {
                        setState(() {
                          Crop = 'Disable Refill Value';

                          color = Colors.red;
                          Crop1 = true;
                          Crop2 = 0;
                        });
                      } else if (Crop2 == 0) {
                        setState(() {
                          Crop = 'Enable Refill Value';
                          color = Colors.green;
                          Crop1 = false;
                          Crop2 = 1;
                        });
                      }
                    }),
                    child: Container(
                      height: 40,
                      width: screenW * 0.74,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: color,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Crop,
                            textScaleFactor: 1.0,
                            style: new TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container Usage_Weight3(StateSetter setState, nowresult) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Usage Bag :',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    controller: Usage_Bag,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Weight/Unit (g.) :',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    controller: Weight_Unit,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Usage_Weight3_2(StateSetter setState, nowresult) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'AddOn Unit :',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    controller: AddOn_Unit,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container Death_Reject2(StateSetter setState, nowresult) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Death Unit :',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    controller: Death_Unit,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: screenW * 0.35,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.35,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Reject Unit :',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    controller: Reject_Unit,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
// filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Date1(StateSetter setState, nowresult) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.74,
            child: Column(
              children: [
                Container(
                    width: screenW * 0.74,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Date :',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
                  ),
                  height: 40,
                  width: screenW * 0.74,
                  child: TextField(
                    controller: Date,
                    readOnly: true,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      // filled: true,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcfcfcf)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Report3(BuildContext context) => ExpansionTile(
        // key: K3,
        // onExpansionChanged: (value) {
        //   if (value) {
        //     setState(() {
        //       Duration(seconds: 1000);
        //       selected2 = 2;
        //       K2 = UniqueKey();
        //       K1 = UniqueKey();
        //       K4 = UniqueKey();
        //       K5 = UniqueKey();
        //     });
        //   } else {
        //     setState(() {
        //       selected2 = -1;
        //       K2 = UniqueKey();
        //       K1 = UniqueKey();
        //       K4 = UniqueKey();
        //       K5 = UniqueKey();
        //     });
        //   }
        // },
        // initiallyExpanded: 2 == selected2,
        maintainState: true,
        title: Text(
          'Report',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          widget.cropnum2 == null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        // width: screenW * 0.95,
                        margin: EdgeInsets.only(top: 10),
                        //  color: Colors.blueAccent,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        height: 274,
                      ),
                      Container(
                        // width: screenW * 0.95,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                // stops: [0.3, 1],
                                colors: [
                                  Color.fromARGB(255, 160, 193, 238),
                                  Color.fromARGB(255, 94, 157, 228)
                                ])),
                        height: 60,
                      ),
                      Container(
                        // width: screenW * 0.95,
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(top: 5),

                          height: 274,
                          // child: SingleChildScrollView(

                          child: DataTable(
                              headingRowHeight: 40.0,
                              dataRowColor:
                                  MaterialStateProperty.all(Colors.white),
                              columnSpacing: 0,
                              horizontalMargin: 15,
                              columns: [
                                DataColumn(
                                  label: Container(
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        "Date",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        "day",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                     width: 100,
                                    child: Center(
                                      child: Text(
                                        "No.",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        "Remain",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                     width: 100,
                                    child: Center(
                                      child: Text(
                                        "Refill",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                   width: 100,
                                    child: Center(
                                      child: Text(
                                        "Edit",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: _products1.map((item) {
                                return DataRow(cells: [
                                  DataCell(Center(child: Text(''))),
                                  DataCell(Center(child: Text(''))),
                                  DataCell(Center(child: Text(''))),
                                  DataCell(Center(child: Text(''))),
                                  DataCell(Center(child: Text(''))),
                                  DataCell(Center(child: Text(''))),
                                ]);
                              }).toList()),
                          // )
                        ),
                      ),
                    ],
                  ))
              : loading1
                  ? Container(
                      width: screenW * 0.45,
                      height: 170,
                      child: Center(child: CircularProgressIndicator()))
                  : nowresult1_3 == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Stack(
                              children: [
                                Container(
                                  // width: screenW * 0.95,
                                  margin: EdgeInsets.only(top: 10),
                                  //  color: Colors.blueAccent,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: 274,
                                ),
                                Container(
                                  // width: screenW * 0.95,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueAccent,
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          // stops: [0.3, 1],
                                          colors: [
                                            Color.fromARGB(255, 160, 193, 238),
                                            Color.fromARGB(255, 94, 157, 228)
                                          ])),
                                  height: 60,
                                ),
                                Container(
                                  // width: screenW * 0.95,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(top: 5),

                                    height: 274,
                                    // child: SingleChildScrollView(

                                    child: DataTable(
                                        headingRowHeight: 40.0,
                                        dataRowColor: MaterialStateProperty.all(
                                            Colors.white),
                                        columnSpacing: 0,
                                        horizontalMargin: 15,
                                        columns: [
                                          DataColumn(
                                            label: Container(
                                          width: 100,
                                              child: Center(
                                                child: Text(
                                                  "Date",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                           width: 100,
                                              child: Center(
                                                child: Text(
                                                  "day",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                              width: 100,
                                              child: Center(
                                                child: Text(
                                                  "No.",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                           width: 100,
                                              child: Center(
                                                child: Text(
                                                  "Remain",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                             width: 100,
                                              child: Center(
                                                child: Text(
                                                  "Refill",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                            width: 100,
                                              child: Center(
                                                child: Text(
                                                  "Edit",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: _products1.map((item) {
                                          return DataRow(cells: [
                                            DataCell(Center(child: Text(''))),
                                            DataCell(Center(child: Text(''))),
                                            DataCell(Center(child: Text(''))),
                                            DataCell(Center(child: Text(''))),
                                            DataCell(Center(child: Text(''))),
                                            DataCell(Center(child: Text(''))),
                                          ]);
                                        }).toList()),
                                    // )
                                  ),
                                ),
                              ],
                            ),
                          ))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Stack(
                              children: [
                                Container(
                                  // width: screenW * 0.95,
                                  margin: EdgeInsets.only(top: 10),
                                  //  color: Colors.blueAccent,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: 274,
                                ),
                                Container(
                                  // width: screenW * 0.95,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueAccent,
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          // stops: [0.3, 1],
                                          colors: [
                                            Color.fromARGB(255, 160, 193, 238),
                                            Color.fromARGB(255, 94, 157, 228)
                                          ])),
                                  height: 60,
                                ),
                                Container(
                                  // color: Color.fromARGB(255, 255, 255, 255),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          // stops: [0.3, 1],
                                          colors: [
                                            Color.fromARGB(255, 160, 193, 238),
                                            Color.fromARGB(255, 94, 157, 228)
                                          ])),
                                  margin: EdgeInsets.only(top: 5),
                                  // width: screenW * 1,
                                  height: 274,
                                  child: SingleChildScrollView(
                                    child: DataTable(
                                      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                      //   border: Border.all(color: Color.fromARGB(255, 94, 157, 228), width: 2)),
                                      headingRowHeight: 40.0,
                                      dataRowColor: MaterialStateProperty.all(
                                          Colors.white),
                                      columnSpacing: 0,
                                      horizontalMargin: 15,
                                      // minWidth: screenW * 0.9,
                                      columns: [
                                        DataColumn(
                                          label: Container(
                                       width: 100,
                                            child: Center(
                                              child: Text(
                                                "Date",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Container(
                                           width: 100,
                                            child: Center(
                                              child: Text(
                                                "day",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Container(
                                           width: 100,
                                            child: Center(
                                              child: Text(
                                                "No.",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Container(
                                             width: 100,
                                            child: Center(
                                              child: Text(
                                                "Remain",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Container(
                                             width: 100,
                                            child: Center(
                                              child: Text(
                                                "Refill",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Container(
                                              width: 100,
                                            child: Center(
                                              child: Text(
                                                "Edit",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: widget.cropnum2 == null
                                          ? _products1.map((item) {
                                              return DataRow(cells: [
                                                DataCell(
                                                    Center(child: Text(''))),
                                                DataCell(
                                                    Center(child: Text(''))),
                                                DataCell(
                                                    Center(child: Text(''))),
                                                DataCell(
                                                    Center(child: Text(''))),
                                                DataCell(
                                                    Center(child: Text(''))),
                                                DataCell(
                                                    Center(child: Text(''))),
                                              ]);
                                            }).toList()
                                          : nowresult1_3.map((nowresult) {
                                              return DataRow(cells: [
                                                DataCell(Container(
                                                      width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      '${nowresult['d_pdate'] ?? " "}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily: 'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                                DataCell(Container(
                                                      width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      '${nowresult['n_day'] ?? " "}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily: 'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                                DataCell(Container(
                                                      width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      '${nowresult['price'] ?? " "}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily: 'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                                DataCell(Container(
                                                      width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      '${nowresult['n_remain'] ?? " "}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily: 'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                                DataCell(Container(
                                                      width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      '${nowresult['c_formula'] ?? " "}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                        fontFamily: 'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                                DataCell(
                                                  Container(
                                                        width: 100,
                                                    child: Edit(nowresult, context)),
                                                ),
                                              ]);
                                            }).toList(),
                                    ),
                                  ),
                                  // child: DataTable2(
                                  //   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  //   //   border: Border.all(color: Color.fromARGB(255, 94, 157, 228), width: 2)),
                                  //   headingRowHeight: 40.0,
                                  //   dataRowColor:
                                  //       MaterialStateProperty.all(Colors.white),
                                  //   columnSpacing: 0,
                                  //   horizontalMargin: 15,
                                  //   minWidth: screenW * 0.9,
                                  //   columns: [
                                  //     DataColumn(
                                  //       label: Center(
                                  //         child: Text(
                                  //           "Date", textScaleFactor: 1.0,
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 13,
                                  //               fontFamily: 'Montserrat',
                                  //               color: Color.fromARGB(
                                  //                   255, 255, 255, 255)),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     DataColumn(
                                  //       label: Center(
                                  //         child: Text(
                                  //           "day", textScaleFactor: 1.0,
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 13,
                                  //               fontFamily: 'Montserrat',
                                  //               color: Color.fromARGB(
                                  //                   255, 255, 255, 255)),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     DataColumn(
                                  //       label: Center(
                                  //         child: Text(
                                  //           "No.", textScaleFactor: 1.0,
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 13,
                                  //               fontFamily: 'Montserrat',
                                  //               color: Color.fromARGB(
                                  //                   255, 255, 255, 255)),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     DataColumn(
                                  //       label: Center(
                                  //         child: Text(
                                  //           "Remain", textScaleFactor: 1.0,
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 13,
                                  //               fontFamily: 'Montserrat',
                                  //               color: Color.fromARGB(
                                  //                   255, 255, 255, 255)),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     DataColumn(
                                  //       label: Center(
                                  //         child: Text(
                                  //           "Refill", textScaleFactor: 1.0,
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 13,
                                  //               fontFamily: 'Montserrat',
                                  //               color: Color.fromARGB(
                                  //                   255, 255, 255, 255)),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     DataColumn(
                                  //       label: Center(
                                  //         child: Text(
                                  //           "Edit", textScaleFactor: 1.0,
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 13,
                                  //               fontFamily: 'Montserrat',
                                  //               color: Color.fromARGB(
                                  //                   255, 255, 255, 255)),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  //   rows: widget.cropnum2 == null
                                  //       ? _products1.map((item) {
                                  //           return DataRow(cells: [
                                  //             DataCell(Center(child: Text(''))),
                                  //             DataCell(Center(child: Text(''))),
                                  //             DataCell(Center(child: Text(''))),
                                  //             DataCell(Center(child: Text(''))),
                                  //             DataCell(Center(child: Text(''))),
                                  //             DataCell(Center(child: Text(''))),
                                  //           ]);
                                  //         }).toList()
                                  //       : nowresult1_3.map((nowresult) {
                                  //           return DataRow(cells: [
                                  //             DataCell(Center(
                                  //               child: Text(
                                  //                 '${nowresult['d_pdate'] ?? " "}', textScaleFactor: 1.0,
                                  //                 style: TextStyle(
                                  //                   // fontWeight: FontWeight.bold,
                                  //                   fontSize: 12,
                                  //                   fontFamily: 'Montserrat',
                                  //                 ),
                                  //               ),
                                  //             )),
                                  //             DataCell(Center(
                                  //               child: Text(
                                  //                 '${nowresult['n_day'] ?? " "}', textScaleFactor: 1.0,
                                  //                 style: TextStyle(
                                  //                   // fontWeight: FontWeight.bold,
                                  //                   fontSize: 12,
                                  //                   fontFamily: 'Montserrat',
                                  //                 ),
                                  //               ),
                                  //             )),
                                  //             DataCell(Center(
                                  //               child: Text(
                                  //                 '${nowresult['price'] ?? " "}', textScaleFactor: 1.0,
                                  //                 style: TextStyle(
                                  //                   // fontWeight: FontWeight.bold,
                                  //                   fontSize: 12,
                                  //                   fontFamily: 'Montserrat',
                                  //                 ),
                                  //               ),
                                  //             )),
                                  //             DataCell(Center(
                                  //               child: Text(
                                  //                 '${nowresult['n_remain'] ?? " "}', textScaleFactor: 1.0,
                                  //                 style: TextStyle(
                                  //                   // fontWeight: FontWeight.bold,
                                  //                   fontSize: 12,
                                  //                   fontFamily: 'Montserrat',
                                  //                 ),
                                  //               ),
                                  //             )),
                                  //             DataCell(Center(
                                  //               child: Text(
                                  //                 '${nowresult['c_formula'] ?? " "}', textScaleFactor: 1.0,
                                  //                 style: TextStyle(
                                  //                   // fontWeight: FontWeight.bold,
                                  //                   fontSize: 12,
                                  //                   fontFamily: 'Montserrat',
                                  //                 ),
                                  //               ),
                                  //             )),
                                  //             DataCell(
                                  //               Edit(nowresult, context),
                                  //             ),
                                  //           ]);
                                  //         }).toList(),
                                  // ),
                                ),
                                Container(
                                  // color: Color.fromARGB(255, 255, 255, 255),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          // stops: [0.3, 1],
                                          colors: [
                                            Color.fromARGB(255, 160, 193, 238),
                                            Color.fromARGB(255, 94, 157, 228)
                                          ])),
                                  margin: EdgeInsets.only(top: 5),
                                  // width: screenW * 1,
                                  height: 40,
                                  child: SingleChildScrollView(
                                    child: DataTable(
                                        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                        //   border: Border.all(color: Color.fromARGB(255, 94, 157, 228), width: 2)),
                                        headingRowHeight: 40.0,
                                        dataRowColor: MaterialStateProperty.all(
                                            Colors.white),
                                        columnSpacing: 0,
                                        horizontalMargin: 15,
                                        // minWidth: screenW * 0.9,
                                        columns: [
                                          DataColumn(
                                            label: Container(
                                           width: 100,
                                              child: Center(
                                                child: Text(
                                                  "Date",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                              width: 100,
                                              child: Center(
                                                child: Text(
                                                  "day",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                                  width: 100,
                                              child: Center(
                                                child: Text(
                                                  "No.",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                                 width: 100,
                                              child: Center(
                                                child: Text(
                                                  "Remain",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                                 width: 100,
                                              child: Center(
                                                child: Text(
                                                  "Refill",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Container(
                                                  width: 100,
                                              child: Center(
                                                child: Text(
                                                  "Edit",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Montserrat',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: []),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
          // ),
          Container(
              // margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );
  // Edit  Manual Setting
  Center Edit(nowresult, BuildContext context) {
    DateTime now = DateTime.now();
    List<String> pdate = nowresult['d_pdate'].split("-");
    DateTime D = DateTime.parse('20${pdate[2]}-${pdate[1]}-${pdate[0]}');
    if (D.compareTo(now) >= 0) {
      return Center();
    } else {
      return Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 28,
            width: 28,
            child: IconButton(
              onPressed: () {
                //print(nowresult['d_pdate']);
                setState(() {
                  Crop2 = int.parse(
                      '${nowresult['n_using_refill'] == "" ? '0' : nowresult['n_using_refill'].split('.').first}');
                  if (Crop2 == 0) {
                    setState(() {
                      Crop = 'Disable Refill Value';
                      color = Colors.red;
                      Crop1 = true;
                    });
                  } else if (Crop2 == 1) {
                    setState(() {
                      Crop = 'Enable Refill Value';
                      color = Colors.green;
                      Crop1 = false;
                    });
                  }
                });
                DialogManual(context, nowresult);
              },
              icon: Icon(
                MdiIcons.squareEditOutline,
                color: Color.fromARGB(255, 242, 3, 3),
                size: 15,
              ),
            ),
          ),
        ),
      );
    }
  }

  //Plot_Graph
  Widget Plot_Graph4(BuildContext context) => ExpansionTile(
        // key: K4,
        // onExpansionChanged: (value) {
        //   if (value) {
        //     setState(() {
        //       Duration(seconds: 1000);
        //       selected2 = 3;
        //       K2 = UniqueKey();
        //       K3 = UniqueKey();
        //       K1 = UniqueKey();
        //       K5 = UniqueKey();
        //     });
        //   } else {
        //     setState(() {
        //       selected2 = -1;
        //       K2 = UniqueKey();
        //       K3 = UniqueKey();
        //       K1 = UniqueKey();
        //       K5 = UniqueKey();
        //     });
        //   }
        // },
        // initiallyExpanded: 3 == selected2,
        maintainState: true,
        title: Text(
          'Plot Graph',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: screenW * 0.3,
                  margin: EdgeInsets.only(top: 10, right: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        border: Border.all(color: Color(0xffe0eaeb), width: 3),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.57),
                              blurRadius: 5)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                            value: sPlot,
                            items: Plot.map((Plot) => DropdownMenuItem<String>(
                                value: Plot,
                                child: Text(
                                  Plot,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'THSarabun',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                  ),
                                ))).toList(),
                            onChanged: (Plot) {
                              setState(() {
                                sPlot = Plot!;
                                getjaon2_house_compare();
                                getjaon3_house_silo();
                              });
                            }),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: screenW * 0.3,
                  margin: EdgeInsets.only(top: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        border: Border.all(color: Color(0xffe0eaeb), width: 3),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.57),
                              blurRadius: 5)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                            value: nameday,
                            items: widget.day!
                                .map((day) => DropdownMenuItem<String>(
                                    value: day['name'],
                                    child: Text(
                                      day['name'],
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'THSarabun',
                                        color: Color.fromARGB(255, 25, 25, 25),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (day) {
                              setState(() {
                                nameday = day!;
                                for (int i = 0; i < widget.day!.length; i++) {
                                  if (nameday == widget.day![i]['name']) {
                                    codeday = widget.day![i]['code'];
                                    getjaon2_house_compare();
                                    getjaon3_house_silo();
                                  }
                                }
                              });
                            }),
                      ),
                    ),
                  ),
                ),
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
                  height: 40,
                  width: screenW * 0.25,
                  margin: EdgeInsets.only(top: 10, left: screenW * 0.03),
                  child: TextButton(
                    onPressed: () {
                      if (numamount2 == 0 || numamount1 == numamount2) {
                        saveExcelAgeinformation(nowresult2_1, 'DailyUsageData');
                      } else {
                        saveExcelAgeinformation(nowresult2, 'DailyUsageData');
                      }
                    },
                    child: Text(
                      'Download',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    // style: ElevatedButton.styleFrom(
                    //     primary: Color(0xff44bca3),
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: screenW * 0.4,
                  margin: EdgeInsets.only(top: 10, right: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        border: Border.all(color: Color(0xffe0eaeb), width: 3),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.57),
                              blurRadius: 5)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: DropdownButtonHideUnderline(
                        child: widget.samount1 == null
                            ? DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: Noname,
                                items: NoList!
                                    .map((Nosamount2) =>
                                        DropdownMenuItem<String>(
                                            value: Nosamount2,
                                            child: Text(
                                              Nosamount2,
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'THSarabun',
                                                color: Color.fromARGB(
                                                    255, 25, 25, 25),
                                              ),
                                            )))
                                    .toList(),
                                onChanged: (Nosamount2) {})
                            : DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: samount1,
                                items: amount!
                                    .map((amount) => DropdownMenuItem<String>(
                                        value: amount['name'],
                                        child: Text(
                                          amount["name"],
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'THSarabun',
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (amount) {
                                  for (int i = 1;
                                      i < widget.samount1!.length;
                                      i++) {
                                    if (amount == widget.samount1![i]['name']) {
                                      setState(() {
                                        numamount1 = widget.samount1![i]['id'];
                                        samount1 = amount!;
                                        if (amount.contains('ต่อตัว')) {
                                          kg1 = 'gram/ea.';
                                        }
                                        if (amount.contains('ทั้งหมด')) {
                                          kg1 = 'kg.';
                                        }

                                        if (amount.contains('ต่อวัน')) {
                                          kg1 = 'ea';
                                        }
                                        if (amount.contains('%')) {
                                          kg1 = '%';
                                        }

                                        if (!amount.contains('ต่อตัว') &&
                                            !amount.contains('ทั้งหมด') &&
                                            !amount.contains('อัตรา %') &&
                                            !amount.contains('ต่อวัน')) {
                                          kg1 = '';
                                        }

                                        getjaon2_house_compare();
                                        // //print('n===> ${nowresult2_1[0].keys.length}');
                                        // else {
                                        //    setState(() {
                                        //     n = screenW * 0.02;
                                        //  });

                                        // }
                                      });
                                    }
                                  }
                                }),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: screenW * 0.4,
                  margin: EdgeInsets.only(top: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        border: Border.all(color: Color(0xffe0eaeb), width: 3),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.57),
                              blurRadius: 5)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: DropdownButtonHideUnderline(
                        child: widget.samount1 == null
                            ? DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: Noname,
                                items: NoList!
                                    .map((Nosamount2) =>
                                        DropdownMenuItem<String>(
                                            value: Nosamount2,
                                            child: Text(
                                              Nosamount2,
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'THSarabun',
                                                color: Color.fromARGB(
                                                    255, 25, 25, 25),
                                              ),
                                            )))
                                    .toList(),
                                onChanged: (Nosamount2) {})
                            : DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: samount2,
                                items: widget.samount1!
                                    .map((samount2) => DropdownMenuItem<String>(
                                        value: samount2["name"],
                                        child: Text(
                                          samount2["name"],
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'THSarabun',
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (samount22) {
                                  for (int i = 0;
                                      i < widget.samount1!.length;
                                      i++) {
                                    if (samount22 ==
                                        widget.samount1![i]['name']) {
                                      setState(() {
                                        numamount2 = widget.samount1![i]['id'];
                                        samount2 = samount22!;

                                        if (samount22.contains('ต่อตัว')) {
                                          kg2 = 'gram/ea.';
                                        }
                                        if (samount22.contains('ทั้งหมด')) {
                                          kg2 = 'kg.';
                                        }

                                        if (samount22.contains('ต่อวัน')) {
                                          kg2 = 'ea';
                                        }
                                        if (samount22.contains('อัตรา %')) {
                                          kg2 = '%';
                                        }
                                        if (!samount22.contains('ต่อตัว') &&
                                            !samount22.contains('ทั้งหมด') &&
                                            !samount22.contains('อัตรา %') &&
                                            !samount22.contains('ต่อวัน')) {
                                          kg2 = '';
                                        }
                                        getjaon2_house_compare();
                                      });
                                    }
                                  }
                                }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          widget.cropnum2 == null
              ? Container(
                  height: screenH * 0.57,
                  child: Center(
                      child: Text(
                    'No data to display.',
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                  )),
                )
              : loading2
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      height: screenH * 0.57,
                      child: Center(child: CircularProgressIndicator()))
                  : nowresult2_1 == null
                      ? Container(
                          height: screenH * 0.57,
                          child: Center(
                              child: Text(
                            'No data to display.',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Montserrat'),
                          )),
                        )
                      : newMethodLine4(),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );

  // Chart Plot_Graph
  Container newMethodLine4() {
    double n = screenW * 0.065;
    int? sC, sF;
    if (numamount2 == 0 || numamount2 == numamount1) {
      if (nowresult2_1[0].keys.length == 3) {
        n = screenW * 0.065;
        sC = 2;
        sF = 13;
        if (samount1 == 'ปริมาณการเติมสะสม') {
          n = screenW * 0.055;
          sF = 11;
        }
      } else if (nowresult2_1[0].keys.length == 4) {
        n = screenW * 0.015;
        sC = 3;
        sF = 13;
      }
    } else if (numamount2 != numamount1) {
      if (nowresult2_1[0].keys.length == 3) {
        n = screenW * 0.065;
        sC = 2;
        sF = 13;
        if (samount2 == 'ปริมาณการเติมสะสม') {
          n = screenW * 0.055;
          sF = 11;
        }
        if (samount1 == 'ปริมาณการเติมสะสม') {
          n = screenW * 0.055;
          sF = 11;
        }
      } else if (nowresult2_1[0].keys.length == 4) {
        n = screenW * 0.005;
        sC = 3;
        sF = 13;
        if (samount2 == 'ปริมาณการกินทั้งหมดสะสม') {
          sF = 12;
        } else if (samount2 == 'ปริมาณการกินต่อตัวสะสม') {
          sF = 11;
        }
      }
    }

    double? Number;

    if (nowresult2_1.length < 30) {
      Number = nowresult2_1.length / 11;
    }
    if (nowresult2_1.length > 30) {
      Number = nowresult2_1.length / 15;
    }
    if (nowresult2_1.length > 100) {
      Number = nowresult2_1.length / 12;
    }
    String Number1 = Number!.toStringAsFixed(0);
    int Number2 = int.parse('$Number1');

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: screenH * 0.57,
      child: charts.BarChart(
        _createSampleData1(),
        animate: false,
        defaultInteractions: true,
        defaultRenderer: new charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(30),
          groupingType: charts.BarGroupingType.grouped,
        ),
        animationDuration: Duration(seconds: 1),
        customSeriesRenderers: [
          new charts.LineRendererConfig(
              includeArea: true,
              includeLine: true,
              includePoints: false,
              strokeWidthPx: 1,
              areaOpacity: 499,
              customRendererId: 'customLine')
        ],
        behaviors: [
          charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer(
                nowresult2: nowresult2,
                size: size,
                samount1: samount1,
                samount2: samount2,
                nowresult2_1: nowresult2_1,
                nowresult2_2: nowresult2_2,
                amount1: amount,
                amount2: widget.samount1),
          ),
          new charts.PanAndZoomBehavior(),
          new charts.SelectNearest(
              maximumDomainDistancePx: 1,
              eventTrigger: charts.SelectionTrigger.pressHold),
          new charts.ChartTitle(
            'day',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          new charts.ChartTitle(
            kg1,
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          new charts.ChartTitle(
            kg2,
            behaviorPosition: charts.BehaviorPosition.end,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          new charts.SelectNearest(
              eventTrigger: charts.SelectionTrigger.pressHold),
          new charts.PanAndZoomBehavior(),
          new charts.SeriesLegend(
            cellPadding: EdgeInsets.symmetric(horizontal: screenW * 0.065),
            position: charts.BehaviorPosition.bottom,
            desiredMaxColumns: 2,
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.black,
                fontFamily: 'Montserrat',
                fontSize: sF),
            outsideJustification: charts.OutsideJustification.start,
            // cellPadding: new EdgeInsets.only(right: 40.0, bottom: 4.0),
          ),
        ],
        domainAxis: charts.OrdinalAxisSpec(
          showAxisLine: false,
          renderSpec: charts.SmallTickRendererSpec(
            labelRotation: 50,
            labelStyle: new charts.TextStyleSpec(
                fontSize: 13, fontFamily: 'Montserrat'),
          ),
          // viewport: new charts.OrdinalViewport(nowresult2_1[0]['day'], num),
          tickProviderSpec:
              charts.StaticOrdinalTickProviderSpec(<charts.TickSpec<String>>[
            new charts.TickSpec(
                '${nowresult2_1[0]['n_day'] ?? nowresult2_1[0].keys.elementAt(0).toString()}'),
            if (nowresult2_1[0].keys.elementAt(0) == 'n_day')
              for (int i = 0; i < nowresult2_1.length; i++)
                if (i * Number2 > 0 && i * Number2 < nowresult2_1.length)
                  new charts.TickSpec('${nowresult2_1[i * Number2]['n_day']}'),
            if (nowresult2_1[0].keys.elementAt(0).toString() != 'n_day')
              for (int i = 0; i < nowresult2_1.length; i++)
                if (i >= 0 && i < nowresult2_1.length)
                  new charts.TickSpec(
                      '${nowresult2_1[i][nowresult2_1[0].keys.elementAt(0).toString()]}'),
          ]),
        ),
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickFormatterSpec:
                charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                    NumberFormat.compact()),
            tickProviderSpec: charts.BasicNumericTickProviderSpec(
              zeroBound: true,
              desiredTickCount: 6,
            ),
            renderSpec: new charts.GridlineRendererSpec(
                labelStyle: new charts.TextStyleSpec(fontSize: 13),
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),
        secondaryMeasureAxis: new charts.NumericAxisSpec(
            tickFormatterSpec:
                charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                    NumberFormat.compact()),
            tickProviderSpec: charts.BasicNumericTickProviderSpec(
              zeroBound: true,
              desiredTickCount: 6,
            ),
            renderSpec: new charts.GridlineRendererSpec(
                labelStyle: new charts.TextStyleSpec(fontSize: 13),
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),
        selectionModels: [
          charts.SelectionModelConfig(
              // type: charts.SelectionModelType.,
              changedListener: (charts.SelectionModel model) {},
              updatedListener: (charts.SelectionModel model) {
                if (model.hasDatumSelection) {
                  selectedDatum = [];
                  if (samount2 == 'ไม่เลือกชุดข้อมูล' || samount2 == samount1) {
                    for (int j = 0; j < widget.samount1!.length; j++) {
                      if (samount1 == amount![j]['name']) {
                        model.selectedDatum
                            .forEach((charts.SeriesDatum datumPair) {
                          selectedDatum!.add({
                            // ToolTipMgr1.setTitle1({
                            'title':
                                '${datumPair.datum['n_day'] ?? datumPair.datum['${nowresult2_1[0].keys.elementAt(0)}'].toString()}',
                            for (int i = 1;
                                i < nowresult2_1[0].keys.length;
                                i++)
                              'subTitle${i}':
                                  '${datumPair.datum['${nowresult2_1[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                            // })
                          });
                        });
                      }
                    }
                  }
                  if (samount2 != 'ไม่เลือกชุดข้อมูล') {
                    for (int j = 0; j < widget.samount1!.length; j++) {
                      if (samount1 == amount![j]['name']) {
                        model.selectedDatum
                            .forEach((charts.SeriesDatum datumPair) {
                          selectedDatum!.add({
                            // ToolTipMgr2.setTitle1({
                            'title':
                                '${datumPair.datum['n_day'] ?? datumPair.datum['${nowresult2[0].keys.elementAt(0)}'].toString()}',
                            for (int i = 1; i < nowresult2[0].keys.length; i++)
                              'subTitle${i}':
                                  '${datumPair.datum['${nowresult2[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                            // for(int i = 1;i<nowresult2_2[0].keys.length;i++)
                            // 'subTitle1${i}': '${datumPair.datum['${nowresult2_2[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                            // })
                          });
                        });
                      }
                    }
                  }
                }
              })
        ],
      ),
    );
  }

  //Daily_Information_Usage
  Widget Daily_Information_Usage5(BuildContext context) => ExpansionTile(
        // key: K5,
        // onExpansionChanged: (value) {
        //   if (value) {
        //     setState(() {
        //       Duration(seconds: 1000);
        //       selected2 = 4;
        //       K2 = UniqueKey();
        //       K3 = UniqueKey();
        //       K4 = UniqueKey();
        //       K1 = UniqueKey();
        //     });
        //   } else {
        //     setState(() {
        //       selected2 = -1;
        //       K2 = UniqueKey();
        //       K3 = UniqueKey();
        //       K4 = UniqueKey();
        //       K1 = UniqueKey();
        //     });
        //   }
        //   // //print(selected2);
        // },
        // initiallyExpanded: 4 == selected2,
        maintainState: true,
        title: Text(
          'Daily Information Usage',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: screenW * 0.3,
                  margin: EdgeInsets.only(top: 10, right: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        border: Border.all(color: Color(0xffe0eaeb), width: 3),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.57),
                              blurRadius: 5)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: DropdownButtonHideUnderline(
                        child: widget.View == null
                            ? DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: Noname,
                                items: NoList!
                                    .map((NoView) => DropdownMenuItem<String>(
                                        value: NoView,
                                        child: Text(
                                          NoView,
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'THSarabun',
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (NoView) {})
                            : DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: sView,
                                items: widget.View!
                                    .map((View) => DropdownMenuItem<String>(
                                        value: View['name'],
                                        child: Text(
                                          View['name'],
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'THSarabun',
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (View) {
                                  setState(() {
                                    sView = View!;
                                  });
                                  for (int i = 0;
                                      i < widget.View!.length;
                                      i++) {
                                    if (View == widget.View![i]['name']) {
                                      setState(() {
                                        sView = View!;
                                        numView = widget.View![i]['id'];
                                        getjaon3_house_silo();
                                      });
                                    }
                                  }
                                }),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: screenW * 0.3,
                  margin: EdgeInsets.only(top: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        border: Border.all(color: Color(0xffe0eaeb), width: 3),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.57),
                              blurRadius: 5)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                            value: sGraph,
                            items:
                                Graph.map((Graph) => DropdownMenuItem<String>(
                                    value: Graph,
                                    child: Text(
                                      Graph,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'THSarabun',
                                        color: Color.fromARGB(255, 25, 25, 25),
                                      ),
                                    ))).toList(),
                            onChanged: (Graph) {
                              setState(() {
                                sGraph = Graph!;
                              });
                              num = nowresult3.length;
                              if (Graph == 'กราฟแท่งแบบเป็นกลุ่ม') {
                                setState(() {
                                  num = nowresult3.length;
                                });
                              }
                              if (Graph == 'กราฟแท่งแบบเลื่อนได้') {
                                setState(() {
                                  if (nowresult3[0].keys.elementAt(0) ==
                                      'n_day') num = 10;
                                  if (nowresult3[0].keys.elementAt(0) ==
                                      'n_week') num = 3;
                                  if (nowresult3[0].keys.elementAt(0) ==
                                      'n_month') num = 2;
                                });
                              }
                            }),
                      ),
                    ),
                  ),
                ),
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
                  height: 40,
                  width: screenW * 0.25,
                  margin: EdgeInsets.only(top: 10, left: screenW * 0.03),
                  child: TextButton(
                    onPressed: () {
                      saveExcelAgeinformation(nowresult3, 'DailyUsageData');
                    },
                    child: Text(
                      'Download',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              height: screenH * 0.57,
              child: widget.cropnum2 == null
                  ? Container(
                      height: screenH * 0.57,
                      child: Center(
                          child: Text(
                        'No data to display.',
                        textScaleFactor: 1.0,
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                      )),
                    )
                  : loading3
                      ? Center(child: CircularProgressIndicator())
                      : nowresult3 == null
                          ? Container(
                              height: screenH * 0.57,
                              child: Center(
                                  child: Text(
                                'No data to display.',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Montserrat'),
                              )),
                            )
                          : BarChart5()),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );
  // Chart Daily_Information_Usage
  charts.BarChart BarChart5() {
    double? Number;

    if (nowresult3.length < 100) {
      Number = nowresult3.length / 15;
    }
    if (nowresult3.length > 100) {
      Number = nowresult3.length / 12;
    }
    String Number1 = Number!.toStringAsFixed(0);
    int Number2 = int.parse('$Number1');

    return charts.BarChart(
      _createSampleDataBar(),
      animate: false,
      defaultInteractions: true,
      defaultRenderer: new charts.BarRendererConfig(
        cornerStrategy: const charts.ConstCornerStrategy(30),
        groupingType: charts.BarGroupingType.grouped,
      ),
      animationDuration: Duration(seconds: 1),
      domainAxis: charts.OrdinalAxisSpec(
        showAxisLine: false,
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 50,
          labelStyle: new charts.TextStyleSpec(
            fontSize: 13,
            fontFamily: 'Montserrat',
          ),
        ),
        viewport: new charts.OrdinalViewport(
            nowresult3[0]['n_day'] ??
                nowresult3[0]['${nowresult3[0].keys.elementAt(0)}'].toString(),
            num),
        tickProviderSpec:
            charts.StaticOrdinalTickProviderSpec(<charts.TickSpec<String>>[
          new charts.TickSpec('${nowresult3[0]['n_day']}'),
          if (nowresult3[0].keys.elementAt(0).toString() == 'n_day')
            // for (int i = 0; i < nowresult3.length; i++)
            //   if (i * 3 > 0 && i * 3 < nowresult3.length)
            //     new charts.TickSpec('${nowresult3[i * 3]['n_day']}'),
            for (int i = 0; i < nowresult3.length; i++)
              if (i * Number2 > 0 && i * Number2 < nowresult3.length)
                new charts.TickSpec('${nowresult3[i * Number2]['n_day']}'),
          if (nowresult3[0].keys.elementAt(0).toString() != 'n_day')
            for (int i = 0; i < nowresult3.length; i++)
              if (i >= 0 && i < nowresult3.length)
                new charts.TickSpec(
                    '${nowresult3[i][nowresult3[0].keys.elementAt(0).toString()]}'),
        ]),
      ),
      selectionModels: [
        charts.SelectionModelConfig(
          updatedListener: (charts.SelectionModel model) {
            if (model.hasDatumSelection) {
              selectedDatum = [];
              model.selectedDatum.forEach((charts.SeriesDatum datumPair) {
                selectedDatum!.add({
                  date =
                      '${datumPair.datum['n_day'] ?? datumPair.datum['${nowresult3[0].keys.elementAt(0)}']}',
                  pointerValue1 =
                      '${datumPair.datum['${nowresult3[0].keys.elementAt(1)}'] ?? 'undefeated'}',
                  pointerValue2 =
                      '${datumPair.datum['${nowresult3[0].keys.elementAt(2)}'] ?? 'undefeated'}',
                  pointerValue3 =
                      '${datumPair.datum['${nowresult3[0].keys.elementAt(3)}'] ?? 'undefeated'}',
                  ToolTipMgr.setTitle({
                    'title':
                        '${datumPair.datum['n_day'] ?? datumPair.datum['${nowresult3[0].keys.elementAt(0)}']}',
                    'subTitle':
                        '${datumPair.datum['${nowresult3[0].keys.elementAt(1)}'] ?? 'undefeated'}',
                    'subTitle1':
                        '${datumPair.datum['${nowresult3[0].keys.elementAt(2)}'] ?? 'undefeated'}',
                    'subTitle2':
                        '${datumPair.datum['${nowresult3[0].keys.elementAt(3)}'] ?? 'undefeated'}',
                  })
                });
              });
            }
          },
        ),
      ],
      behaviors: [
        charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag),
        new charts.SelectNearest(
            eventTrigger: charts.SelectionTrigger.longPressHold),
        charts.LinePointHighlighter(
          // defaultRadiusPx: 5.0,
          // drawFollowLinesAcrossChart: true,
          // showHorizontalFollowLine:
          //     charts.LinePointHighlighterFollowLineType.nearest,
          // showVerticalFollowLine:
          //     charts.LinePointHighlighterFollowLineType.nearest,
          symbolRenderer: CustomCircleSymbolRenderer1(),
        ),
        new charts.PanAndZoomBehavior(),
        new charts.SelectNearest(
            maximumDomainDistancePx: 1,
            eventTrigger: charts.SelectionTrigger.pressHold),
        new charts.SeriesLegend(
          cellPadding: EdgeInsets.symmetric(horizontal: screenW * 0.02),

          // showMeasures: true,
          entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.black,
              fontFamily: 'Montserrat',
              fontSize: 11),
          desiredMaxRows: 1,
          horizontalFirst: false,
          outsideJustification: charts.OutsideJustification.startDrawArea,
        ),
        new charts.ChartTitle(
          'day',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
          titleStyleSpec: charts.TextStyleSpec(
            fontSize: 14,
            fontFamily: 'Montserrat',
          ),
        ),
        new charts.ChartTitle(
          'kg',
          behaviorPosition: charts.BehaviorPosition.start,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
          titleStyleSpec: charts.TextStyleSpec(
            fontSize: 14,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickFormatterSpec:
              charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                  NumberFormat.compact()),
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            zeroBound: true,
            desiredTickCount: 6,
          ),
          renderSpec: new charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                fontSize: 13,
              ),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.black))),
    );
  }

  //ข้อมูล Chart Daily_Information_Usage
  List<charts.Series<dynamic, String>> _createSampleDataBar() {
    return [
      charts.Series<dynamic, String>(
        data: nowresult3,
        id: 'ปริมาณคงเหลือ',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(C[1]),
        domainFn: (dynamic nowresult, _) =>
            nowresult['n_day'] ??
            nowresult['${nowresult3[0].keys.elementAt(0)}'].toString(),
        measureFn: (dynamic nowresult, _) =>
            nowresult['${nowresult3[0].keys.elementAt(1)}'] ?? null,
      ),
      charts.Series<dynamic, String>(
        data: nowresult3,
        id: 'ปริมาณการกิน',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(C[2]),
        domainFn: (dynamic nowresult, _) =>
            nowresult['n_day'] ??
            nowresult['${nowresult3[0].keys.elementAt(0)}'].toString(),
        measureFn: (dynamic nowresult, _) =>
            nowresult['${nowresult3[0].keys.elementAt(2)}'] ?? null,
      ),
      charts.Series<dynamic, String>(
        data: nowresult3,
        id: 'ปริมาณการเติม',
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(C[3]),
        domainFn: (dynamic nowresult, _) =>
            nowresult['n_day'] ??
            nowresult['${nowresult3[0].keys.elementAt(0)}'].toString(),
        measureFn: (dynamic nowresult, _) =>
            nowresult['${nowresult3[0].keys.elementAt(3)}'] ?? null,
      ),
    ];
  }
}

// รูป %
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

    paint.color = Color(0xFF555555);
    paint.style = PaintingStyle.fill;
    var paint1 = new Paint();
    paint1.color = Color(0xFF48cb01);
    paint1.style = PaintingStyle.fill;

    if (S! > upper_percent!) {
      paint1.color = Color(0xFF9cc833);
    }
    if (S! <= lower_percent!) {
      paint1.color = Color(0xFFfe0000);
    }
    var path = new Path();
    path.moveTo(30, -0);
    path.lineTo(30, 70);
    path.lineTo(50, 100);
    path.lineTo(60, 100);
    path.lineTo(80, 70);
    path.lineTo(80, 0);
    path.lineTo(70, -10);
    path.lineTo(40, -10);
    path.close();
    var path1 = new Path();
    if (S! >= 100.0) {
      path1.moveTo(30, -0);
      path1.lineTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      path1.lineTo(80, 0);
      path1.lineTo(70, -10);
      path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 100.0 && S! >= 90.0) {
      path1.moveTo(30, -0);
      path1.lineTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      path1.lineTo(80, 0);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 90.0 && S! >= 80.0) {
      path1.moveTo(30, 10);
      path1.lineTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      path1.lineTo(80, 10);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 80.0 && S! >= 70.0) {
      path1.moveTo(30, 20);
      path1.lineTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      path1.lineTo(80, 20);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 70.0 && S! >= 60.0) {
      path1.moveTo(30, 27);
      path1.lineTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      path1.lineTo(80, 27);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 60.0 && S! >= 50.0) {
      path1.moveTo(30, 35);
      path1.lineTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      path1.lineTo(80, 35);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 50.0 && S! >= 40.0) {
      path1.moveTo(30, 45);
      path1.lineTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      path1.lineTo(80, 45);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 40.0 && S! >= 30.0) {
      path1.moveTo(30, 55);
      path1.lineTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      path1.lineTo(80, 55);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 30.0 && S! >= 20.0) {
      //  path1.moveTo(30, 55);
      path1.moveTo(30, 70);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(80, 70);
      // path1.lineTo(80, 55);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 20.0 && S! >= 10.0) {
      //  path1.moveTo(30, 62);
      path1.moveTo(40, 85);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(70, 85);
      // path1.lineTo(80, 62);
      // path1.lineTo(70, -10);
      // path1.lineTo(40, -10);
      path1.close();
    }
    if (S! < 10.0 && S! > 0) {
      //  path1.moveTo(30, 62);
      path1.moveTo(46.5, 95);
      path1.lineTo(50, 100);
      path1.lineTo(60, 100);
      path1.lineTo(63.5, 95);
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

// แสดงข้อมูลในกราฟแท่งแบบซ่อน
String? _title;
String? _subTitle;
String? _subTitle1;
String? _subTitle2;

class ToolTipMgr {
  static String? get title => _title;

  static String? get subTitle => _subTitle;
  static String? get subTitle1 => _subTitle1;
  static String? get subTitle2 => _subTitle2;

  static setTitle(Map<String, dynamic> data) {
    if (data['title'] != null) {
      _title = data['title'];
    }

    if (data['subTitle'] != null) {
      _subTitle = data['subTitle'];
    }
    if (data['subTitle1'] != null) {
      _subTitle1 = data['subTitle1'];
    }
    if (data['subTitle2'] != null) {
      _subTitle2 = data['subTitle2'];
    }
  }
}

String? unit1;
String? unit2;
String? unit3;

//การฟแท่ง // แสดงข้อมูลใน  Chart Daily_Information_Usage
class CustomCircleSymbolRenderer1 extends charts.CircleSymbolRenderer {
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      charts.Color? fillColor,
      charts.FillPatternType? fillPattern,
      charts.Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
      Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0, 10.0 + 65),
      fill: charts.Color.fromOther(
          color: charts.Color(a: 100, b: 0, g: 0, r: 0).darker),
    );

    chartStyle.TextStyle textStyle = chartStyle.TextStyle();

    textStyle.color = charts.Color.white;
    textStyle.fontSize = 13;

    canvas.drawText(
        chartText.TextElement('${ToolTipMgr.title}',
            textScaleFactor: 1.0, style: textStyle),
        (110 - 10.0 - 35).round(),
        (25.0 - 5).round());
    if (ToolTipMgr.subTitle == 'undefeated') {
      unit1 = 'undefeated';
    } else if (ToolTipMgr.subTitle != 'undefeated') {
      unit1 =
          '${NumberFormat.compact().format(double.parse('${ToolTipMgr.subTitle}'))}';
    }
    if (ToolTipMgr.subTitle1 == 'undefeated') {
      unit2 = 'undefeated';
    } else if (ToolTipMgr.subTitle1 != 'undefeated') {
      unit2 =
          '${NumberFormat.compact().format(double.parse('${ToolTipMgr.subTitle1}'))}';
    }
    if (ToolTipMgr.subTitle2 == 'undefeated') {
      unit3 = 'undefeated';
    } else if (ToolTipMgr.subTitle2 != 'undefeated') {
      unit3 =
          '${NumberFormat.compact().format(double.parse('${ToolTipMgr.subTitle2}'))}';
    }
    canvas.drawText(
        chartText.TextElement('ปริมาณคงเหลือ ' + '$unit1',
            textScaleFactor: 1.0, style: textStyle),
        (110 - 10.0 - 35).round(),
        (27.0 + 7).round());
    canvas.drawText(
        chartText.TextElement('ปริมาณการกิน ' + '$unit2',
            textScaleFactor: 1.0, style: textStyle),
        (110 - 10.0 - 35).round(),
        (42.0 + 7).round());
    canvas.drawText(
        chartText.TextElement('ปริมาณการเติม ' + '$unit3',
            textScaleFactor: 1.0, style: textStyle),
        (110 - 10.0 - 35).round(),
        (55.0 + 7).round());
  }
}

// แสดงข้อมูลในกราฟเส้นแบบซ่อน
List? selectedDatum;
String? unit1_;
String? unit2_;
int? samount2_;

//กราฟเส้นซ้อน // แสดงข้อมูลใน  Chart Plot_Graph
class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  final Size? size;
  late String? samount1;
  late String? samount2;
  late List<dynamic>? nowresult2_1;
  late List<dynamic>? nowresult2_2;
  List<dynamic>? amount1;
  List<dynamic>? amount2;
  late List<dynamic>? nowresult2;

  CustomCircleSymbolRenderer(
      {this.size,
      this.samount1,
      this.samount2,
      this.amount1,
      this.amount2,
      this.nowresult2_1,
      this.nowresult2_2,
      this.nowresult2});

  @override
  void paint(charts.ChartCanvas canvas, Rectangle bounds,
      {List<int>? dashPattern,
      charts.Color? fillColor,
      charts.FillPatternType? fillPattern,
      charts.Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(
      canvas,
      bounds,
      dashPattern: dashPattern,
      fillColor: fillColor,
      strokeColor: strokeColor,
      strokeWidthPx: strokeWidthPx,
    );

    Color? rectColor = Color.fromARGB(255, 236, 8, 8);
    List tooltips = selectedDatum!;

    num tipTextLen = (tooltips[0]['title']).length;
    num rectWidth = bounds.width + tipTextLen * 8.3;
    num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;

    num left = bounds.left > (size?.width ?? 300) / 4
        ? (bounds.left > size!.width / 4
            ? bounds.left - rectWidth
            : bounds.left - rectWidth / 2)
        : bounds.left - 40;

    if (samount2 == 'ไม่เลือกชุดข้อมูล' || samount2 == samount1) {
      samount2_ = 0;
    } else {
      samount2_ = nowresult2_2![0].keys.length;
    }
    if (samount2 == 'ไม่เลือกชุดข้อมูล' || samount2 == samount1) {
      if (left > 128.04594594594593) {
        canvas.drawRRect(
          Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
              bounds.height + 14 * nowresult2_1![0].keys.length),
          fill: charts.ColorUtil.fromDartColor(
              Color.fromARGB(255, 105, 105, 105)),
          radius: 10,
          roundTopLeft: true,
          roundTopRight: true,
          roundBottomLeft: true,
          roundBottomRight: true,
        );
        chartStyle.TextStyle textStyle = chartStyle.TextStyle();
        textStyle.color = charts.Color.white;
        textStyle.fontSize = 11;
        for (int j = 0; j < amount1!.length; j++) {
          if (samount1 == amount1![j]['name']) {
            canvas.drawText(
                chartText.TextElement(tooltips[0]['title'],
                    textScaleFactor: 1.0, style: textStyle),
                (110 - 10.0 - 35).round(),
                (25.0 - 5).round());
            for (int i = 1; i < nowresult2_1![0].keys.length; i++) {
              if (tooltips[0]['subTitle$i'] == 'undefeated') {
                unit2_ = 'undefeated';
              } else {
                unit2_ =
                    '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
              }
              canvas.drawText(
                  chartText.TextElement(
                      '${nowresult2_1![0].keys.elementAt(i)} : ' + '$unit2_',
                      textScaleFactor: 1.0,
                      style: textStyle),
                  (110 - 10.0 - 35).round(),
                  (13 + (i * 13) + 7).round());
            }
          }
        }
      }

      if (left < 128.04594594594593) {
        canvas.drawRRect(
          Rectangle(265.0 - 5.0 - 50, 15 - 0, 150 + 0,
              bounds.height + 14 * (nowresult2_1![0].keys.length + samount2_)),
          fill: charts.ColorUtil.fromDartColor(
              Color.fromARGB(255, 105, 105, 105)),
          radius: 10,
          roundTopLeft: true,
          roundTopRight: true,
          roundBottomLeft: true,
          roundBottomRight: true,
        );
        chartStyle.TextStyle textStyle = chartStyle.TextStyle();
        textStyle.color = charts.Color.white;
        textStyle.fontSize = 11;
        for (int j = 0; j < amount1!.length; j++) {
          if (samount1 == amount1![j]['name']) {
            canvas.drawText(
                chartText.TextElement(tooltips[0]['title'],
                    textScaleFactor: 1.0, style: textStyle),
                (265 - 10.0 - 35).round(),
                (25.0 - 5).round());

            for (int i = 1; i < nowresult2_1![0].keys.length; i++) {
              num Sn = 13 + (i * 13) + 7;
              if (tooltips[0]['subTitle$i'] == 'undefeated') {
                unit2_ = 'undefeated';
              } else {
                unit2_ =
                    '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
              }
              canvas.drawText(
                  chartText.TextElement(
                      '${nowresult2_1![0].keys.elementAt(i)} : ' + '$unit2_',
                      textScaleFactor: 1.0,
                      style: textStyle),
                  (265 - 10.0 - 35).round(),
                  (Sn).round());
            }

            //  if(samount2!=samount1){
            //       for(int j = 1;j<nowresult2_2![0].keys.length;j++){
            //    num Sn = 13+(j*13) + 7;
            //    if(tooltips[0]['text${j}${j}'] == 'undefeated'){
            //      unit1_ = 'undefeated';
            //    }
            //    else {
            //      unit1_ = '${NumberFormat.compact().format(double.parse('${tooltips[0]['text${j}${j}']}'))}';
            //    }
            //      canvas.drawText(chartText.TextElement('${nowresult2_2![0].keys.elementAt(j)} : '+'$unit1_', style: textStyle),  (265 - 10.0 - 35).round(),
            //       (52+(j*13) + 7).round());
            //    }}

          }
        }
      }
    }
    if (samount2 != 'ไม่เลือกชุดข้อมูล') {
      if (samount2 != samount1) {
        if (left > 128.04594594594593) {
          canvas.drawRRect(
            Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
                bounds.height + 14 * (nowresult2![0].keys.length + 0)),
            fill: charts.ColorUtil.fromDartColor(
                Color.fromARGB(255, 105, 105, 105)),
            radius: 10,
            roundTopLeft: true,
            roundTopRight: true,
            roundBottomLeft: true,
            roundBottomRight: true,
          );
          chartStyle.TextStyle textStyle = chartStyle.TextStyle();
          textStyle.color = charts.Color.white;
          textStyle.fontSize = 11;
          for (int j = 0; j < amount1!.length; j++) {
            if (samount2 == amount1![j]['name']) {
              canvas.drawText(
                  chartText.TextElement(tooltips[0]['title'],
                      textScaleFactor: 1.0, style: textStyle),
                  (110 - 10.0 - 35).round(),
                  (25.0 - 5).round());

              for (int i = 1; i < nowresult2![0].keys.length; i++) {
                if (tooltips[0]['subTitle$i'] == 'undefeated') {
                  unit2_ = 'undefeated';
                } else {
                  unit2_ =
                      '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
                }
                canvas.drawText(
                    chartText.TextElement(
                        '${nowresult2![0].keys.elementAt(i)} : ' + '$unit2_',
                        textScaleFactor: 1.0,
                        style: textStyle),
                    (110 - 10.0 - 35).round(),
                    (13 + (i * 13) + 7).round());
              }

              //  for (int i = 1; i < nowresult2_2![0].keys.length; i++) {
              //   if (tooltips[0]['subTitle1$i'] == 'undefeated') {
              //     unit2_ = 'undefeated';
              //   } else {
              //     unit2_ =
              //         '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle1$i']}'))}';
              //   }
              //   canvas.drawText(
              //       chartText.TextElement(
              //           '${nowresult2_2![0].keys.elementAt(i)} : ' + '$unit2_',
              //           style: textStyle),
              //       (110 - 10.0 - 35).round(),
              //       (52 + (i * 13) + 7).round());
              // }

            }
          }
        }

        if (left < 128.04594594594593) {
          canvas.drawRRect(
            Rectangle(265.0 - 5.0 - 50, 15 - 0, 150 + 0,
                bounds.height + 14 * (nowresult2![0].keys.length + 0)),
            fill: charts.ColorUtil.fromDartColor(
                Color.fromARGB(255, 105, 105, 105)),
            radius: 10,
            roundTopLeft: true,
            roundTopRight: true,
            roundBottomLeft: true,
            roundBottomRight: true,
          );
          chartStyle.TextStyle textStyle = chartStyle.TextStyle();
          textStyle.color = charts.Color.white;
          textStyle.fontSize = 11;
          for (int j = 0; j < amount1!.length; j++) {
            if (samount2 == amount1![j]['name']) {
              canvas.drawText(
                  chartText.TextElement(tooltips[0]['title'],
                      textScaleFactor: 1.0, style: textStyle),
                  (265 - 10.0 - 35).round(),
                  (25.0 - 5).round());

              for (int i = 1; i < nowresult2![0].keys.length; i++) {
                if (tooltips[0]['subTitle$i'] == 'undefeated') {
                  unit2_ = 'undefeated';
                } else {
                  unit2_ =
                      '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
                }
                canvas.drawText(
                    chartText.TextElement(
                        '${nowresult2![0].keys.elementAt(i)} : ' + '$unit2_',
                        textScaleFactor: 1.0,
                        style: textStyle),
                    (265 - 10.0 - 35).round(),
                    (13 + (i * 13) + 7).round());
              }
              //  for (int i = 1; i < nowresult2_2![0].keys.length; i++) {
              //   if (tooltips[0]['subTitle1$i'] == 'undefeated') {
              //     unit2_ = 'undefeated';
              //   } else {
              //     unit2_ =
              //         '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle1$i']}'))}';
              //   }
              //   canvas.drawText(
              //       chartText.TextElement(
              //           '${nowresult2_2![0].keys.elementAt(i)} : ' + '$unit2_',
              //           style: textStyle),
              //       (265 - 10.0 - 35).round(),
              //       (52 + (i * 13) + 7).round());
              // }
            }
          }
        }
      }
    }
  }
}
