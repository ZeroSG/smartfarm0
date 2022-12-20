import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:data_table_2/data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
import '../API_E_B/API_E.dart';
import '../BarMmodel.dart';
import 'package:charts_flutter/src/text_element.dart' as chartText;
import 'package:charts_flutter/src/text_style.dart' as chartStyle;

import 'package:http/http.dart' as http;

import '../downloadExcel/download.dart';
import 'Pie/Viewcharts.dart';
import 'Pie/Viewtable.dart';

class Weight extends StatefulWidget {
  String? Token;
  int? num;
  int? farmnum;
  String? HOUSE2;
  Weight({Key? key, this.Token, this.num, this.farmnum, this.HOUSE2})
      : super(key: key);

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  final List<dynamic> _products1 = List.generate(5, (i) {
    return {"id": "$i", "name": "$i", "price": "$i"};
  });

  late TextEditingController n_size_s_min = TextEditingController();
  late TextEditingController n_size_s_max = TextEditingController();
  late TextEditingController n_size_m_min = TextEditingController();
  late TextEditingController n_size_m_max = TextEditingController();
  late TextEditingController n_size_l_min = TextEditingController();
  late TextEditingController n_size_l_max = TextEditingController();
  late TextEditingController n_per_yield = TextEditingController();
  late TextEditingController n_per_loss = TextEditingController();

  late double screenW, screenH;
  List<dynamic> _selectedAnimals2 = [];

  UniqueKey? K0;
  UniqueKey? K1;
  UniqueKey? K2;
  UniqueKey? K3;
  UniqueKey? K4;
  UniqueKey? K5;
  UniqueKey? K6;
  int selected2 = 6;
  bool loading0 = true;
  bool loading1 = true;
  bool loading2 = true;
  bool loading3 = true;
  bool loading4 = true;
  bool loading5 = true;
  bool loading6 = true;
  String? dat1 = '00:00:00.000', dat2 = '23:59:59.000';
  String name = 'ALL';
  late double Check = 0;
  bool? Check1 = true;
  List<dynamic> nowresult0_1 = [];
  List<dynamic> nowresult0_2 = [];
  late int? ALL;

  String? form = 'Non specified';
  String? day = 'Non specified';
  String? Start = 'Non specified';
  String? End = 'Non specified';
  Future<void> getjaon0_1_weight_information() async {
    try {
      loading0 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/weight-info");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "House": widget.num,
            "Date":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day}"
          }));
      if (ressum.statusCode == 200) {
        print(json.decode(ressum.body)['result']['view2']);
        var result0_1 = json.decode(ressum.body)['result']['view1'];
        var result0_2 = json.decode(ressum.body)['result']['view2'];
        // print('fdfd${result0_1}');

        if (result0_1 != null) {
          DateTime Date_Start = DateTime.parse(result0_1[0]['c_datestart']);
          DateTime Date_End = DateTime.parse(result0_1[0]['c_dateend']);

          setState(() {
            nowresult0_2 = result0_2;

            form = '${result0_1[0]['c_feedtype']}';
            day = '${result0_1[0]['n_age']}';
            Start = '${Date_Start.day}/${Date_Start.month}/${Date_Start.year}';
            End = '${Date_End.day}/${Date_End.month}/${Date_End.year}';

            loading0 = false;
          });
        }
        if (result0_1 == null) {
          loading1 = true;
          setState(() {
            nowresult0_2 = result0_2;
            form = 'Non specified';
            day = 'Non specified';
            Start = 'Non specified';
            End = 'Non specified';
            loading0 = false;
          });
        }

        // setState(() {

        //   nowresult0_1 = result0_1;

        //   loading1 = false;
        // });
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  List<dynamic> nowresult1_1 = [];
  Future<void> getjaon1_weight_device() async {
    try {
      loading1 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/weight-device");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "House": widget.num,
            "Date_Start":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat1",
            "Date_End":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2"
            //                  "Farm": 17,
            // "House": 145,
            // "Date_Start": "2022-09-06 00:00:00.000",
            // "Date_End": "2022-09-06 23:59:59.000"
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
    } catch (e) {
      //print(e.toString());
    }
  }

  List<dynamic> nowresult2_1 = [];

  Future<void> getjaon2_weight_average_hourly() async {
    try {
      loading2 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/weight-hourly");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "House": widget.num,
            "Device": name,
            "Date_Start":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat1",
            "Date_End":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2"
            // "Farm": 17,
            // "House": 145,
            // "Device": "ALL",
            // "Date_Start": "2022-09-06 00:00:00.000",
            // "Date_End": "2022-09-06 23:59:59.000"
          }));
      if (ressum.statusCode == 200) {
        var result2_1 = json.decode(ressum.body)['result']['view1'];

        setState(() {
          nowresult2_1 = result2_1;
          loading2 = false;
        });
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  late List<String> uniquelist2 = [];
  List<dynamic> nowresult3_1 = [];
  List<dynamic> nowresult3_2 = [];
  List<dynamic> nowresult3_3 = [];
  List<dynamic> nowresult3_4 = [];

  Future<void> getjaon3_weight_results() async {
    try {
      loading3 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/weight-result");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "House": widget.num,
            "Date_Start":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat1",
            "Date_End":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2"
            //             "Farm": 17,
            // "House": 145,
            // "Date_Start": "2022-09-06 00:00:00.000",
            // "Date_End": "2022-09-06 23:59:59.000"
          }));
      if (ressum.statusCode == 200) {
        print('object');
        var result3_1 = json.decode(ressum.body)['result']['view1'];
        var result3_2 = json.decode(ressum.body)['result']['view2'];
        var result3_3 = json.decode(ressum.body)['result']['view3'];
        var result3_4 = json.decode(ressum.body)['result']['view4'];

        // print('nowresult1_ =====> $result3_1');
        //    print('nowresult2_ =====> $result3_2');
        // print('nowresult3_ =====> $result3_3');
        // print('nowresult4_ =====> $result3_4');
        //  print('nowresult4_ =====> ${nowresult1_1.length}');

        for (int i = 0; i < nowresult1_1.length; i++) {
          if (nowresult1_1[i]["count_data"] != null) {
            setState(() {
              uniquelist2 += [nowresult1_1[i]["device"]];
              // uniquelist2.insert(i, nowresult1_1[i]["device"]);
            });
          }
        }
        print('nowresult4_ =====> ${uniquelist2}');
        List<dynamic> nowresult3_211 = result3_1
            .map((e) => {
                  '${result3_1[0].keys.elementAt(0)}':
                      e['${result3_4[0].keys.elementAt(0)}'],
                  for (int i = 0; i < uniquelist2.length; i++)
                    '${result3_1[0].keys.elementAt(1)}${i + 1}': result3_1
                            .where((e) => e['device'] == uniquelist2[i])
                            .first['${result3_1[0].keys.elementAt(1)}'] ??
                        null,
                })
            .toList();

        List<dynamic> nowresult3_212 = result3_2
            .map((e) => {
                  '${result3_2[0].keys.elementAt(0)}':
                      e['${result3_4[0].keys.elementAt(0)}'],
                  for (int i = 0; i < uniquelist2.length; i++)
                    '${result3_2[0].keys.elementAt(1)}${i + 1}': result3_2
                            .where((e) => e['device'] == uniquelist2[i])
                            .first['${result3_2[0].keys.elementAt(1)}'] ??
                        null,
                })
            .toList();

        List<dynamic> nowresult3_213 = result3_3
            .map((e) => {
                  '${result3_3[0].keys.elementAt(0)}':
                      e['${result3_4[0].keys.elementAt(0)}'],
                  for (int i = 0; i < uniquelist2.length; i++)
                    '${result3_3[0].keys.elementAt(1)}${i + 1}': result3_3
                            .where((e) => e['device'] == uniquelist2[i])
                            .first['${result3_3[0].keys.elementAt(1)}'] ??
                        null,
                })
            .toList();

        List<dynamic> nowresult3_214 = result3_4
            .map((e) => {
                  '${result3_4[0].keys.elementAt(0)}':
                      e['${result3_4[0].keys.elementAt(0)}'],
                  for (int i = 0; i < uniquelist2.length; i++)
                    '${result3_4[0].keys.elementAt(1)}${i + 1}': result3_4
                            .where((e) => e['device'] == uniquelist2[i])
                            .first['${result3_4[0].keys.elementAt(1)}'] ??
                        null,
                })
            .toList();

        List<dynamic> nowresult3_41_ =
            nowresult3_211.where((x) => x['device'] == 'ALL').toList();
        List<dynamic> nowresult3_42_ =
            nowresult3_212.where((x) => x['device'] == 'ALL').toList();
        List<dynamic> nowresult3_43_ =
            nowresult3_213.where((x) => x['device'] == 'ALL').toList();
        List<dynamic> nowresult3_44_ =
            nowresult3_214.where((x) => x['device'] == 'ALL').toList();

        // List<dynamic>   nowresult3_214 = result3_4.map((e) => {
        //  '${result3_4[0].keys.elementAt(0)}' : 'ALL',
        //  '${result3_4[0].keys.elementAt(1)}' : e['${result3_4[0].keys.elementAt(1)}']?? null,
        // }).toList();

        setState(() {
          uniquelist2 = [];
          nowresult3_1 = nowresult3_41_;
          nowresult3_2 = nowresult3_42_;
          nowresult3_3 = nowresult3_43_;
          nowresult3_4 = nowresult3_44_;
          loading3 = false;
        });
        print('nowresult1_ =====> $nowresult3_1');
        print('nowresult2_ =====> $nowresult3_2');
        print('nowresult3_ =====> $nowresult3_3');
        print('nowresult4_ =====> $nowresult3_4');
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  List<dynamic> nowresult4_1 = [];
  String? null1;
  Future<void> getjaon4_weight_per_unit() async {
    try {
      loading4 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/weight-unit");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "House": widget.num,
            "Date_Start":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat1",
            "Date_End":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2"

            // "Farm": 17,
            // "House": 145,
            // "Date_Start": "2022-09-06 00:00:00.000",
            // "Date_End": "2022-09-06 23:59:59.000"
          }));
      if (ressum.statusCode == 200) {
        var result4_1 = json.decode(ressum.body)['result']['view1'];

        setState(() {
          nowresult4_1 = result4_1;
          loading4 = false;
        });

        if (sPlot == 'แสดงถึงวันปัจจุบัน') {
          DateTime? dateTime1_ = DateTime.now();
          // print('nowresult2_1 ${nowresult2_1}');
          List<dynamic> _products1 = [];
          for (int i = 0; i < nowresult4_1.length; i++) {
            var splitted = nowresult4_1[i]
                    ['${nowresult4_1[i].keys.elementAt(0)}']
                .split('(')
                .first;
            var splitted1 = splitted.split('-');
            //  print('_products2 20${splitted1[2]}');
            if (int.parse("20${splitted1[2]}") < dateTime1_.year) {
              _products1 += [nowresult4_1[i]];
              //  print('_products2 ${splitted1[2]}');
            }
            if ((int.parse(splitted1[1]) < dateTime1_.month - 3) &&
                (int.parse("20${splitted1[2]}") == dateTime1_.year)) {
              _products1 += [nowresult4_1[i]];
            }
            if ((int.parse(splitted1[0]) <= dateTime1_.day &&
                int.parse(splitted1[1]) == dateTime1_.month - 3)) {
              _products1 += [nowresult4_1[i]];
            }
          }
          print('_products1 ${_products1}');

          setState(() {
            nowresult4_1 = _products1;
          });
        }
        //  //print('object =====> ${nowresult4_1}');
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      if (e.toString() == "Exception: Failed to download") {
        setState(() {
          null1 = "ไม่มีค่า";
          loading4 = true;
        });
      }
    }
  }

  late List<String> nowresult5__ = [];
  List<dynamic> nowresult5_1 = [];
  late List<String> uniquelist1 = [];
  List<dynamic> nowresult5_11 = [];
  List<dynamic> nowresult5_12 = [];
  List<dynamic> nowresult5_13 = [];
  List<dynamic> nowresult5_14 = [];
  List<dynamic> nowresult5_15 = [];
  List<dynamic> nowresult5_16 = [];
  List<dynamic> nowresult5_17 = [];
  List<dynamic> nowresult5_18 = [];
  List<dynamic> nowresult5_19 = [];
  List<dynamic> nowresult5_110 = [];
  List<dynamic> nowresult5_111 = [];
  List<dynamic> nowresult5_112 = [];
  List<dynamic> nowresult5_113 = [];
  List<dynamic> nowresult5_114 = [];
  List<dynamic> nowresult5_115 = [];
  List<dynamic> nowresult5_116 = [];

  var largestGeekValue;

  Future<void> getjaon5_weight_distribution_rate() async {
    try {
      loading5 = true;
      var urlsum =
          Uri.https("smartfarmpro.com", "/v1/api/house/weight-distribution");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "House": widget.num,
            "Date_Start":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat1",
            "Date_End":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2"
            //             "Farm": 17,
            // "House": 145,
            // "Date_Start": "2022-09-06 00:00:00.000",
            // "Date_End": "2022-09-06 23:59:59.000"
          }));
      if (ressum.statusCode == 200) {
        var result5_1 = json.decode(ressum.body)['result']['view1'];
        // print('result5_1 =====> $result5_1');

        // var over21s = result5_1.where((result5_1) => result5_1['c_device'] =='132600468794188');
        //   print('over21s   ========>$over21s');

        setState(() {
          uniquelist1 = [];
          nowresult5_11 = [];
          nowresult5_12 = [];
          nowresult5_13 = [];
          nowresult5_14 == [];
          nowresult5_15 = [];
          nowresult5_16 = [];
          nowresult5_1 = result5_1;
          loading5 = false;
        });
        var largestGeekValue1 = nowresult5_1[0]['n_normdst'];

        for (int i = 0; i < nowresult5_1.length; i++) {
          if (nowresult5_1[i]['n_normdst'] > largestGeekValue1) {
            largestGeekValue1 = nowresult5_1[i]['n_normdst'];
          }
        }
        setState(() {
          largestGeekValue = largestGeekValue1;
        });
        //       List<dynamic>   nowresult5_ = nowresult5_1.map((e) => {

        // //  for (int f = 0; f < result5_1.length; f++)
        //   for (int i = 1; i < nowresult5_1[0].keys.length; i++)
        //   '${nowresult5_1[0].keys.elementAt(i)}' : nowresult5_1.where((x) => x['c_device']  == 'ALL'),//e['${result5_1[0].keys.elementAt(i)}'],
        //          }).toList();
        // List<dynamic> nowresult5__1 = nowresult5_1.where((country) => (country['c_device'])).toList();

        for (int i = 0; i < nowresult1_1.length; i++) {
          if (nowresult1_1[i]["count_data"] != null) {
            setState(() {
              //  print('nowresult5_1====${nowresult1_1[i]["device"]}');
              uniquelist1 += [nowresult1_1[i]["device"]];
              // uniquelist1.insert(i, nowresult1_1[i]["device"]);
            });
          }
        }

        for (int i = 0; i < nowresult5_1.length; i++) {
          if (nowresult5_1[i]['c_device'] == nowresult5_1[0]['c_device']) {
            setState(() {
              //  print('nowresult5_1====${nowresult5_1[i]["c_device"]}');
              nowresult5__ += [nowresult5_1[i]["c_device"]];
              // uniquelist1.insert(i, nowresult1_1[i]["device"]);
            });
            // nowresult5__ += nowresult5_1[i]['c_device'];
          }
        }
        // print('nowresult5_====${nowresult5__}');
        List<dynamic> color = [
          for (int i = 0; i < uniquelist1.length; i++)
            {
              'c_device': uniquelist1[i],
              'color': C1[i],
              'color1': C2[i],
            },
        ];
        List<dynamic> nowresult51_ = [],
            nowresult52_ = [],
            nowresult53_ = [],
            nowresult54_ = [],
            nowresult55_ = [],
            nowresult56_ = [];
        List<dynamic> nowresult57_ = [],
            nowresult58_ = [],
            nowresult59_ = [],
            nowresult510_ = [],
            nowresult511_ = [],
            nowresult512_ = [];
        List<dynamic> nowresult513_ = [],
            nowresult514_ = [],
            nowresult515_ = [],
            nowresult516_ = [];

        List<List<dynamic>> da1 = [
          nowresult51_,
          nowresult52_,
          nowresult53_,
          nowresult54_,
          nowresult55_,
          nowresult56_,
          nowresult57_,
          nowresult58_,
          nowresult59_,
          nowresult510_,
          nowresult511_,
          nowresult512_,
          nowresult513_,
          nowresult514_,
          nowresult515_,
          nowresult516_
        ];
        //   //print('da1 === ${da1.length}');
        //   //print('C1 === ${C1.length}');
        //   //print('C2 === ${C2.length}');

        //     for(int i=0;i<uniquelist1.length;i++){
        //       da1[i]= nowresult5_1.where((x) => x['c_device']  == uniquelist1[i]).toList();

        //            setState(() {
        //        nowresult51_ =da1[0];
        //         da[1] =da1[1];
        //          da[2] =da1[2];
        //           da[3] =da1[3];
        //  });
        //     }
        //      //print('da1 === ${da[1]}');

        //       List<dynamic>   nowresult5_ =nowresult5_1.map((e) => {
        //         for (int i = 0; i < nowresult5_1[0].keys.length; i++)
        //   '${nowresult5_1[0].keys.elementAt(i)}' : e['${nowresult5_1[0].keys.elementAt(i)}'],
        //   'color' : color.where((element) => element['c_device'].toString().compareTo(e['c_device'].toString()) == 0).first['color']?? null,
        //   'color1' : color.where((element) => element['c_device'].toString().compareTo(e['c_device'].toString()) == 0).first['color1']?? null,

        //          }).toList();
        //          List<dynamic>   nowresult51_ = nowresult5_1.where((x) => x['c_device']  == uniquelist1[0]).toList();
        //         List<dynamic>   nowresult52_ = nowresult5_1.where((x) => x['c_device']  == uniquelist1[1]).toList();
        //         List<dynamic>   nowresult53_ = nowresult5_1.where((x) => x['c_device']  == uniquelist1[2]).toList();
        //              setState(() {
        //      nowresult5_11 =nowresult51_;
        //      nowresult5_12 =nowresult52_;
        //      nowresult5_13 =nowresult53_;
        //    });
        //  List da = [nowresult5_11,nowresult5_12,nowresult5_13];

        //         List<dynamic>   nowresult35_ =nowresult5_.map((e) => {
        //       // for (int i = 0; i < nowresult5_[0].keys.length; i++)
        // '${nowresult5_1[0].keys.elementAt(0)}' : e['${nowresult5_1[0].keys.elementAt(0)}'],
        // for (int i = 0; i < uniquelist1.length; i++)
        // 'n_weight$i' : da[i].where((element) => element['c_device'].toString().compareTo(e['c_device'].toString()) == 0).first['n_weight']?? null,
        // for (int i = 0; i < uniquelist1.length; i++)
        //  'n_normdst$i' : da[i].where((element) => element['c_device'].toString().compareTo(e['c_device'].toString()) == 0).first['n_normdst']?? null,
        // 'color' : e['color'],
        // 'color1' : e['color1'],

        //        }).toList();
        //          //print('nowresult5_====$nowresult5_11');
        //  setState(() {
        //    nowresult5_11 =nowresult5_;
        //  });
        // // //print('nowresult5_====$nowresult5_11');

        if (uniquelist1.length == 1) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();

          setState(() {
            nowresult5_11 = nowresult51_;
          });
        }
        if (uniquelist1.length == 2) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
          });
        } else if (uniquelist1.length == 3) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();

          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
          });
        } else if (uniquelist1.length == 4) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
          });
        } else if (uniquelist1.length == 5) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
          });
        } else if (uniquelist1.length == 6) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
          });
        } else if (uniquelist1.length == 7) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
          });
        } else if (uniquelist1.length == 8) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
          });
        } else if (uniquelist1.length == 9) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          nowresult59_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[8])
              .toList();
          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
            nowresult5_19 = nowresult59_;
          });
        } else if (uniquelist1.length == 10) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          nowresult59_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[8])
              .toList();
          nowresult510_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[9])
              .toList();
          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
            nowresult5_19 = nowresult59_;
            nowresult5_110 = nowresult510_;
          });
        } else if (uniquelist1.length == 11) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          nowresult59_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[8])
              .toList();
          nowresult510_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[9])
              .toList();
          nowresult511_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[10])
              .toList();

          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
            nowresult5_19 = nowresult59_;
            nowresult5_110 = nowresult510_;
            nowresult5_111 = nowresult511_;
          });
        } else if (uniquelist1.length == 12) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          nowresult59_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[8])
              .toList();
          nowresult510_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[9])
              .toList();
          nowresult511_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[10])
              .toList();
          nowresult512_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[11])
              .toList();

          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
            nowresult5_19 = nowresult59_;
            nowresult5_110 = nowresult510_;
            nowresult5_111 = nowresult511_;
            nowresult5_112 = nowresult512_;
          });
        } else if (uniquelist1.length == 13) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          nowresult59_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[8])
              .toList();
          nowresult510_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[9])
              .toList();
          nowresult511_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[10])
              .toList();
          nowresult512_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[11])
              .toList();
          nowresult513_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[12])
              .toList();

          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
            nowresult5_19 = nowresult59_;
            nowresult5_110 = nowresult510_;
            nowresult5_111 = nowresult511_;
            nowresult5_112 = nowresult512_;
            nowresult5_113 = nowresult513_;
          });
        } else if (uniquelist1.length == 14) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          nowresult59_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[8])
              .toList();
          nowresult510_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[9])
              .toList();
          nowresult511_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[10])
              .toList();
          nowresult512_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[11])
              .toList();
          nowresult513_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[12])
              .toList();
          nowresult514_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[13])
              .toList();

          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
            nowresult5_19 = nowresult59_;
            nowresult5_110 = nowresult510_;
            nowresult5_111 = nowresult511_;
            nowresult5_112 = nowresult512_;
            nowresult5_113 = nowresult513_;
            nowresult5_114 = nowresult514_;
          });
        } else if (uniquelist1.length == 15) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          nowresult59_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[8])
              .toList();
          nowresult510_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[9])
              .toList();
          nowresult511_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[10])
              .toList();
          nowresult512_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[11])
              .toList();
          nowresult513_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[12])
              .toList();
          nowresult514_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[13])
              .toList();
          nowresult515_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[14])
              .toList();

          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
            nowresult5_19 = nowresult59_;
            nowresult5_110 = nowresult510_;
            nowresult5_111 = nowresult511_;
            nowresult5_112 = nowresult512_;
            nowresult5_113 = nowresult513_;
            nowresult5_114 = nowresult514_;
            nowresult5_115 = nowresult515_;
          });
        } else if (uniquelist1.length == 16) {
          nowresult51_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[0])
              .toList();
          nowresult52_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[1])
              .toList();
          nowresult53_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[2])
              .toList();
          nowresult54_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[3])
              .toList();
          nowresult55_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[4])
              .toList();
          nowresult56_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[5])
              .toList();
          nowresult57_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[6])
              .toList();
          nowresult58_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[7])
              .toList();
          nowresult59_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[8])
              .toList();
          nowresult510_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[9])
              .toList();
          nowresult511_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[10])
              .toList();
          nowresult512_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[11])
              .toList();
          nowresult513_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[12])
              .toList();
          nowresult514_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[13])
              .toList();
          nowresult515_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[14])
              .toList();
          nowresult516_ = nowresult5_1
              .where((x) => x['c_device'] == uniquelist1[15])
              .toList();

          setState(() {
            nowresult5_11 = nowresult51_;
            nowresult5_12 = nowresult52_;
            nowresult5_13 = nowresult53_;
            nowresult5_14 = nowresult54_;
            nowresult5_15 = nowresult55_;
            nowresult5_16 = nowresult56_;
            nowresult5_17 = nowresult57_;
            nowresult5_18 = nowresult58_;
            nowresult5_19 = nowresult59_;
            nowresult5_110 = nowresult510_;
            nowresult5_111 = nowresult511_;
            nowresult5_112 = nowresult512_;
            nowresult5_113 = nowresult513_;
            nowresult5_114 = nowresult514_;
            nowresult5_115 = nowresult515_;
            nowresult5_116 = nowresult516_;
          });
        }
        // List<dynamic>   nowresult5_ = nowresult5_1.where((x) => x['c_device']  == uniquelist1[0]).toList();
        //      //print('nowresult5_ =====> ${nowresult5_.length}');
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  List<dynamic> nowresult6_1 = [];
  Future<void> getjaon6_weight_estimate_size() async {
    try {
      loading6 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/house/weight-size");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            "House": widget.num,
            "Date_Start":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat1",
            "Date_End":
                "${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2",
            "Date_Process":
                "${dateTime_!.year}-${dateTime_!.month}-${dateTime_!.day}"
            // "Farm": 5,
            // "House": 82,
            // "Date_Start": "2022-04-26 00:00:00",
            // "Date_End": "2022-04-26 23:59:59",
            // "Date_Process": "2022-12-12"
          }));
      if (ressum.statusCode == 200) {
        var result6_1 = json.decode(ressum.body)['result']['view1'];
        print(result6_1);
        print(widget.num);

        print(
          "${dateTime_!.year}-${dateTime_!.month}-${dateTime_!.day} 00:00:00",
        );
        setState(() {
          nowresult6_1 = result6_1;
          loading6 = false;
        });

        //  //print('object =====> ${nowresult6_1}');
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  var size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getjaon0_1_weight_information();
    getjaon1_weight_device();
    getjaon2_weight_average_hourly();
    getjaon3_weight_results();
    getjaon5_weight_distribution_rate();
    getjaon4_weight_per_unit();
    getjaon6_weight_estimate_size();
  }

  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color.fromARGB(255, 194, 194, 194),
                          width: screenW * 0.005),
                      color: Color.fromARGB(255, 235, 235, 235)),
                  height: 40,
                  width: screenW * 0.3,
                  child: TextButton(
                    onPressed: () {
                      chooseDate1();
                    },
                    child: Text(
                      '${dateTime1_!.day}-${dateTime1_!.month}-${dateTime1_!.year}',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
            Card(child: build0(context)),
            Card(child: build1(context)),
            Card(child: build2(context)),
            Card(child: build3(context)),
            Card(child: build4(context)),
            Card(child: build5(context)),
            // // build6(context),
            Card(child: build6(context)),
          ],
        ),
      ),
    );
  }

  late List<dynamic>? PoultryWeight = ['All', 'Up', 'Down'];
  late String? PoultryWeightname = 'All';

  Future<dynamic> DialogStandard(
    BuildContext context,
  ) {
    print(nowresult0_2);
    if (nowresult0_2 == null) {
      EndE = '$hourE:$minuteE';
      EndS = '$hourS:$minuteS';
      PoultryWeightname = 'All';
      ALL = 0;
      n_size_s_min.text = '0';
      n_size_s_max.text = '0';
      n_size_m_min.text = '0';
      n_size_m_max.text = '0';
      n_size_l_min.text = '0';
      n_size_l_max.text = '0';
      n_per_yield.text = '0';
      n_per_loss.text = '0';
    } else {
      EndE = nowresult0_2[0]['c_period_end'];
      EndS = nowresult0_2[0]['c_period_strat'];
      if (nowresult0_2[0]['c_poultry'] == 0) {
        ALL = 0;
        PoultryWeightname = 'All';
      } else if (nowresult0_2[0]['c_poultry'] == 2) {
        PoultryWeightname = 'Down';
        ALL = 1;
      } else if (nowresult0_2[0]['c_poultry'] == 1) {
        ALL = 2;
        PoultryWeightname = 'Up';
      } else {
        PoultryWeightname = 'All';
        ALL = 0;
      }
      n_size_s_min.text = '${nowresult0_2[0]['n_size_s_min']}';
      n_size_s_max.text = '${nowresult0_2[0]['n_size_s_max']}';
      n_size_m_min.text = '${nowresult0_2[0]['n_size_m_min']}';
      n_size_m_max.text = '${nowresult0_2[0]['n_size_m_max']}';
      n_size_l_min.text = '${nowresult0_2[0]['n_size_l_min']}';
      n_size_l_max.text = '${nowresult0_2[0]['n_size_l_max']}';
      n_per_yield.text = '${nowresult0_2[0]['n_per_yield']}';
      n_per_loss.text = '${nowresult0_2[0]['n_per_loss']}';
    }
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
                height: 500,
                width: screenW * 1,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 15, left: 10),
                              height: screenH * 0.04,
                              child: Text(
                                'Setting Weight Device',
                                style: TextStyle(
                                    fontSize: 16,
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
                      PoultryWeight1(setState),
                      time2(setState),
                      Size3(setState),
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

  Container Size3(StateSetter setState) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(children: [
              Container(
                width: screenW * 0.74,
                child: Text(
                  'Set Weight Size (gram):',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Color.fromARGB(255, 25, 25, 25),
                  ),
                ),
              ),
              Size_S1(setState),
              Size_M2(setState),
              Size_L3(setState),
              Yield_Loss4(setState),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  height: 35,
                  width: screenW * 0.715,
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
                      if (nowresult0_2 == null) {
                        Navigator.pop(context);
                      } else {
                        API_edit_weight_setting(
                            widget.Token,
                            widget.farmnum,
                            widget.num,
                            ALL,
                            EndS,
                            EndE,
                            double.parse(n_size_s_min.text),
                            double.parse(n_size_m_min.text),
                            double.parse(n_size_m_max.text),
                            double.parse(n_size_l_max.text),
                            double.parse(n_per_yield.text),
                            double.parse(n_per_loss.text));

                        var duration = Duration(seconds: 1);
                        Timer(duration, () {
                          // Navigator.pop(context);
                          getjaon0_1_weight_information();
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text(
                      'Save Size',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container Yield_Loss4(StateSetter setState) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenW * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              width: screenW * 0.30,
              child: Text(
                '% Yield :',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Color.fromARGB(255, 25, 25, 25),
                ),
              ),
            ),
            Container(
              width: screenW * 0.30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xffcfcfcf), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    height: 40,
                    width: screenW * 0.30,
                    child: TextField(
                      controller: n_per_yield,
                      keyboardType: TextInputType.number,
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
                  ),
                ],
              ),
            )
          ]),
          Column(children: [
            Container(
              width: screenW * 0.30,
              child: Text(
                '% Loss :',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Color.fromARGB(255, 25, 25, 25),
                ),
              ),
            ),
            Container(
              width: screenW * 0.30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xffcfcfcf), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    height: 40,
                    width: screenW * 0.30,
                    child: TextField(
                      controller: n_per_loss,
                      keyboardType: TextInputType.number,
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
                  ),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }

  Container Size_L3(StateSetter setState) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(children: [
        Container(
          width: screenW * 0.75,
          child: Text(
            'Size L :',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Color.fromARGB(255, 25, 25, 25),
            ),
          ),
        ),
        Container(
          width: screenW * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
                ),
                height: 40,
                width: screenW * 0.30,
                child: TextField(
                  readOnly: true,
                  controller: n_size_m_max,
                  keyboardType: TextInputType.number,
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
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.white,
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //         color: Color(0xffcfcfcf),
                  //         width: 1.5),
                  //     borderRadius:
                  //         BorderRadius.circular(5),
                  //     color: Colors.white),
                  height: 40,
                  width: screenW * 0.05,
                  child: Center(
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                height: 40,
                width: screenW * 0.30,
                child: TextField(
                  controller: n_size_l_max,
                  keyboardType: TextInputType.number,
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
              ),
            ],
          ),
        )
      ]),
    );
  }

  Container Size_M2(StateSetter setState) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(children: [
        Container(
          width: screenW * 0.75,
          child: Text(
            'Size M :',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Color.fromARGB(255, 25, 25, 25),
            ),
          ),
        ),
        Container(
          width: screenW * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                height: 40,
                width: screenW * 0.30,
                child: TextField(
                  controller: n_size_m_min,
                  keyboardType: TextInputType.number,
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
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.white,
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //         color: Color(0xffcfcfcf),
                  //         width: 1.5),
                  //     borderRadius:
                  //         BorderRadius.circular(5),
                  //     color: Colors.white),
                  height: 40,
                  width: screenW * 0.05,
                  child: Center(
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                height: 40,
                width: screenW * 0.30,
                child: TextField(
                  controller: n_size_m_max,
                  keyboardType: TextInputType.number,
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
              ),
            ],
          ),
        )
      ]),
    );
  }

  Container Size_S1(StateSetter setState) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(children: [
        Container(
          width: screenW * 0.75,
          child: Text(
            'Size S :',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Color.fromARGB(255, 25, 25, 25),
            ),
          ),
        ),
        Container(
          width: screenW * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                height: 40,
                width: screenW * 0.30,
                child: TextField(
                  controller: n_size_s_min,
                  keyboardType: TextInputType.number,
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
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.white,
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //         color: Color(0xffcfcfcf),
                  //         width: 1.5),
                  //     borderRadius:
                  //         BorderRadius.circular(5),
                  //     color: Colors.white),
                  height: 40,
                  width: screenW * 0.05,
                  child: Center(
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
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
                width: screenW * 0.30,
                child: TextField(
                  readOnly: true,
                  controller: n_size_m_min,
                  keyboardType: TextInputType.number,
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
              ),
            ],
          ),
        )
      ]),
    );
  }

  TimeOfDay timeS = TimeOfDay(hour: 06, minute: 0);
  TimeOfDay timeE = TimeOfDay(hour: 18, minute: 0);
  late var hourS = timeS.hour.toString().padLeft(2, '0');
  late var minuteS = timeS.minute.toString().padLeft(2, '0');
  late var hourE = timeE.hour.toString().padLeft(2, '0');
  late var minuteE = timeE.minute.toString().padLeft(2, '0');
  late String EndE;
  late String EndS;

  Future<void> time0S(StateSetter setState) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: timeS,
    );
    setState(() {
      timeS = newtime!;
      hourS = newtime.hour.toString().padLeft(2, '0');
      minuteS = newtime.minute.toString().padLeft(2, '0');
      EndS = '$hourS:$minuteS';
    });
  }

  Future<void> time0E(StateSetter setState) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: timeE,
    );
    setState(() {
      timeE = newtime!;
      hourE = newtime.hour.toString().padLeft(2, '0');
      minuteE = newtime.minute.toString().padLeft(2, '0');
      EndE = '$hourE:$minuteE';
    });
  }

  Container time2(StateSetter setState) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(children: [
              Container(
                width: screenW * 0.75,
                child: Text(
                  'Set Weight Resulte By Period (00:00-00:00):',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Color.fromARGB(255, 25, 25, 25),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: screenW * 0.75,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () {
                      time0S(setState);
                    },
                    child: Container(
                      width: screenW * 0.30,
                      height: 40,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xffcfcfcf), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          EndS,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 25, 25, 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenW * 0.10,
                  height: 40,
                  child: Center(
                    child: Text(
                      'to',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 25, 25, 25),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      time0E(setState);
                    },
                    child: Container(
                      width: screenW * 0.30,
                      height: 40,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xffcfcfcf), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          EndE,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 25, 25, 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container PoultryWeight1(StateSetter setState) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(children: [
              Container(
                width: screenW * 0.75,
                child: Text(
                  'Set PoultryWeight :',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Color.fromARGB(255, 25, 25, 25),
                  ),
                ),
              ),
              Center(
                  child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 40,
                width: screenW * 0.75,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          value: PoultryWeightname,
                          items: PoultryWeight!
                              .map((PoultryWeight) => DropdownMenuItem<String>(
                                  value: PoultryWeight,
                                  child: Text(
                                    PoultryWeight,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                    ),
                                  )))
                              .toList(),
                          onChanged: (PoultryWeight) {
                            setState(() {
                              PoultryWeightname = PoultryWeight!;
                            });
                          }),
                    ),
                  ),
                ),
              )),
            ]),
          ),
        ],
      ),
    );
  }

  bool Download0 = false;
  Widget build0(BuildContext context) => ExpansionTile(
        key: K0,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Download0 = true;
              Duration(seconds: 1000);
              selected2 = 6;
              K1 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          } else {
            setState(() {
              Download0 = false;

              Download2 = true;

              Download6 = true;
              Download5 = true;
              selected2 = -1;
              K1 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          }
        },
        initiallyExpanded: 6 == selected2,
        maintainState: true,
        title: Download0
            ? Text(
                'Standard Formula',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    color: Color(0xff44bca3)),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Standard Formula',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Color(0xff44bca3)),
                  ),
                  loading0
                      ? Container()
                      : Container(
                          child: Center(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 40,
                                width: 40,
                                child: IconButton(
                                  onPressed: () {
                                    DialogStandard(context);
                                  },
                                  icon: Icon(
                                    Icons.settings,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
        children: [
          loading0
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: screenH * 0.10,
                  child: Center(child: CircularProgressIndicator()))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Standard Formula: $form',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date Start: $Start',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            // Container(
                            //   child: Center(
                            //     child: Card(
                            //       elevation: 5,
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //       child: Container(
                            //         height: 40,
                            //         width: 40,
                            //         child: IconButton(
                            //           onPressed: () {
                            //             DialogStandard(
                            //                 context, nowresult0_1, nowresult0_2);
                            //           },
                            //           icon: Icon(
                            //             Icons.settings,
                            //             color: Color.fromARGB(255, 0, 0, 0),
                            //             size: 25,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date End: $End',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text(
                              'Age Start: $day Day',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );

  List<charts.Series<dynamic, String>> _createSampleDataBar1(
      List<dynamic> nowresult) {
    return [
      for (int i = 0; i < nowresult[0].keys.length; i++)
        if (nowresult[0].keys.elementAt(i) != 'device')
          charts.Series<dynamic, String>(
            strokeWidthPxFn: (__, _) => 1,
            fillColorFn: (__, _) => charts.ColorUtil.fromDartColor(C2[i - 1]),
            colorFn: (__, _) => charts.ColorUtil.fromDartColor(C1[i - 1]),

            id: '$i',
            data: nowresult,
            domainFn: (dynamic daily20, _) => daily20['device'],
            measureFn: (dynamic daily20, _) =>
                daily20['${nowresult[0].keys.elementAt(i)}'] ?? null,
            // daily20['${result2[0].keys.elementAt(1)}'] ?? null,
          ),
    ];
  }

  DateTime? dateTime1_ = DateTime.now();
  Future<void> chooseDate1() async {
    DateTime? ChooseDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: dateTime1_!,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff44bca3),
              onPrimary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(255, 0, 0, 0),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (ChooseDateTime != null) {
      setState(() {
        dateTime1_ = ChooseDateTime;
        getjaon0_1_weight_information();
        getjaon1_weight_device();
        getjaon2_weight_average_hourly();
        getjaon3_weight_results();
        getjaon4_weight_per_unit();
        getjaon5_weight_distribution_rate();
        getjaon6_weight_estimate_size();
        //  dateTime6 = ChooseDateTime;
      });
    }
  }

  Widget build1(BuildContext context) => ExpansionTile(
        key: K1,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Duration(seconds: 1000);
              selected2 = 0;
              K0 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          } else {
            setState(() {
              Download0 = true;
              Download6 = true;
              Download2 = true;
              Download5 = true;

              selected2 = -1;
              K0 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          }
        },
        initiallyExpanded: 0 == selected2,
        maintainState: true,
        title: Text(
          'Weight Scale Information',
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          Container(
            margin: EdgeInsets.only(left: screenW * 0.07),
            child: Row(
              children: [
                Radio(
                  activeColor: Color(0xff44bca3),
                  value: true,
                  groupValue: Check1,
                  onChanged: (val) {
                    setState(() {
                      Check1 = true;
                      dat1 = '00:00:00.000';
                      dat2 = "23:59:59.000";
                      getjaon1_weight_device();
                      getjaon2_weight_average_hourly();
                      getjaon3_weight_results();
                      getjaon4_weight_per_unit();
                      getjaon5_weight_distribution_rate();
                    });
                  },
                ),
                Text(
                  'View all day',
                  style: new TextStyle(fontSize: 15.0),
                ),
                Radio(
                  activeColor: Color(0xff44bca3),
                  value: false,
                  groupValue: Check1,
                  onChanged: (val) {
                    setState(() {
                      Check1 = false;
                      dat1 = '08:00:00.000';
                      dat2 = "17:59:59.000";
                      getjaon1_weight_device();
                      getjaon2_weight_average_hourly();
                      getjaon3_weight_results();
                      getjaon4_weight_per_unit();
                      getjaon5_weight_distribution_rate();
                    });
                  },
                ),
                Text(
                  'View by period',
                  style: new TextStyle(fontSize: 15.0),
                ),
              ],
            ),
          ),
          loading1
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: screenH * 0.30,
                  child: Center(child: CircularProgressIndicator()))
              : nowresult1_1.length == 1
                  ? Container(
                      height: screenH * 0.40,
                      child: Center(
                          child: Text(
                        'No data to display.',
                        style: TextStyle(fontSize: 18),
                      )))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            width: screenW * 0.95,
                            margin: EdgeInsets.only(top: 10),
                            //  color: Colors.blueAccent,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            height: 270,
                          ),
                          Container(
                            width: screenW * 0.95,
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
                            width: screenW * 0.95,
                            margin: EdgeInsets.only(top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(top: 5),

                              height: 270,
                              // child: SingleChildScrollView(

                              child: DataTable2(
                                headingRowHeight: 40.0,
                                dataRowHeight: 60,
                                dataRowColor:
                                    MaterialStateProperty.all(Colors.white),
                                columnSpacing: 0,
                                horizontalMargin: 15,
                                minWidth: screenW * 0.9,
                                columns: [
                                  DataColumn(
                                    label: Center(
                                      child: Text(
                                        "Device",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Center(
                                      child: Text(
                                        "Last Update.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Center(
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Center(
                                      child: Text(
                                        "Sample Data",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: nowresult1_1.map((item) {
                                  return DataRow(cells: [
                                    DataCell(Center(
                                        child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          height: 20,
                                          width: 10,
                                          child: Radio(
                                            activeColor: Colors.green,
                                            value: true,
                                            groupValue: item['device'] == name,
                                            onChanged: (val) {
                                              setState(() {
                                                name = item['device'];
                                                //print(name);
                                                getjaon2_weight_average_hourly();
                                              });
                                            },
                                          ),
                                        ),
                                        Text(
                                          item['device'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ))),
                                    DataCell(
                                        Center(child: Text(item['last_date']))),
                                    DataCell(Center(
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            // border: Border.all(color: Color(0xff83bb56), width: 5),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: item['status_now'] == 1
                                                ? Color.fromARGB(255, 255, 0, 0)
                                                : Color.fromARGB(
                                                    255, 0, 255, 38)),
                                      ),
                                      // Container(child: Text(item['status_now'].toString()))
                                    )),
                                    DataCell(Center(
                                        child: Text(
                                            item['count_data'].toString()))),
                                  ]);
                                }).toList(),
                              ),
                              // )
                            ),
                          ),
                        ],
                      )
                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Colors.blueAccent,
                      //       gradient: LinearGradient(
                      //           begin: Alignment.topLeft,
                      //           end: Alignment.bottomRight,
                      //           // stops: [0.3, 1],
                      //           colors: [
                      //             Color.fromARGB(255, 160, 193, 238),
                      //             Color.fromARGB(255, 94, 157, 228)
                      //           ])),
                      //   margin: EdgeInsets.only(top: 5),
                      //   width: screenW * 1,
                      //   height: 274,
                      //   // child: SingleChildScrollView(

                      //   child: DataTable2(
                      //     headingRowHeight: 40.0,
                      //     dataRowHeight: 60,
                      //     dataRowColor: MaterialStateProperty.all(Colors.white),
                      //     columnSpacing: 0,
                      //     horizontalMargin: 15,
                      //     minWidth: screenW * 0.9,
                      //     columns: [
                      //       DataColumn(
                      //         label: Center(
                      //           child: Text(
                      //             "Device",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 13,
                      //                 fontFamily: 'Montserrat',
                      //                 color:
                      //                     Color.fromARGB(255, 255, 255, 255)),
                      //           ),
                      //         ),
                      //       ),
                      //       DataColumn(
                      //         label: Center(
                      //           child: Text(
                      //             "Last Update.",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 13,
                      //                 fontFamily: 'Montserrat',
                      //                 color:
                      //                     Color.fromARGB(255, 255, 255, 255)),
                      //           ),
                      //         ),
                      //       ),
                      //       DataColumn(
                      //         label: Center(
                      //           child: Text(
                      //             "Status",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 13,
                      //                 fontFamily: 'Montserrat',
                      //                 color:
                      //                     Color.fromARGB(255, 255, 255, 255)),
                      //           ),
                      //         ),
                      //       ),
                      //       DataColumn(
                      //         label: Center(
                      //           child: Text(
                      //             "Sample Data",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 13,
                      //                 fontFamily: 'Montserrat',
                      //                 color:
                      //                     Color.fromARGB(255, 255, 255, 255)),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //     rows: nowresult1_1.map((item) {
                      //       return DataRow(cells: [
                      //         DataCell(Center(
                      //             child: Column(
                      //           children: [
                      //             Container(
                      //               margin: EdgeInsets.only(top: 5),
                      //               height: 20,
                      //               width: 10,
                      //               child: Radio(
                      //                 activeColor: Colors.green,
                      //                 value: true,
                      //                 groupValue: item['device'] == name,
                      //                 onChanged: (val) {
                      //                   setState(() {
                      //                     name = item['device'];
                      //                     //print(name);
                      //                     getjaon2();
                      //                   });
                      //                 },
                      //               ),
                      //             ),
                      //             Text(
                      //               item['device'],
                      //               style: TextStyle(
                      //                 fontSize: 12,
                      //                 fontFamily: 'Montserrat',
                      //               ),
                      //             ),
                      //           ],
                      //         ))),
                      //         DataCell(Center(child: Text(item['last_date']))),
                      //         DataCell(Center(
                      //           child: Container(
                      //             height: 10,
                      //             width: 10,
                      //             decoration: BoxDecoration(
                      //                 // border: Border.all(color: Color(0xff83bb56), width: 5),
                      //                 borderRadius: BorderRadius.circular(40),
                      //                 color: item['status_now'] == 1
                      //                     ? Color.fromARGB(255, 255, 0, 0)
                      //                     : Color.fromARGB(255, 0, 255, 38)),
                      //           ),
                      //           // Container(child: Text(item['status_now'].toString()))
                      //         )),
                      //         DataCell(Center(
                      //             child: Text(item['count_data'].toString()))),
                      //       ]);
                      //     }).toList(),
                      //   ),
                      //   // )
                      // ),
                      ),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );

  List<charts.Series<dynamic, String>> _createSampleDataBar() {
    return [
      charts.Series<dynamic, String>(
        data: nowresult2_1,
        id: 'Avg. Weight',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 255, 0, 0)),
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 243, 207, 7)),
        fillPatternFn: (_, __) => charts.FillPatternType.forwardHatch,
        domainFn: (dynamic nowresult, _) => nowresult['c_date'],
        measureFn: (dynamic nowresult, _) =>
            nowresult['${nowresult2_1[0].keys.elementAt(1)}'] ?? null,
      ),
      charts.Series<dynamic, String>(
        data: nowresult2_1,
        id: 'Sample Data',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 255, 0, 221)),
        domainFn: (dynamic nowresult, _) => nowresult['c_date'],
        measureFn: (dynamic nowresult, _) =>
            nowresult['${nowresult2_1[0].keys.elementAt(2)}'] ?? null,
      )
        ..setAttribute(charts.rendererIdKey, 'customLine')
        ..setAttribute(charts.measureAxisIdKey, 'secondaryMeasureAxisId'),
    ];
  }

  bool Download2 = true;
  Widget build2(BuildContext context) => ExpansionTile(
        key: K2,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Download2 = true;
              // Download5 = false;
              //  = false;
              // Download6 = false;
              Duration(seconds: 1000);
              selected2 = 1;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          } else {
            setState(() {
              Download2 = false;
              Download0 = true;
              Download5 = true;

              Download6 = true;
              selected2 = -1;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          }
        },
        initiallyExpanded: 1 == selected2,
        maintainState: true,
        title: Download2
            ? Text(
                'Average Hourly Weight',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    color: Color(0xff44bca3)),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Average Hourly Weight',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Color(0xff44bca3)),
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
                    height: 37,
                    width: screenW * 0.25,
                    margin: EdgeInsets.only(top: 10, left: screenW * 0.03),
                    child: TextButton(
                      onPressed: () {
                        saveExcelAgeinformation(
                            nowresult2_1, 'AverageHourlyWeightData');
                      },
                      child: Text(
                        'Download',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
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
        children: [
          Center(
            child: Text(
              '${widget.HOUSE2}-$name',
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: screenH * 0.50,
            child: loading1
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    height: screenH * 0.30,
                    child: Center(child: CircularProgressIndicator()))
                : loading2
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        height: screenH * 0.30,
                        child: Center(child: CircularProgressIndicator()))
                    : nowresult1_1[0]['count_data'] == null
                        ? Container(
                            height: screenH * 0.30,
                            child: Center(
                                child: Text(
                              'No data to display.',
                              style: TextStyle(fontSize: 18),
                            )))
                        : charts.BarChart(
                            _createSampleDataBar(),
                            animate: false,
                            defaultRenderer: new charts.BarRendererConfig(
                                groupingType: charts.BarGroupingType.stacked,
                                strokeWidthPx: 2.0),
                            animationDuration: Duration(seconds: 1),
                            customSeriesRenderers: [
                              new charts.LineRendererConfig(
                                  // includeArea: true,
                                  includeLine: true,
                                  includePoints: false,
                                  strokeWidthPx: 2.5,
                                  customRendererId: 'customLine')
                            ],
                            domainAxis: charts.OrdinalAxisSpec(
                              showAxisLine: false,
                              renderSpec: charts.SmallTickRendererSpec(
                                labelRotation: 50,
                                labelStyle: new charts.TextStyleSpec(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              // viewport: new charts.OrdinalViewport(nowresult2_1[0]['day'], num),
                              tickProviderSpec:
                                  charts.StaticOrdinalTickProviderSpec(<
                                      charts.TickSpec<String>>[
                                new charts.TickSpec(
                                    '${nowresult2_1[0]['c_date']}'),
                                for (int i = 0; i < nowresult2_1.length; i++)
                                  if (i * 3 > 0 && i * 3 < nowresult2_1.length)
                                    new charts.TickSpec(
                                        '${nowresult2_1[i * 3]['c_date']}'),
                              ]),
                            ),
                            selectionModels: [
                              charts.SelectionModelConfig(
                                  type: charts.SelectionModelType.info,
                                  updatedListener: (model) {},
                                  changedListener:
                                      (charts.SelectionModel model) {
                                    if (model.hasDatumSelection) {
                                      selectedDatum = [];
                                      model.selectedDatum.forEach(
                                          (charts.SeriesDatum datumPair) {
                                        selectedDatum!.add({
                                          'title':
                                              '${datumPair.datum['c_date']}',
                                          for (int i = 1;
                                              i < nowresult2_1[0].keys.length;
                                              i++)
                                            'subTitle${i}':
                                                '${datumPair.datum['${nowresult2_1[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                                        });
                                      });
                                    }
                                  })
                            ],
                            behaviors: [
                              charts.LinePointHighlighter(
                                symbolRenderer: CustomCircleSymbolRenderer2(
                                    size: size, nowresult2_1: nowresult2_1),
                              ),
                              new charts.ChartTitle(
                                'day',
                                behaviorPosition:
                                    charts.BehaviorPosition.bottom,
                                titleOutsideJustification:
                                    charts.OutsideJustification.middleDrawArea,
                                titleStyleSpec: charts.TextStyleSpec(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: charts.MaterialPalette.black,
                                ),
                              ),
                              new charts.ChartTitle(
                                'gram',
                                behaviorPosition: charts.BehaviorPosition.start,
                                titleOutsideJustification:
                                    charts.OutsideJustification.middleDrawArea,
                                titleStyleSpec: charts.TextStyleSpec(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: charts.MaterialPalette.black,
                                ),
                              ),
                              new charts.ChartTitle(
                                'Sample Data',
                                behaviorPosition: charts.BehaviorPosition.end,
                                titleOutsideJustification:
                                    charts.OutsideJustification.middleDrawArea,
                                titleStyleSpec: charts.TextStyleSpec(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: charts.MaterialPalette.black,
                                ),
                              ),
                              new charts.SelectNearest(
                                  eventTrigger:
                                      charts.SelectionTrigger.pressHold),
                              new charts.PanAndZoomBehavior(),
                              new charts.SeriesLegend(
                                cellPadding: EdgeInsets.symmetric(
                                    horizontal: screenW * 0.04),
                                legendDefaultMeasure:
                                    charts.LegendDefaultMeasure.none,

                                entryTextStyle: charts.TextStyleSpec(
                                    color: charts.MaterialPalette.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 11),
                                desiredMaxRows: 1,
                                horizontalFirst: false,
                                outsideJustification:
                                    charts.OutsideJustification.startDrawArea,
                                // cellPadding: new EdgeInsets.only(right: 8.0, bottom: 4.0),
                              ),
                            ],
                            secondaryMeasureAxis: new charts.NumericAxisSpec(
                                tickFormatterSpec: charts
                                        .BasicNumericTickFormatterSpec
                                    .fromNumberFormat(NumberFormat.compact()),
                                tickProviderSpec:
                                    charts.BasicNumericTickProviderSpec(
                                  zeroBound: true,
                                  desiredTickCount: 6,
                                ),
                                renderSpec: new charts.GridlineRendererSpec(
                                    labelStyle:
                                        new charts.TextStyleSpec(fontSize: 13),
                                    lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.black))),
                            primaryMeasureAxis: new charts.NumericAxisSpec(
                                tickFormatterSpec: charts
                                        .BasicNumericTickFormatterSpec
                                    .fromNumberFormat(NumberFormat.compact()),
                                tickProviderSpec:
                                    charts.BasicNumericTickProviderSpec(
                                  zeroBound: true,
                                  desiredTickCount: 6,
                                ),
                                renderSpec: new charts.GridlineRendererSpec(
                                    labelStyle: new charts.TextStyleSpec(
                                      fontSize: 13,
                                      fontFamily: 'Montserrat',
                                    ),
                                    lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.black))),
                          ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );

  late String sView = 'View all day';
  List<String> View = ['View all day', 'View by period'];
  Widget build3(BuildContext context) => ExpansionTile(
        key: K3,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Duration(seconds: 1000);
              selected2 = 2;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K2 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          } else {
            setState(() {
              Download2 = true;

              Download6 = true;
              Download0 = true;
              Download5 = true;
              selected2 = -1;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K2 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          }
        },
        initiallyExpanded: 2 == selected2,
        maintainState: true,
        title: Text(
          'Weight Results',
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          Column(
            children: [
              Container(
                height: 150,
                child: Row(
                  children: [
                    nowresult3_1 == null
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            height: screenH * 0.30,
                            child: Center(child: CircularProgressIndicator()))
                        : loading3
                            ? Container(
                                width: screenW * 0.47,
                                height: screenH * 0.57,
                                child: Center(
                                    child: Text(
                                  'No data to display.',
                                  style: TextStyle(fontSize: 18),
                                )))
                            : Container(
                                width: screenW * 0.47,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: charts.BarChart(
                                    _createSampleDataBar1(nowresult3_1),
                                    animate: false,
                                    animationDuration: Duration(seconds: 1),
                                    behaviors: [
                                      charts.LinePointHighlighter(
                                        symbolRenderer:
                                            CustomCircleSymbolRenderer3_1(
                                                size: size,
                                                nowresult3_1: nowresult3_1,
                                                nowresult1_1: nowresult1_1),
                                      ),
                                      new charts.ChartTitle('${widget.HOUSE2}',
                                          behaviorPosition:
                                              charts.BehaviorPosition.top,
                                          titleOutsideJustification: charts
                                              .OutsideJustification.middle,
                                          titleStyleSpec: charts.TextStyleSpec(
                                              fontSize: 12),
                                          innerPadding: 12),
                                      new charts.ChartTitle(
                                        'Average',
                                        behaviorPosition:
                                            charts.BehaviorPosition.bottom,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12),
                                      ),
                                      new charts.ChartTitle(
                                        'gram',
                                        behaviorPosition:
                                            charts.BehaviorPosition.start,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12),
                                      ),
                                      new charts.SelectNearest(
                                          eventTrigger: charts
                                              .SelectionTrigger.pressHold),
                                    ],
                                    selectionModels: [
                                      charts.SelectionModelConfig(
                                          type: charts.SelectionModelType.info,
                                          updatedListener: (model) {},
                                          changedListener:
                                              (charts.SelectionModel model) {
                                            if (model.hasDatumSelection) {
                                              selectedDatum1 = [];
                                              model.selectedDatum.forEach(
                                                  (charts.SeriesDatum
                                                      datumPair) {
                                                selectedDatum1!.add({
                                                  'title':
                                                      '${datumPair.datum['device']}',
                                                  for (int i = 1;
                                                      i <
                                                          nowresult3_1[0]
                                                              .keys
                                                              .length;
                                                      i++)
                                                    'subTitle${i}':
                                                        '${datumPair.datum['${nowresult3_1[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                                                });
                                              });
                                            }
                                          })
                                    ],
                                    domainAxis: new charts.OrdinalAxisSpec(

                                        // Make sure that we draw the domain axis line.
                                        showAxisLine: true,
                                        // But don't draw anything else.
                                        renderSpec:
                                            new charts.NoneRenderSpec()),
                                    primaryMeasureAxis: new charts
                                            .NumericAxisSpec(
                                        tickFormatterSpec:
                                            charts.BasicNumericTickFormatterSpec
                                                .fromNumberFormat(
                                                    NumberFormat.compact()),
                                        tickProviderSpec:
                                            charts.BasicNumericTickProviderSpec(
                                          zeroBound: true,
                                          desiredTickCount: 4,
                                        ),
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          labelStyle: new charts.TextStyleSpec(
                                              fontSize: 12,
                                              color:
                                                  charts.MaterialPalette.black),
                                        )),
                                  ),
                                ),
                              ),
                    nowresult3_2 == null
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            height: screenH * 0.30,
                            child: Center(child: CircularProgressIndicator()))
                        : loading3
                            ? Container(
                                width: screenW * 0.47,
                                height: screenH * 0.57,
                                child: Center(
                                    child: Text(
                                  'No data to display.',
                                  style: TextStyle(fontSize: 18),
                                )))
                            : Container(
                                width: screenW * 0.47,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: charts.BarChart(
                                    _createSampleDataBar1(nowresult3_2),
                                    // _createSampleDataBar1(nowresult3_2_11,nowresult3_2_12,nowresult3_2_13,nowresult3_2_14,nowresult3_2_15,nowresult3_2_16),
                                    animate: false,
                                    animationDuration: Duration(seconds: 1),

                                    selectionModels: [
                                      charts.SelectionModelConfig(
                                          type: charts.SelectionModelType.info,
                                          updatedListener: (model) {},
                                          changedListener:
                                              (charts.SelectionModel model) {
                                            if (model.hasDatumSelection) {
                                              selectedDatum2 = [];
                                              model.selectedDatum.forEach(
                                                  (charts.SeriesDatum
                                                      datumPair) {
                                                selectedDatum2!.add({
                                                  'title':
                                                      '${datumPair.datum['device']}',
                                                  for (int i = 1;
                                                      i <
                                                          nowresult3_2[0]
                                                              .keys
                                                              .length;
                                                      i++)
                                                    'subTitle${i}':
                                                        '${datumPair.datum['${nowresult3_2[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                                                });
                                              });
                                            }
                                          })
                                    ],
                                    behaviors: [
                                      charts.LinePointHighlighter(
                                        symbolRenderer:
                                            CustomCircleSymbolRenderer3_2(
                                                size: size,
                                                nowresult3_1: nowresult3_2,
                                                nowresult1_1: nowresult1_1),
                                      ),
                                      new charts.ChartTitle('${widget.HOUSE2}',
                                          behaviorPosition:
                                              charts.BehaviorPosition.top,
                                          titleOutsideJustification: charts
                                              .OutsideJustification.middle,
                                          titleStyleSpec: charts.TextStyleSpec(
                                              fontSize: 12),
                                          innerPadding: 12),
                                      new charts.ChartTitle(
                                        'STD',
                                        behaviorPosition:
                                            charts.BehaviorPosition.bottom,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12),
                                      ),
                                      new charts.ChartTitle(
                                        'gram',
                                        behaviorPosition:
                                            charts.BehaviorPosition.start,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12),
                                      ),
                                      new charts.SelectNearest(
                                          eventTrigger: charts
                                              .SelectionTrigger.pressHold),
                                    ],
                                    domainAxis: new charts.OrdinalAxisSpec(

                                        // Make sure that we draw the domain axis line.
                                        showAxisLine: true,
                                        // But don't draw anything else.
                                        renderSpec:
                                            new charts.NoneRenderSpec()),

                                    primaryMeasureAxis: new charts
                                            .NumericAxisSpec(
                                        tickProviderSpec:
                                            charts.BasicNumericTickProviderSpec(
                                          zeroBound: true,
                                          desiredTickCount: 4,
                                        ),
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          labelStyle: new charts.TextStyleSpec(
                                              fontSize: 12,
                                              color:
                                                  charts.MaterialPalette.black),
                                        )),
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
              Container(
                height: 150,
                child: Row(
                  children: [
                    nowresult3_3 == null
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            height: screenH * 0.30,
                            child: Center(child: CircularProgressIndicator()))
                        : loading3
                            ? Container(
                                width: screenW * 0.47,
                                height: screenH * 0.57,
                                child: Center(
                                    child: Text(
                                  'No data to display.',
                                  style: TextStyle(fontSize: 18),
                                )))
                            : Container(
                                width: screenW * 0.47,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: charts.BarChart(
                                    _createSampleDataBar1(nowresult3_3),
                                    //  _createSampleDataBar1(nowresult3_3_11,nowresult3_3_12,nowresult3_3_13,nowresult3_3_14,nowresult3_3_15,nowresult3_3_16),
                                    animate: false,
                                    animationDuration: Duration(seconds: 1),
                                    selectionModels: [
                                      charts.SelectionModelConfig(
                                          type: charts.SelectionModelType.info,
                                          updatedListener: (model) {},
                                          changedListener:
                                              (charts.SelectionModel model) {
                                            if (model.hasDatumSelection) {
                                              selectedDatum3 = [];
                                              model.selectedDatum.forEach(
                                                  (charts.SeriesDatum
                                                      datumPair) {
                                                selectedDatum3!.add({
                                                  'title':
                                                      '${datumPair.datum['device']}',
                                                  for (int i = 1;
                                                      i <
                                                          nowresult3_3[0]
                                                              .keys
                                                              .length;
                                                      i++)
                                                    'subTitle${i}':
                                                        '${datumPair.datum['${nowresult3_3[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                                                });
                                              });
                                            }
                                          })
                                    ],
                                    behaviors: [
                                      charts.LinePointHighlighter(
                                        symbolRenderer:
                                            CustomCircleSymbolRenderer3_3(
                                                size: size,
                                                nowresult3_1: nowresult3_3,
                                                nowresult1_1: nowresult1_1),
                                      ),
                                      new charts.ChartTitle('${widget.HOUSE2}',
                                          behaviorPosition:
                                              charts.BehaviorPosition.top,
                                          titleOutsideJustification: charts
                                              .OutsideJustification.middle,
                                          titleStyleSpec: charts.TextStyleSpec(
                                              fontSize: 12),
                                          innerPadding: 12),
                                      new charts.ChartTitle(
                                        'CV',
                                        behaviorPosition:
                                            charts.BehaviorPosition.bottom,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12),
                                      ),
                                      new charts.ChartTitle(
                                        '%',
                                        behaviorPosition:
                                            charts.BehaviorPosition.start,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12),
                                      ),
                                      new charts.SelectNearest(
                                          eventTrigger: charts
                                              .SelectionTrigger.pressHold),
                                    ],
                                    domainAxis: new charts.OrdinalAxisSpec(

                                        // Make sure that we draw the domain axis line.
                                        showAxisLine: true,
                                        // But don't draw anything else.
                                        renderSpec:
                                            new charts.NoneRenderSpec()),
                                    primaryMeasureAxis: new charts
                                            .NumericAxisSpec(
                                        tickFormatterSpec:
                                            charts.BasicNumericTickFormatterSpec
                                                .fromNumberFormat(
                                                    NumberFormat.compact()),
                                        tickProviderSpec:
                                            charts.BasicNumericTickProviderSpec(
                                          zeroBound: true,
                                          desiredTickCount: 4,
                                        ),
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          labelStyle: new charts.TextStyleSpec(
                                              fontSize: 12,
                                              color:
                                                  charts.MaterialPalette.black),
                                        )),
                                  ),
                                ),
                              ),
                    nowresult3_4 == null
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            height: screenH * 0.30,
                            child: Center(child: CircularProgressIndicator()))
                        : loading3
                            ? Container(
                                width: screenW * 0.47,
                                height: screenH * 0.57,
                                child: Center(
                                    child: Text(
                                  'No data to display.',
                                  style: TextStyle(fontSize: 18),
                                )))
                            : Container(
                                width: screenW * 0.47,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: charts.BarChart(
                                    _createSampleDataBar1(nowresult3_4),
                                    //  _createSampleDataBar1(nowresult3_4_11,nowresult3_4_12,nowresult3_4_13,nowresult3_4_14,nowresult3_4_15,nowresult3_4_16),
                                    animate: false,
                                    animationDuration: Duration(seconds: 1),
                                    selectionModels: [
                                      charts.SelectionModelConfig(
                                          type: charts.SelectionModelType.info,
                                          updatedListener: (model) {},
                                          changedListener:
                                              (charts.SelectionModel model) {
                                            if (model.hasDatumSelection) {
                                              selectedDatum4 = [];
                                              model.selectedDatum.forEach(
                                                  (charts.SeriesDatum
                                                      datumPair) {
                                                selectedDatum4!.add({
                                                  'title':
                                                      '${datumPair.datum['device']}',
                                                  for (int i = 1;
                                                      i <
                                                          nowresult3_4[0]
                                                              .keys
                                                              .length;
                                                      i++)
                                                    'subTitle${i}':
                                                        '${datumPair.datum['${nowresult3_4[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                                                });
                                              });
                                            }
                                          })
                                    ],
                                    behaviors: [
                                      charts.LinePointHighlighter(
                                        symbolRenderer:
                                            CustomCircleSymbolRenderer3_4(
                                                size: size,
                                                nowresult3_1: nowresult3_4,
                                                nowresult1_1: nowresult1_1),
                                      ),
                                      new charts.ChartTitle('${widget.HOUSE2}',
                                          behaviorPosition:
                                              charts.BehaviorPosition.top,
                                          titleOutsideJustification: charts
                                              .OutsideJustification.middle,
                                          titleStyleSpec: charts.TextStyleSpec(
                                              fontSize: 12),
                                          innerPadding: 12),
                                      new charts.ChartTitle(
                                        'Uniform',
                                        behaviorPosition:
                                            charts.BehaviorPosition.bottom,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12),
                                      ),
                                      new charts.ChartTitle(
                                        '%',
                                        behaviorPosition:
                                            charts.BehaviorPosition.start,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12),
                                      ),
                                      new charts.SelectNearest(
                                          eventTrigger: charts
                                              .SelectionTrigger.pressHold),
                                    ],
                                    primaryMeasureAxis: new charts
                                            .NumericAxisSpec(
                                        tickFormatterSpec:
                                            charts.BasicNumericTickFormatterSpec
                                                .fromNumberFormat(
                                                    NumberFormat.compact()),
                                        tickProviderSpec:
                                            charts.BasicNumericTickProviderSpec(
                                          zeroBound: true,
                                          desiredTickCount: 4,
                                        ),
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          labelStyle: new charts.TextStyleSpec(
                                              fontSize: 12,
                                              color:
                                                  charts.MaterialPalette.black),
                                        )),
                                    domainAxis: new charts.OrdinalAxisSpec(

                                        // Make sure that we draw the domain axis line.
                                        showAxisLine: true,
                                        // But don't draw anything else.
                                        renderSpec:
                                            new charts.NoneRenderSpec()),
                                  ),
                                ),
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
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );

  late String sPlot = 'แสดงที้งหมด';
  List<String> Plot = ['แสดงที้งหมด', 'แสดงถึงวันปัจจุบัน'];
  late String sUnit = 'Weight Per Unit (All)';
  List<String> Unit = ['Weight Per Unit (All)'];
  Widget build4(BuildContext context) => ExpansionTile(
        key: K4,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Duration(seconds: 1000);
              selected2 = 3;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          } else {
            setState(() {
              Download0 = true;
              Download6 = true;
              Download2 = true;
              Download5 = true;

              selected2 = -1;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K5 = UniqueKey();
              K6 = UniqueKey();
            });
          }
        },
        initiallyExpanded: 3 == selected2,
        maintainState: true,
        title: Text(
          'Plot Graph',
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
                                getjaon4_weight_per_unit();
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
                            value: sUnit,
                            items: Unit.map((Unit) => DropdownMenuItem<String>(
                                value: Unit,
                                child: Text(
                                  Unit,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'THSarabun',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                  ),
                                ))).toList(),
                            onChanged: (Unit) {}),
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
                      saveExcelAgeinformation(nowresult4_1, 'DistributionRate');
                    },
                    child: Text(
                      'Download',
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
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
              child: Text(
                '${widget.HOUSE2}',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          Container(
            height: screenH * 0.57,
            child: loading4
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    height: screenH * 0.57,
                    child: Center(child: CircularProgressIndicator()))
                : nowresult4_1 == null
                    ? Container(
                        height: screenH * 0.57,
                        child: Center(
                            child: Text(
                          'No data to display.',
                          style: TextStyle(fontSize: 18),
                        )))
                    : LineChart4(),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );

  charts.BarChart LineChart4() {
    double? Number;
    int? T;
    print(nowresult4_1.length);
    if (nowresult4_1.length < 50) {
      Number = nowresult4_1.length / 10;
    }
    if (nowresult4_1.length > 50 && nowresult4_1.length < 100) {
      Number = nowresult4_1.length / 13;
    }
    if (nowresult4_1.length > 100) {
      Number = nowresult4_1.length / 15;
    }
    String Number1 = Number!.toStringAsFixed(0);
    int Number2 = int.parse('$Number1');

    return charts.BarChart(
      _createSampleData4(),
      animate: false,
      animationDuration: Duration(seconds: 1),
      behaviors: [
        new charts.SelectNearest(
            eventTrigger: charts.SelectionTrigger.pressHold),
        charts.LinePointHighlighter(
          symbolRenderer: CustomCircleSymbolRenderer4(
              size: size, nowresult4_1: nowresult4_1),
        ),
        new charts.SlidingViewport(),
        new charts.PanAndZoomBehavior(),
        new charts.SeriesLegend(
          cellPadding: EdgeInsets.symmetric(horizontal: screenW * 0.025),
          legendDefaultMeasure: charts.LegendDefaultMeasure.none,
          // showMeasures: true,
          entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.black,
              fontFamily: 'Montserrat',
              fontSize: 11),
          desiredMaxColumns: 3,
          // horizontalFirst: false,
          outsideJustification: charts.OutsideJustification.start,
          // cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
        ),
        new charts.ChartTitle(
          'Date',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
          titleStyleSpec: charts.TextStyleSpec(
            fontSize: 14,
            fontFamily: 'Montserrat',
            color: charts.MaterialPalette.black,
          ),
        ),
        new charts.ChartTitle(
          'gram/ea',
          behaviorPosition: charts.BehaviorPosition.start,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
          titleStyleSpec: charts.TextStyleSpec(
            fontSize: 14,
            fontFamily: 'Montserrat',
            color: charts.MaterialPalette.black,
          ),
        ),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            updatedListener: (model) {},
            changedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection) {
                selectedDatum = [];
                model.selectedDatum.forEach((charts.SeriesDatum datumPair) {
                  selectedDatum!.add({
                    'title':
                        '${datumPair.datum['n_day'] ?? datumPair.datum[0]['day']}',
                    for (int i = 1; i < nowresult4_1[0].keys.length; i++)
                      'subTitle${i}':
                          '${datumPair.datum['${nowresult4_1[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                  });
                });
              }
            })
      ],
      customSeriesRenderers: [
        new charts.LineRendererConfig(
            includeArea: true,
            includeLine: true,
            includePoints: false,
            strokeWidthPx: 1,
            customRendererId: 'customLine')
      ],
      domainAxis: charts.OrdinalAxisSpec(
        showAxisLine: false,
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 50,
          labelStyle: new charts.TextStyleSpec(
            fontSize: 13,
            fontFamily: 'Montserrat',
          ),
        ),
        // viewport: new charts.OrdinalViewport(nowresult2_1[0]['day'], num),
        tickProviderSpec:
            charts.StaticOrdinalTickProviderSpec(<charts.TickSpec<String>>[
          new charts.TickSpec(
              '${nowresult4_1[0]['n_day'] ?? nowresult4_1[0]['day']}'),
          for (int i = 0; i < nowresult4_1.length; i++)
            if (i * Number2 > 0 && i * Number2 < nowresult4_1.length)
              new charts.TickSpec(
                  '${nowresult4_1[i * Number2]['n_day'] ?? nowresult4_1[i * Number2]['day']}'),
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
    );
  }

  var linesalesdata1;
  var linesalesdata2;
  List<Color> C1 = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 0, 4, 255),
    Color.fromARGB(255, 0, 95, 17),
    Color.fromARGB(255, 118, 0, 99),
    Color.fromARGB(255, 0, 255, 225),
    Color.fromARGB(255, 83, 1, 73),
    Color.fromARGB(255, 255, 132, 0),
    Color.fromARGB(255, 255, 230, 0),
    Color.fromARGB(255, 1, 220, 249),
    Color.fromARGB(255, 0, 255, 38),
    Color.fromARGB(255, 255, 0, 221),
    Color.fromARGB(255, 4, 113, 79),
    Color.fromARGB(255, 255, 0, 166),
    Color.fromARGB(255, 112, 48, 3),
    Color.fromARGB(255, 155, 112, 255),
    Color.fromARGB(255, 4, 83, 91)
  ];

  List<Color> C2 = [
    Color.fromARGB(255, 251, 145, 145),
    Color.fromARGB(255, 1, 220, 249),
    Color.fromARGB(255, 0, 255, 38),
    Color.fromARGB(255, 255, 0, 221),
    Color.fromARGB(255, 4, 113, 79),
    Color.fromARGB(255, 255, 0, 166),
    Color.fromARGB(255, 112, 48, 3),
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 0, 4, 255),
    Color.fromARGB(255, 0, 95, 17),
    Color.fromARGB(255, 118, 0, 99),
    Color.fromARGB(255, 0, 255, 225),
    Color.fromARGB(255, 83, 1, 73),
    Color.fromARGB(255, 255, 132, 0),
    Color.fromARGB(255, 250, 114, 234),
    Color.fromARGB(255, 204, 255, 0)
  ];

  List<charts.Series<dynamic, String>> _createSampleData4() {
    return [
      for (int i = 0; i < nowresult4_1[0].keys.length; i++)
        if (nowresult4_1[0].keys.elementAt(i) != 'n_day' &&
            nowresult4_1[0].keys.elementAt(i) != 'day')
          charts.Series<dynamic, String>(
            colorFn: (__, _) => charts.ColorUtil.fromDartColor(C2[i]),
            id: '${nowresult4_1[0].keys.elementAt(i)}',
            data: nowresult4_1,
            domainFn: (dynamic daily20, _) =>
                daily20['day'] ?? daily20['n_day'],
            measureFn: (dynamic daily20, _) =>
                daily20['${nowresult4_1[0].keys.elementAt(i)}'] ?? null,
            // daily20['${result2[0].keys.elementAt(1)}'] ?? null,
          )..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }

  List<charts.Series<dynamic, double>> _createSampleData1() {
    List<List<dynamic>> da = [
      nowresult5_11,
      nowresult5_12,
      nowresult5_13,
      nowresult5_14,
      nowresult5_15,
      nowresult5_16,
      nowresult5_17,
      nowresult5_18,
      nowresult5_19,
      nowresult5_110,
      nowresult5_111,
      nowresult5_112,
      nowresult5_113,
      nowresult5_114,
      nowresult5_115,
      nowresult5_116
    ];

    return [
      for (int i = 0; i < uniquelist1.length; i++)
        charts.Series<dynamic, double>(
          strokeWidthPxFn: (__, _) => 1,
          fillColorFn: (dynamic daily20, _) =>
              charts.ColorUtil.fromDartColor(C2[i]),
          colorFn: (dynamic daily20, _) =>
              charts.ColorUtil.fromDartColor(C1[i]),
          id: uniquelist1[i],
          data: da[i],
          domainFn: (dynamic daily20, _) => daily20['n_weight'].toDouble(),
          measureFn: (dynamic daily20, _) => daily20['n_normdst'] ?? null,
        ),
    ];
  }

  bool Download5 = true;
  Widget build5(BuildContext context) => ExpansionTile(
        key: K5,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Download5 = true;
              Duration(seconds: 1000);
              selected2 = 4;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K6 = UniqueKey();
            });
          } else {
            setState(() {
              Download5 = false;
              Download0 = true;
              Download2 = true;

              Download6 = true;
              selected2 = -1;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K6 = UniqueKey();
            });
          }
        },
        initiallyExpanded: 4 == selected2,
        maintainState: true,
        title: Download5
            ? Text(
                'Distribustoin Rate',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    color: Color(0xff44bca3)),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Distribustoin Rate',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Color(0xff44bca3)),
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
                    height: 37,
                    width: screenW * 0.25,
                    margin: EdgeInsets.only(top: 10, left: screenW * 0.03),
                    child: TextButton(
                      onPressed: () {
                        saveExcelAgeinformation(nowresult5_1, 'WeightUnitData');
                      },
                      child: Text(
                        'Download',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
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
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [],
            ),
          ),
          Center(
            child: Text(
              '${widget.HOUSE2}',
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          loading5
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: screenH * 0.57,
                  child: Center(child: CircularProgressIndicator()))
              : nowresult5_1 == null
                  ? Container(
                      height: screenH * 0.57,
                      child: Center(
                          child: Text(
                        'No data to display.',
                        style: TextStyle(fontSize: 18),
                      )))
                  : LineChart5(),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
        ],
      );

  Container LineChart5() {
    var largestGeekValue1 = nowresult5_1[0]['n_weight'];
    var largestGeekValue2 = nowresult5_1[0]['n_weight'];

    for (int i = 0; i < nowresult5_1.length; i++) {
      if (nowresult5_1[i]['n_weight'] > largestGeekValue1) {
        largestGeekValue1 = nowresult5_1[i]['n_weight'];
      }
    }
    for (int i = 0; i < nowresult5_1.length; i++) {
      if (nowresult5_1[i]['n_weight'] < largestGeekValue2) {
        largestGeekValue2 = nowresult5_1[i]['n_weight'];
      }
    }

    return Container(
      height: screenH * 0.45,
      child: charts.LineChart(
        _createSampleData1(),
        animate: false,
        defaultRenderer: charts.LineRendererConfig(
            includeArea: false,
            includeLine: false,
            includePoints: true,
            strokeWidthPx: 1),
        //  defaultRenderer: charts.LineRendererConfig(
        //               includeArea: false,
        //               includeLine: false,
        //               includePoints: true,

        //               strokeWidthPx: 1
        //             ),
        selectionModels: [
          charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              updatedListener: (model) {},
              changedListener: (charts.SelectionModel model) {
                if (model.hasDatumSelection) {
                  selectedDatum = [];
                  model.selectedDatum.forEach((charts.SeriesDatum datumPair) {
                    selectedDatum!.add({
                      'title': '${datumPair.datum['c_device']}',
                      'subTitle1':
                          '${datumPair.datum['n_weight'] ?? 'undefeated'}',
                      'subTitle2':
                          '${datumPair.datum['n_normdst'] ?? 'undefeated'}',
                    });
                  });
                }
              })
        ],
        domainAxis: charts.NumericAxisSpec(
            showAxisLine: false,
            viewport: charts.NumericExtents(
                largestGeekValue2 - 100, largestGeekValue1 + 100),
            tickFormatterSpec:
                charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                    NumberFormat.compact()),
            tickProviderSpec: charts.BasicNumericTickProviderSpec(
              zeroBound: true,
              desiredTickCount: 17,
            ),
            renderSpec: new charts.SmallTickRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                fontSize: 13,
                fontFamily: 'Montserrat',
              ),
            )),
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickFormatterSpec:
                charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                    NumberFormat.compact()),
            tickProviderSpec:
                charts.StaticNumericTickProviderSpec(<charts.TickSpec<double>>[
              for (var i = 0; i <= 20; i++)
                if (i * 0.03 < largestGeekValue + 0.03)
                  charts.TickSpec(i * 0.03),
            ]),
            // tickProviderSpec: charts.BasicNumericTickProviderSpec(
            //       zeroBound: true,
            //       desiredTickCount : 6,
            //       desiredMinTickCount : 1,
            //       desiredMaxTickCount : 0
            //     ),
            renderSpec: new charts.GridlineRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 13, fontFamily: 'Montserrat'),
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),
        behaviors: [
          charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer5(size: size),
          ),

          new charts.ChartTitle(
            'Weight (gram)',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 14,
              fontFamily: 'Montserrat',
              color: charts.MaterialPalette.black,
            ),
          ),
          new charts.ChartTitle(
            '%',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 14,
              fontFamily: 'Montserrat',
              color: charts.MaterialPalette.black,
            ),
          ),
          new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tap),
          new charts.SeriesLegend(
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.black,
                fontFamily: 'Montserrat',
                fontSize: 11),
            // desiredMaxRows: 4,
            desiredMaxColumns: 3,
            cellPadding: EdgeInsets.symmetric(horizontal: screenW * 0.01),
            legendDefaultMeasure: charts.LegendDefaultMeasure.none,
            position: charts.BehaviorPosition.bottom,
          ),
          // new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.pressHold),
        ],
      ),
    );
  }

  var linesalesdata0;

  bool isSquare = false;
  Color textC = Color(0xff505050);
  int? touchedIndex;
  bool Download6 = true;
  DateTime? dateTime_ = DateTime.now();
  //  DateTime? dateTime6 = DateTime.utc(2022, 06, 27);

  Future<void> chooseDate6() async {
    //  setState(() {
    //      dateTime_  = dateTime6;

    //    });
    DateTime? ChooseDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: dateTime_!,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff44bca3),
              onPrimary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(255, 0, 0, 0),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (ChooseDateTime != null) {
      setState(() {
        dateTime_ = ChooseDateTime;
        getjaon6_weight_estimate_size();
        //  dateTime6 = ChooseDateTime;
      });
    }
  }

  Widget build6(BuildContext context) => ExpansionTile(
        key: K6,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Download6 = true;

              Duration(seconds: 1000);
              selected2 = 5;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
            });
          } else {
            setState(() {
              Download6 = false;
              Download0 = true;
              Download2 = true;

              Download5 = true;
              selected2 = -1;
              K0 = UniqueKey();
              K1 = UniqueKey();
              K2 = UniqueKey();
              K3 = UniqueKey();
              K4 = UniqueKey();
              K5 = UniqueKey();
            });
          }
        },
        initiallyExpanded: 5 == selected2,
        maintainState: true,
        title: Download6
            ? Text(
                'Estimate Real Size',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    color: Color(0xff44bca3)),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estimate Real Size',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Color(0xff44bca3)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(255, 194, 194, 194),
                            width: screenW * 0.005),
                        color: Color.fromARGB(255, 235, 235, 235)),
                    height: 40,
                    width: screenW * 0.22,
                    child: TextButton(
                      onPressed: () {
                        chooseDate6();
                      },
                      child: Text(
                        '${dateTime_!.day}-${dateTime_!.month}-${dateTime_!.year}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                ],
              ),
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                      height: 40,
                      width: screenW * 0.25,
                      margin: EdgeInsets.only(bottom: 10, right: 10),
                      child: TextButton(
                        onPressed: () {
                          saveExcelAgeinformation(
                              nowresult6_1, 'SizeComparisonData');
                        },
                        child: Text(
                          'Download',
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
                Container(
                  width: screenW * 0.66,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 198, 198, 198),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Color.fromARGB(255, 243, 0, 247),
                        borderRadius: BorderRadius.circular(25.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Color.fromARGB(255, 74, 74, 74),
                    tabs: [
                      Tab(
                        text: 'View charts',
                      ),
                      Tab(
                        text: 'View table',
                      ),
                    ],
                  ),
                ),
                loading6
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        height: screenH * 0.57,
                        child: Center(child: CircularProgressIndicator()))
                    : nowresult6_1 == null
                        ? Container(
                            height: screenH * 0.57,
                            child: Center(
                                child: Text(
                              'No data to display.',
                              style: TextStyle(fontSize: 18),
                            )))
                        : loading6
                            ? Container(
                                margin: EdgeInsets.only(top: 10),
                                height: screenH * 0.30,
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Container(
                                width: screenW * 1,
                                height: 350,
                                child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    Viewcharts(
                                      nowresult6_1: nowresult6_1,
                                    ),
                                    Viewtable(
                                      nowresult6_1: nowresult6_1,
                                    ),
                                  ],
                                ),
                              )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: screenW * 1,
            height: screenH * 0.001,
            color: Color.fromARGB(255, 112, 112, 112),
          ),
        ],
      );
}

List? selectedDatum;
String? unit2_1, unit2_2;

class CustomCircleSymbolRenderer2 extends charts.CircleSymbolRenderer {
  final Size? size;
  late List<dynamic>? nowresult2_1;
  CustomCircleSymbolRenderer2({this.size, this.nowresult2_1});

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
    if (left > 128.04594594594593) {
      canvas.drawRRect(
        Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * nowresult2_1![0].keys.length),
        fill:
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
        radius: 10,
        roundTopLeft: true,
        roundTopRight: true,
        roundBottomLeft: true,
        roundBottomRight: true,
      );
      chartStyle.TextStyle textStyle = chartStyle.TextStyle();
      textStyle.color = charts.Color.white;
      textStyle.fontSize = 11;
      canvas.drawText(
          chartText.TextElement(tooltips[0]['title'], style: textStyle),
          (110 - 10.0 - 35).round(),
          (25.0 - 5).round());

      if (tooltips[0]['subTitle1'] == 'undefeated') {
        unit2_1 = 'undefeated';
      } else {
        unit2_1 =
            '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle1']}'))}';
      }
      if (tooltips[0]['subTitle2'] == 'undefeated') {
        unit2_2 = 'undefeated';
      } else {
        unit2_2 =
            '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle2']}'))}';
      }
      canvas.drawText(
          chartText.TextElement('Avg. Weight : ' + '$unit2_1',
              style: textStyle),
          (110 - 10.0 - 35).round(),
          (13 + (1 * 13) + 7).round());
      canvas.drawText(
          chartText.TextElement('Sample Data : ' + '$unit2_2',
              style: textStyle),
          (110 - 10.0 - 35).round(),
          (13 + (2 * 13) + 7).round());
    }
    if (left < 128.04594594594593) {
      canvas.drawRRect(
        Rectangle(265.0 - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * (nowresult2_1![0].keys.length)),
        fill:
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
        radius: 10,
        roundTopLeft: true,
        roundTopRight: true,
        roundBottomLeft: true,
        roundBottomRight: true,
      );
      chartStyle.TextStyle textStyle = chartStyle.TextStyle();
      textStyle.color = charts.Color.white;
      textStyle.fontSize = 11;
      canvas.drawText(
          chartText.TextElement(tooltips[0]['title'], style: textStyle),
          (265 - 10.0 - 35).round(),
          (25.0 - 5).round());
      if (tooltips[0]['subTitle1'] == 'undefeated') {
        unit2_1 = 'undefeated';
      } else {
        unit2_1 =
            '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle1']}'))}';
      }
      if (tooltips[0]['subTitle2'] == 'undefeated') {
        unit2_2 = 'undefeated';
      } else {
        unit2_2 =
            '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle2']}'))}';
      }
      canvas.drawText(
          chartText.TextElement('Avg. Weight : ' + '$unit2_1',
              style: textStyle),
          (265 - 10.0 - 35).round(),
          (13 + (1 * 13) + 7).round());
      canvas.drawText(
          chartText.TextElement('Sample Data : ' + '$unit2_2',
              style: textStyle),
          (265 - 10.0 - 35).round(),
          (13 + (2 * 13) + 7).round());
    }
  }
}

late List<String> uniquelist = [];
String? unit3_1;
String? unit3_2;
String? unit3_3;
String? unit3_4;
List? selectedDatum1;
List? selectedDatum2;
List? selectedDatum3;
List? selectedDatum4;

class CustomCircleSymbolRenderer3_1 extends charts.CircleSymbolRenderer {
  final Size? size;
  late List<dynamic>? nowresult3_1;
  late List<dynamic>? nowresult1_1;
  CustomCircleSymbolRenderer3_1(
      {this.size, this.nowresult3_1, this.nowresult1_1});

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
    List tooltips = selectedDatum1!;

    num tipTextLen = (tooltips[0]['title']).length;
    num rectWidth = bounds.width + tipTextLen * 8.3;
    num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;

    num left = bounds.left > (size?.width ?? 300) / 4
        ? (bounds.left > size!.width / 4
            ? bounds.left - rectWidth
            : bounds.left - rectWidth / 2)
        : bounds.left - 40;
    for (int i = 0; i < nowresult1_1!.length; i++) {
      if (nowresult1_1![i]["count_data"] != null) {
        uniquelist += [nowresult1_1![i]["device"]];
        // uniquelist.insert(i, nowresult1_1![i]["device"]);
      }
    }
    canvas.drawRRect(
      Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
          bounds.height + 14 * nowresult3_1![0].keys.length),
      fill: charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
      radius: 10,
      roundTopLeft: true,
      roundTopRight: true,
      roundBottomLeft: true,
      roundBottomRight: true,
    );
    chartStyle.TextStyle textStyle = chartStyle.TextStyle();
    textStyle.color = charts.Color.white;
    textStyle.fontSize = 11;
    // canvas.drawText(
    //   chartText.TextElement(tooltips[0]['title'],
    //       style: textStyle),
    //   (110 - 10.0 - 35).round(),
    //   (25.0 - 5).round());
    // //print(uniquelist![0]);
    for (int i = 1; i < nowresult3_1![0].keys.length; i++) {
      if (tooltips[0]['subTitle$i'] == 'undefeated') {
        unit3_1 = 'undefeated';
      } else {
        unit3_1 =
            '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
      }
      canvas.drawText(
          chartText.TextElement('${uniquelist[i - 1]} : ' + '$unit3_1',
              style: textStyle),
          (110 - 10.0 - 35).round(),
          (11 + (i * 13) + 7).round());
    }
  }
}

class CustomCircleSymbolRenderer3_2 extends charts.CircleSymbolRenderer {
  final Size? size;
  late List<dynamic>? nowresult3_1;
  late List<dynamic>? nowresult1_1;
  CustomCircleSymbolRenderer3_2(
      {this.size, this.nowresult3_1, this.nowresult1_1});

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
    List tooltips = selectedDatum2!;

    num tipTextLen = (tooltips[0]['title']).length;
    num rectWidth = bounds.width + tipTextLen * 8.3;
    num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;

    num left = bounds.left > (size?.width ?? 300) / 4
        ? (bounds.left > size!.width / 4
            ? bounds.left - rectWidth
            : bounds.left - rectWidth / 2)
        : bounds.left - 40;
    for (int i = 0; i < nowresult1_1!.length; i++) {
      if (nowresult1_1![i]["count_data"] != null) {
        uniquelist += [nowresult1_1![i]["device"]];
        // uniquelist.insert(i, nowresult1_1![i]["device"]);
      }
    }
    canvas.drawRRect(
      Rectangle(90.0 - 5.0 - 50, 15 - 0, 140 + 0,
          bounds.height + 14 * nowresult3_1![0].keys.length),
      fill: charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
      radius: 10,
      roundTopLeft: true,
      roundTopRight: true,
      roundBottomLeft: true,
      roundBottomRight: true,
    );
    chartStyle.TextStyle textStyle = chartStyle.TextStyle();
    textStyle.color = charts.Color.white;
    textStyle.fontSize = 11;
    // canvas.drawText(
    //   chartText.TextElement(tooltips[0]['title'],
    //       style: textStyle),
    //   (110 - 10.0 - 35).round(),
    //   (25.0 - 5).round());
    // //print(uniquelist![0]);
    for (int i = 1; i < nowresult3_1![0].keys.length; i++) {
      if (tooltips[0]['subTitle$i'] == 'undefeated') {
        unit3_2 = 'undefeated';
      } else {
        unit3_2 =
            '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
      }
      canvas.drawText(
          chartText.TextElement('${uniquelist[i - 1]} : ' + '$unit3_2',
              style: textStyle),
          (85 - 10.0 - 35).round(),
          (11 + (i * 13) + 7).round());
    }
  }
}

class CustomCircleSymbolRenderer3_3 extends charts.CircleSymbolRenderer {
  final Size? size;
  late List<dynamic>? nowresult3_1;
  late List<dynamic>? nowresult1_1;
  CustomCircleSymbolRenderer3_3(
      {this.size, this.nowresult3_1, this.nowresult1_1});

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
    List tooltips = selectedDatum3!;

    num tipTextLen = (tooltips[0]['title']).length;
    num rectWidth = bounds.width + tipTextLen * 8.3;
    num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;

    num left = bounds.left > (size?.width ?? 300) / 4
        ? (bounds.left > size!.width / 4
            ? bounds.left - rectWidth
            : bounds.left - rectWidth / 2)
        : bounds.left - 40;
    for (int i = 0; i < nowresult1_1!.length; i++) {
      if (nowresult1_1![i]["count_data"] != null) {
        uniquelist += [nowresult1_1![i]["device"]];
        // uniquelist.insert(i, nowresult1_1![i]["device"]);
      }
    }
    canvas.drawRRect(
      Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
          bounds.height + 14 * nowresult3_1![0].keys.length),
      fill: charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
      radius: 10,
      roundTopLeft: true,
      roundTopRight: true,
      roundBottomLeft: true,
      roundBottomRight: true,
    );
    chartStyle.TextStyle textStyle = chartStyle.TextStyle();
    textStyle.color = charts.Color.white;
    textStyle.fontSize = 11;
    // canvas.drawText(
    //   chartText.TextElement(tooltips[0]['title'],
    //       style: textStyle),
    //   (110 - 10.0 - 35).round(),
    //   (25.0 - 5).round());
    // //print(uniquelist![0]);
    for (int i = 1; i < nowresult3_1![0].keys.length; i++) {
      if (tooltips[0]['subTitle$i'] == 'undefeated') {
        unit3_3 = 'undefeated';
      } else {
        unit3_3 =
            '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
      }
      canvas.drawText(
          chartText.TextElement('${uniquelist[i - 1]} : ' + '$unit3_3',
              style: textStyle),
          (110 - 10.0 - 35).round(),
          (11 + (i * 13) + 7).round());
    }
  }
}

class CustomCircleSymbolRenderer3_4 extends charts.CircleSymbolRenderer {
  final Size? size;
  late List<dynamic>? nowresult3_1;
  late List<dynamic>? nowresult1_1;
  CustomCircleSymbolRenderer3_4(
      {this.size, this.nowresult3_1, this.nowresult1_1});

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
    List tooltips = selectedDatum4!;

    num tipTextLen = (tooltips[0]['title']).length;
    num rectWidth = bounds.width + tipTextLen * 8.3;
    num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;

    num left = bounds.left > (size?.width ?? 300) / 4
        ? (bounds.left > size!.width / 4
            ? bounds.left - rectWidth
            : bounds.left - rectWidth / 2)
        : bounds.left - 40;
    for (int i = 0; i < nowresult1_1!.length; i++) {
      if (nowresult1_1![i]["count_data"] != null) {
        uniquelist += [nowresult1_1![i]["device"]];
        // uniquelist.insert(i, nowresult1_1![i]["device"]);
      }
    }
    canvas.drawRRect(
      Rectangle(90.0 - 5.0 - 50, 15 - 0, 140 + 0,
          bounds.height + 14 * nowresult3_1![0].keys.length),
      fill: charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
      radius: 10,
      roundTopLeft: true,
      roundTopRight: true,
      roundBottomLeft: true,
      roundBottomRight: true,
    );
    chartStyle.TextStyle textStyle = chartStyle.TextStyle();
    textStyle.color = charts.Color.white;
    textStyle.fontSize = 11;
    // canvas.drawText(
    //   chartText.TextElement(tooltips[0]['title'],
    //       style: textStyle),
    //   (110 - 10.0 - 35).round(),
    //   (25.0 - 5).round());
    // //print(uniquelist![0]);
    for (int i = 1; i < nowresult3_1![0].keys.length; i++) {
      if (tooltips[0]['subTitle$i'] == 'undefeated') {
        unit3_4 = 'undefeated';
      } else {
        unit3_4 =
            '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
      }
      canvas.drawText(
          chartText.TextElement('${uniquelist[i - 1]} : ' + '$unit3_4',
              style: textStyle),
          (85 - 10.0 - 35).round(),
          (11 + (i * 13) + 7).round());
    }
  }
}

String? unit4_1;

class CustomCircleSymbolRenderer4 extends charts.CircleSymbolRenderer {
  final Size? size;
  late List<dynamic>? nowresult4_1;

  CustomCircleSymbolRenderer4({this.size, this.nowresult4_1});

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
    if (left > 128.04594594594593) {
      canvas.drawRRect(
        Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * nowresult4_1![0].keys.length),
        fill:
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
        radius: 10,
        roundTopLeft: true,
        roundTopRight: true,
        roundBottomLeft: true,
        roundBottomRight: true,
      );
      chartStyle.TextStyle textStyle = chartStyle.TextStyle();
      textStyle.color = charts.Color.white;
      textStyle.fontSize = 11;
      canvas.drawText(
          chartText.TextElement(tooltips[0]['title'], style: textStyle),
          (110 - 10.0 - 35).round(),
          (25.0 - 5).round());
      for (int i = 1; i < nowresult4_1![0].keys.length; i++) {
        if (tooltips[0]['subTitle$i'] == 'undefeated') {
          unit4_1 = 'undefeated';
        } else {
          unit4_1 =
              '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
        }
        canvas.drawText(
            chartText.TextElement(
                '${nowresult4_1![0].keys.elementAt(i)} : ' + '$unit4_1',
                style: textStyle),
            (110 - 10.0 - 35).round(),
            (13 + (i * 13) + 7).round());
      }
    }
    if (left < 128.04594594594593) {
      canvas.drawRRect(
        Rectangle(265.0 - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * (nowresult4_1![0].keys.length)),
        fill:
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
        radius: 10,
        roundTopLeft: true,
        roundTopRight: true,
        roundBottomLeft: true,
        roundBottomRight: true,
      );
      chartStyle.TextStyle textStyle = chartStyle.TextStyle();
      textStyle.color = charts.Color.white;
      textStyle.fontSize = 11;
      canvas.drawText(
          chartText.TextElement(tooltips[0]['title'], style: textStyle),
          (265 - 10.0 - 35).round(),
          (25.0 - 5).round());
      for (int i = 1; i < nowresult4_1![0].keys.length; i++) {
        if (tooltips[0]['subTitle$i'] == 'undefeated') {
          unit4_1 = 'undefeated';
        } else {
          unit4_1 =
              '${NumberFormat.compact().format(double.parse('${tooltips[0]['subTitle$i']}'))}';
        }
        canvas.drawText(
            chartText.TextElement(
                '${nowresult4_1![0].keys.elementAt(i)} : ' + '$unit4_1',
                style: textStyle),
            (265 - 10.0 - 35).round(),
            (13 + (i * 13) + 7).round());
      }
    }
  }
}

String? unit5_1;

class CustomCircleSymbolRenderer5 extends charts.CircleSymbolRenderer {
  final Size? size;
  CustomCircleSymbolRenderer5({this.size});

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
    var seen = Set<String>();
    List uniquelist =
        tooltips.where((student) => seen.add(student['title'])).toList();
    num tipTextLen = (tooltips[0]['title']).length;
    num rectWidth = bounds.width + tipTextLen * 8.3;
    num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;

    num left = bounds.left > (size?.width ?? 300) / 4
        ? (bounds.left > size!.width / 4
            ? bounds.left - rectWidth
            : bounds.left - rectWidth / 2)
        : bounds.left - 40;
    if (left > 128.04594594594593) {
      canvas.drawRRect(
        Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * (2 * uniquelist.length)),
        fill:
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
        radius: 10,
        roundTopLeft: true,
        roundTopRight: true,
        roundBottomLeft: true,
        roundBottomRight: true,
      );
      chartStyle.TextStyle textStyle = chartStyle.TextStyle();
      textStyle.color = charts.Color.white;
      textStyle.fontSize = 11;
      chartStyle.TextStyle textStyle1 = chartStyle.TextStyle();
      textStyle1.color = charts.Color.white;
      textStyle1.fontSize = 13;

      for (int i = 0; i < uniquelist.length; i++) {
        canvas.drawText(
            chartText.TextElement('-${uniquelist[i]['title']}',
                style: textStyle1),
            (110 - 10.0 - 35).round(),
            ((25.0 + (i * 26)) - 5).round());

        if (tooltips[i]['subTitle2'] == 'undefeated') {
          unit5_1 = 'undefeated';
        } else {
          unit5_1 =
              '${NumberFormat.compact().format(double.parse('${uniquelist[i]['subTitle2']}'))}';
        }
        canvas.drawText(
            chartText.TextElement(
                '${NumberFormat.compact().format(double.parse('${uniquelist[i]['subTitle1']}'))} : ' +
                    '$unit5_1',
                style: textStyle),
            (110 - 10.0 - 35).round(),
            (28 + (i * 26) + 7).round());
      }
    }
    if (left < 128.04594594594593) {
      canvas.drawRRect(
        Rectangle(265.0 - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * (2 * uniquelist.length)),
        fill:
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 105, 105, 105)),
        radius: 10,
        roundTopLeft: true,
        roundTopRight: true,
        roundBottomLeft: true,
        roundBottomRight: true,
      );
      chartStyle.TextStyle textStyle = chartStyle.TextStyle();
      textStyle.color = charts.Color.white;
      textStyle.fontSize = 11;
      chartStyle.TextStyle textStyle1 = chartStyle.TextStyle();
      textStyle1.color = charts.Color.white;
      textStyle1.fontSize = 13;

      for (int i = 0; i < uniquelist.length; i++) {
        canvas.drawText(
            chartText.TextElement('-${uniquelist[i]['title']}',
                style: textStyle1),
            (265 - 10.0 - 35).round(),
            ((25.0 + (i * 26)) - 5).round());

        if (uniquelist[i]['subTitle2'] == 'undefeated') {
          unit5_1 = 'undefeated';
        } else {
          unit5_1 =
              '${NumberFormat.compact().format(double.parse('${uniquelist[i]['subTitle2']}'))}';
        }
        canvas.drawText(
            chartText.TextElement(
                '${NumberFormat.compact().format(double.parse('${uniquelist[i]['subTitle1']}'))} : ' +
                    '$unit5_1',
                style: textStyle),
            (265 - 10.0 - 35).round(),
            (28 + (i * 26) + 7).round());
      }
    }
  }
}
