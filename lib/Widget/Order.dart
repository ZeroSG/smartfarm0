//หน้า Order


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'API_E_B/API_B.dart';
import 'API_E_B/API_E.dart';
import 'downloadExcel/download.dart';
import 'shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  String? Token; // Token
  int? farmnum; // farm id
  List<dynamic>? default_ship; // data default_ship
  List<dynamic>? default_unit; // data default_unit
  List<dynamic>? cmiid; //data cmiid
  int? id; //id user
  Order(
      {Key? key,
      this.Token,
      this.default_ship,
      this.default_unit,
      this.farmnum,
      this.cmiid,
      this.id})
      : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<dynamic>? NoList = [''];
  String? Noname = '';
  List<dynamic>? ColBg;
  late double screenW, screenH;
  int selected1 = 0;
  bool loading1 = true;
  bool loading0 = true;
  late TextEditingController Number1 = TextEditingController();
  late TextEditingController Remark1 = TextEditingController();

  late TextEditingController Number2 = TextEditingController();
  late TextEditingController Remark2 = TextEditingController();
  late TextEditingController Order_Ref = TextEditingController();

  Usersharedpreferences _p = Usersharedpreferences();
  late List<String>? Name_Crop = [''];
  late String? Name_Cropname = '';
  late List<dynamic>? Ship_Condition = widget.default_ship;
  late String? Ship_Conditionname = widget.default_ship![0]['code'];
  late String? Ship_Conditionnameedit = widget.default_ship![0]['code'];
  late List<dynamic>? Feed_Formula = [];
  late String? Feed_Formulaname;
  late String? Feed_Formulanameedit;
  late List<dynamic>? Unit = widget.default_unit;
  late String? Unitname = widget.default_unit![0]['name'];
  late String? Unitnameedit = widget.default_unit![0]['name'];

  List<dynamic> nowresult1_1 = [];
  List<dynamic> nowresultFeed = [];
  //API setting Feed
  Future<void> getFeed() async {
    try {
      loading0 = true;
      var urlsum =
          Uri.https("smartfarmpro.com", "/v1/api/setting/setting-feed");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{"Farm": widget.farmnum}));
      if (ressum.statusCode == 200) {
        var result1_1 = json.decode(ressum.body)['result']['view1'];

        setState(() {
          //  //print("Feed ===>$result1_1",);
          nowresultFeed = result1_1;
          Feed_Formula = nowresultFeed;
          Feed_Formulaname = nowresultFeed[0]["FEED"];

          loading0 = false;
        });
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  //API order_information
  Future<void> getjaon1_order_information() async {
    try {
      loading1 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/order/order-info");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": widget.farmnum,
            // "Date_Start": "2022-01-01",
            // "Date_End": "2022-01-31"
            "Date_Start": "${start!.year}-${start!.month}-${start!.day}",
            "Date_End": "${end!.year}-${end!.month}-${end!.day}"
          }));
      if (ressum.statusCode == 200) {
        var result1_1 = json.decode(ressum.body)['result']['view1'];

        setState(() {
          nowresult1_1 = result1_1;

          Number1.text = '0';
          ColBg = List.generate(nowresult1_1.length, (i) {
            return {"color": Color.fromARGB(255, 255, 255, 255)};
          });

          for (int i = 0; i < nowresult1_1.length; i++) {
            if (nowresult1_1[i]['n_confirm'] == 0) {
              if (nowresult1_1[i]['c_flag_api'] == 'Y') {
                ColBg![i]['color'] = Color.fromARGB(255, 241, 241, 241);
              } else if (nowresult1_1[i]['c_flag_api'] == 'N') {
                ColBg![i]['color'] = Color.fromARGB(255, 241, 241, 241);
              }
            } else if (nowresult1_1[i]['n_confirm'] == 1) {
              if (nowresult1_1[i]['c_flag_api'] == 'Y') {
                ColBg![i]['color'] = Color.fromARGB(255, 205, 255, 177);
              } else if (nowresult1_1[i]['c_flag_api'] == 'N') {
                ColBg![i]['color'] = Color.fromARGB(255, 255, 221, 221);
              }
            } else if (nowresult1_1[i]['n_confirm'] == 2) {
              if (nowresult1_1[i]['c_flag_api'] == 'Y') {
                ColBg![i]['color'] = Color.fromARGB(255, 241, 241, 241);
              } else if (nowresult1_1[i]['c_flag_api'] == 'N') {
                ColBg![i]['color'] = Color.fromARGB(255, 241, 241, 241);
              }
            }
            //  if(nowresult1_1[i]['n_confirm']==0&&nowresult1_1[i]['c_flag_api']=='N'){
            //   Col![i]['color'] = Color.fromARGB(255, 163, 163, 163);
            //  }
            //  else {
            //    //    if(nowresult1_1[i]['n_confirm']==1){
            //    if(nowresult1_1[i]['c_flag_api']=='Y'){
            //     Col![i]['color'] = Color.fromARGB(255, 115, 233, 119);
            //    }
            //   else if(nowresult1_1[i]['c_flag_api']=='N'){
            //     Col![i]['color'] = Colors.red;
            //    }
            // //  }
            //  }
            //  if(nowresult1_1[i]['n_confirm']==2&&nowresult1_1[i]['c_flag_api']=='N'){
            //   Col![i]['color'] = Color.fromARGB(255, 83, 83, 83);
            //  }

          }

          loading1 = false;
        });
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  late List<bool> valuefirst =
      List<bool>.generate(nowresult1_1.length, (i) => false);

  late DateTime? start = _selectedDateRange!.start;
  late var dayS = start!.day.toString().padLeft(2, '0');
  late var monthS = start!.month.toString().padLeft(2, '0');
  late var yearS = start!.year.toString().padLeft(4, '0');
  late DateTime? end = _selectedDateRange!.end;
  late var dayE = end!.day.toString().padLeft(2, '0');
  late var monthE = end!.month.toString().padLeft(2, '0');
  late var yearE = end!.year.toString().padLeft(4, '0');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFeed();
    getjaon1_order_information();

    var duration = Duration(seconds: 1);

    route() {
      Name_Crop = _p.getNameCrop();
      Name_Cropname = Name_Crop![0];
      print('Name_Crop $Name_Crop');
    }

    Timer(duration, route);
  }

  DateTimeRange? _selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 7)),
  );

  //ปฏิทิน
  Future pickDateRange(double W, double H) async {
    if (W > H) {
      DateTimeRange? newDateTimeRange = await showDateRangePicker(
        context: context,
        initialDateRange: _selectedDateRange,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
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

      if (newDateTimeRange == null) {
        setState(() {
          end = end;
          yearE = end!.day.toString().padLeft(2, '0');
          monthE = end!.month.toString().padLeft(2, '0');
          dayE = end!.year.toString().padLeft(4, '0');
          start = start;
          yearS = start!.day.toString().padLeft(2, '0');
          monthS = start!.month.toString().padLeft(2, '0');
          dayS = start!.year.toString().padLeft(4, '0');
        });
      } else {
        setState(() {
          _selectedDateRange = newDateTimeRange;
          end = newDateTimeRange.end;
          yearS = newDateTimeRange.start.day.toString().padLeft(2, '0');
          monthS = newDateTimeRange.start.month.toString().padLeft(2, '0');
          dayS = newDateTimeRange.start.year.toString().padLeft(4, '0');
          start = newDateTimeRange.start;
          yearE = newDateTimeRange.end.day.toString().padLeft(2, '0');
          monthE = newDateTimeRange.end.month.toString().padLeft(2, '0');
          dayE = newDateTimeRange.end.year.toString().padLeft(4, '0');
          getjaon1_order_information();
        });
      }
    } else {
      showCustomDateRangePicker(
        context,
        dismissible: false,
        minimumDate: DateTime(DateTime.now().year - 5),
        maximumDate: DateTime(DateTime.now().year + 5),
        endDate: end,
        startDate: start,
        onApplyClick: (start1, end1) {
          setState(() {
            end = end1;
            yearS = start1.day.toString().padLeft(2, '0');
            monthS = start1.month.toString().padLeft(2, '0');
            dayS = start1.year.toString().padLeft(4, '0');
            start = start1;
            yearE = end1.day.toString().padLeft(2, '0');
            monthE = end1.month.toString().padLeft(2, '0');
            dayE = end1.year.toString().padLeft(4, '0');
            getjaon1_order_information();
          });
        },
        onCancelClick: () {
          setState(() {
            end = end;
            yearE = end!.day.toString().padLeft(2, '0');
            monthE = end!.month.toString().padLeft(2, '0');
            dayE = end!.year.toString().padLeft(4, '0');
            start = start;
            yearS = start!.day.toString().padLeft(2, '0');
            monthS = start!.month.toString().padLeft(2, '0');
            dayS = start!.year.toString().padLeft(4, '0');
          });
        },
      );
    }

    // DateTimeRange? newDateRange = await showDateRangePicker(
    //   context: context,
    //   initialDateRange: _selectedDateRange,
    //    firstDate: DateTime(DateTime.now().year - 5),
    //    lastDate: DateTime(DateTime.now().year + 5),
    // );

    // setState(() {
    //   _selectedDateRange = newDateRange ?? _selectedDateRange;
    // });
  }

  //DialogOrde Edit Order
  Future<dynamic> DialogOrder1(BuildContext context, int index, bool by) {
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
                              // height: screenH * 0.04,
                              child: Text(
                                'Create Order',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff44bca3)),
                              )),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
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
                      Order_Ref1(setState, index),
                      dateTime2(setState, index, by),
                      Name_Crop3(setState, index),
                      Ship_Feed4(setState, index, by),
                      Number_Unit5(setState, index, by),
                      Remark6(setState, index, by),
                      Save7(setState, by, index)
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

  //ปุ่ม Save Edit
  Container Save7(StateSetter setState, bool by, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
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
                if (by == true) {
                  Navigator.pop(context);
                } else {
                  // print('=======1=========');
                  // print(widget.Token);
                  // print(widget.farmnum);
                  // print(Order_Ref.text);
                  // print("$Start");
                  // print('$End');
                  API_edit_order_edit(
                      widget.Token,
                      widget.farmnum,
                      Order_Ref.text,
                      "$Start",
                      '$End',
                      nowresult1_1[index]['c_name_crop'],
                      Ship_Conditionnameedit,
                      Feed_Formulanameedit,
                      int.parse(Number2.text),
                      Unitnameedit,
                      Remark2.text,
                      widget.id);
                  getjaon1_order_information();
                  // Navigator.pop(context);
                }
                // print('=======2=========');

                // print(nowresult1_1[index]['c_name_crop']);
                // print(Ship_Conditionnameedit);
                // print(Feed_Formulanameedit);
                // print(Number2.text);

                // print(Unitnameedit);
                // print(Remark2.text);
                // print(widget.id);
              },
              child: Text(
                'Save',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Edit Remark
  Container Remark6(StateSetter setState, int index, bool by) {
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
                      'Remark :',
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
                    color: Colors.white,
                  ),
                  height: 40,
                  width: screenW * 0.75,
                  child: TextField(
                    controller: Remark2,
                    readOnly: by,
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

  //Edit Number and Unit
  Container Number_Unit5(StateSetter setState, int index, bool by) {
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
                      'Number :',
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
                      color: Colors.white),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    controller: Number2,
                    readOnly: by,
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
                      'Unit :',
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
                      color: Colors.white),
                  height: 40,
                  width: screenW * 0.35,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: by
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${nowresult1_1[index]['c_unit']}'),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 78, 78, 78),
                                size: 28,
                              ),
                            ],
                          )
                        : DropdownButtonHideUnderline(
                            child: widget.default_unit == null
                                ? DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down_circle,
                                      size: 20,
                                    ),
                                    value: Noname,
                                    items: NoList!
                                        .map((NoView_by) =>
                                            DropdownMenuItem<String>(
                                                value: NoView_by,
                                                child: Text(
                                                  NoView_by,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 25, 25, 25),
                                                  ),
                                                )))
                                        .toList(),
                                    onChanged: (NoView_by) {
                                      setState(() {});
                                    })
                                : DropdownButton<String>(
                                    // value:nowresult1_1[index]['c_feedtype'] == null ? Standardname: nowresult1_1[index]['c_feedtype'],
                                    value: Unitnameedit,
                                    items: Unit!
                                        .map((Unit) => DropdownMenuItem<String>(
                                            value: Unit['name'],
                                            child: Text(
                                              Unit['name'],
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: Color.fromARGB(
                                                    255, 25, 25, 25),
                                              ),
                                            )))
                                        .toList(),
                                    onChanged: (Unit) {
                                      setState(() {
                                        Unitnameedit = Unit!;
                                      });
                                    }),
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

  //Edit Ship and Feed
  Container Ship_Feed4(StateSetter setState, int index, bool by) {
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
                      'Ship Condition :',
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
                      color: Colors.white),
                  height: 40,
                  width: screenW * 0.35,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: by
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${nowresult1_1[index]['c_ship_cond']}'),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 78, 78, 78),
                                size: 28,
                              ),
                            ],
                          )
                        : DropdownButtonHideUnderline(
                            child: widget.default_ship == null ||
                                    Ship_Condition == null
                                ? DropdownButton<String>(
                                    value: Noname,
                                    items: NoList!
                                        .map((NoView_by) =>
                                            DropdownMenuItem<String>(
                                                value: NoView_by,
                                                child: Text(
                                                  NoView_by,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 25, 25, 25),
                                                  ),
                                                )))
                                        .toList(),
                                    onChanged: (NoView_by) {
                                      setState(() {});
                                    })
                                : DropdownButton<String>(
                                    // value:nowresult1_1[index]['c_feedtype'] == null ? Standardname: nowresult1_1[index]['c_feedtype'],
                                    value: Ship_Conditionnameedit,
                                    items: Ship_Condition!
                                        .map((Ship_Condition) =>
                                            DropdownMenuItem<String>(
                                                value: Ship_Condition['code'],
                                                child: Text(
                                                  Ship_Condition['code'],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 25, 25, 25),
                                                  ),
                                                )))
                                        .toList(),
                                    onChanged: (Ship_Condition) {
                                      setState(() {
                                        Ship_Conditionnameedit =
                                            Ship_Condition!;
                                      });
                                    }),
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
                      'Feed Formula :',
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
                      color: Colors.white),
                  height: 40,
                  width: screenW * 0.35,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: by
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${nowresult1_1[index]['c_formula']}'),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 78, 78, 78),
                                size: 28,
                              ),
                            ],
                          )
                        : DropdownButtonHideUnderline(
                            child: Feed_Formula == null
                                ? DropdownButton<String>(
                                    value: Noname,
                                    items: NoList!
                                        .map((NoView_by) =>
                                            DropdownMenuItem<String>(
                                                value: NoView_by,
                                                child: Text(
                                                  NoView_by,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 25, 25, 25),
                                                  ),
                                                )))
                                        .toList(),
                                    onChanged: (NoView_by) {
                                      setState(() {});
                                    })
                                : DropdownButton<String>(
                                    value: Feed_Formulanameedit,
                                    items: Feed_Formula!
                                        .map((Feed_Formula) =>
                                            DropdownMenuItem<String>(
                                                value: Feed_Formula['FEED'],
                                                child: Text(
                                                  Feed_Formula['FEED'],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 25, 25, 25),
                                                  ),
                                                )))
                                        .toList(),
                                    onChanged: (Feed_Formula) {
                                      setState(() {
                                        Feed_Formulanameedit = Feed_Formula!;
                                      });
                                    }),
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

//Edit Name and Crop
  Container Name_Crop3(StateSetter setState, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.74,
            child: Column(children: [
              Container(
                width: screenW * 0.74,
                child: Text(
                  'Name Crop :',
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
                width: screenW * 0.74,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${nowresult1_1[index]['c_name_crop']}'),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromARGB(255, 78, 78, 78),
                          size: 28,
                        ),
                      ],
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

  DateTime? Start;
  DateTime? End;
  //ปฏิทิน Editเวลา เริ่มต้น
  Future<void> DateStart(StateSetter setState, int index) async {
    //  setState(() {
    //      dateTime_  = dateTime6;

    //    });
    DateTime? ChooseDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: Start!,
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
        Start = ChooseDateTime;
        //  dateTime6 = ChooseDateTime;
      });
    }
  }

  //ปฏิทิน Editเวลา สิ้นสุด
  Future<void> DateEnd(StateSetter setState, int index) async {
    DateTime? ChooseDateTime2 = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: End!,
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

    if (ChooseDateTime2 != null) {
      setState(() {
        End = ChooseDateTime2;
        //  Date_End.text  = ChooseDateTime2.toIso8601String();
        //  //print('dateTimeEnd  $dateTimeEnd');
        //  dateTime6 = ChooseDateTime;
      });
    }
  }

  // ปุ่ม กด ปฏิทิน  Editเริ่มต้น และ สิ้นสุด
  Container dateTime2(StateSetter setState, int index, bool by) {
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
                      'Order Date :',
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
                        border:
                            Border.all(color: Color(0xffcfcfcf), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    height: 40,
                    width: screenW * 0.35,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          if (by == true) {
                          } else {
                            DateStart(setState, index);
                          }
                          // DateStart(setState);
                        },
                        child: Text(
                          "${Start!.year}-${Start!.month}-${Start!.day}",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 25, 25, 25),
                          ),
                        ),
                      ),
                    ))
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
                      'Filling Date :',
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
                        border:
                            Border.all(color: Color(0xffcfcfcf), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    height: 40,
                    width: screenW * 0.35,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          if (by == true) {
                          } else {
                            DateEnd(setState, index);
                          }
                          //  DateEnd(setState);
                        },
                        child: Text(
                          "${End!.year}-${End!.month}-${End!.day}",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 25, 25, 25),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

// EditOrder and Ref
  Container Order_Ref1(StateSetter setState, int index) {
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
                      'Order Ref :',
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
                    color: Colors.white,
                  ),
                  height: 40,
                  width: screenW * 0.75,
                  child: TextField(
                    controller: Order_Ref,
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

  DateTime? dateTimeStart = DateTime.now();
  DateTime? dateTimeEnd = DateTime.now().add(Duration(days: 3));

  //ปฏิทิน Start
  Future<void> TimeStart(StateSetter setState) async {
    DateTime? ChooseDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: dateTimeStart!,
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
        dateTimeStart = ChooseDateTime;
        //  dateTime6 = ChooseDateTime;
      });
    }
  }

  //ปฏิทิน End
  Future<void> TimeEnd(StateSetter setState) async {
    DateTime? ChooseDateTime2 = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: dateTimeEnd!,
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

    if (ChooseDateTime2 != null) {
      setState(() {
        dateTimeEnd = ChooseDateTime2;
        //  Date_End.text  = ChooseDateTime2.toIso8601String();
        //  //print('dateTimeEnd  $dateTimeEnd');
        //  dateTime6 = ChooseDateTime;
      });
    }
  }

  //DialogOrde Create Order
  Future<dynamic> DialogOrder(BuildContext context) {
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
                              child: Text(
                                'Create Order',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff44bca3)),
                              )),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
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
                      dateTime1(setState),
                      Name_Crop2(setState),
                      Ship_Feed3(setState),
                      Number_Unit4(setState),
                      Remark5(setState),
                      Save6(setState)
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

  //ปุ่ม Save
  Container Save6(StateSetter setState) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
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
                //  print('=======1=========');
                //  print('1=${widget.Token}');
                //  print('2=${widget.farmnum}');

                DateTime? dateTimeStart0 = DateTime.parse(
                    "${dateTimeStart!.year.toString().padLeft(4, '0')}-${dateTimeStart!.month.toString().padLeft(2, '0')}-${dateTimeStart!.day.toString().padLeft(2, '0')}");
                DateTime? dateTimeEnd0 = DateTime.parse(
                    "${dateTimeEnd!.year.toString().padLeft(4, '0')}-${dateTimeEnd!.month.toString().padLeft(2, '0')}-${dateTimeEnd!.day.toString().padLeft(2, '0')}");
                //        print("3=$dateTimeStart0");
                //  print('4=$dateTimeEnd0');
                //    print('=======2=========');
                //  print('5=$Name_Cropname');
                //  print('6=$Ship_Conditionname');
                //  print('7=$Feed_Formulaname');
                //  print('8=${Number1.text}');
                //  print('9=$Unitname');
                //  print('10=${Remark1.text}');
                //  print('11=${widget.id}');
                API_edit_order_create(
                    widget.Token,
                    widget.farmnum,
                    "$dateTimeStart0",
                    "$dateTimeEnd0",
                    Name_Cropname,
                    Ship_Conditionname,
                    Feed_Formulaname,
                    Number1.text,
                    Unitname,
                    Remark1.text,
                    widget.id);

                var duration = Duration(seconds: 2);

                Navigator.pop(context);

                route() {
                  getjaon1_order_information();
                }

                Timer(duration, route);
              },
              child: Text(
                'Save',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Remark
  Container Remark5(StateSetter setState) {
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
                      'Remark :',
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
                    color: Colors.white,
                  ),
                  height: 40,
                  width: screenW * 0.75,
                  child: TextField(
                    controller: Remark1,
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

  // Number and Unit
  Container Number_Unit4(StateSetter setState) {
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
                      'Number :',
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
                      color: Colors.white),
                  height: 40,
                  width: screenW * 0.35,
                  child: TextField(
                    controller: Number1,
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
                      'Unit :',
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
                      color: Colors.white),
                  height: 40,
                  width: screenW * 0.35,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButtonHideUnderline(
                      child: widget.default_unit == null
                          ? DropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down_circle,
                                size: 20,
                              ),
                              value: Noname,
                              items: NoList!
                                  .map((NoView_by) => DropdownMenuItem<String>(
                                      value: NoView_by,
                                      child: Text(
                                        NoView_by,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color:
                                              Color.fromARGB(255, 25, 25, 25),
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (NoView_by) {
                                setState(() {});
                              })
                          : DropdownButton<String>(
                              // value:nowresult1_1[index]['c_feedtype'] == null ? Standardname: nowresult1_1[index]['c_feedtype'],
                              value: Unitname,
                              items: Unit!
                                  .map((Unit) => DropdownMenuItem<String>(
                                      value: Unit['name'],
                                      child: Text(
                                        Unit['name'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserrat',
                                          color:
                                              Color.fromARGB(255, 25, 25, 25),
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (Unit) {
                                setState(() {
                                  Unitname = Unit!;
                                });
                              }),
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

  // Ship and Feed
  Container Ship_Feed3(StateSetter setState) {
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
                      'Ship Condition :',
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
                      color: Colors.white),
                  height: 40,
                  width: screenW * 0.35,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButtonHideUnderline(
                      child: widget.default_ship == null
                          ? DropdownButton<String>(
                              value: Noname,
                              items: NoList!
                                  .map((NoView_by) => DropdownMenuItem<String>(
                                      value: NoView_by,
                                      child: Text(
                                        NoView_by,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color:
                                              Color.fromARGB(255, 25, 25, 25),
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (NoView_by) {
                                setState(() {});
                              })
                          : DropdownButton<String>(
                              // value:nowresult1_1[index]['c_feedtype'] == null ? Standardname: nowresult1_1[index]['c_feedtype'],
                              value: Ship_Conditionname,
                              items: Ship_Condition!
                                  .map((Ship_Condition) =>
                                      DropdownMenuItem<String>(
                                          value: Ship_Condition['code'],
                                          child: Text(
                                            Ship_Condition['code'],
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              color: Color.fromARGB(
                                                  255, 25, 25, 25),
                                            ),
                                          )))
                                  .toList(),
                              onChanged: (Ship_Condition) {
                                setState(() {
                                  Ship_Conditionname = Ship_Condition!;
                                });
                              }),
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
                      'Feed Formula :',
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
                      color: Colors.white),
                  height: 40,
                  width: screenW * 0.35,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButtonHideUnderline(
                      child: Feed_Formula == null
                          ? DropdownButton<String>(
                              value: Noname,
                              items: NoList!
                                  .map((NoView_by) => DropdownMenuItem<String>(
                                      value: NoView_by,
                                      child: Text(
                                        NoView_by,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color:
                                              Color.fromARGB(255, 25, 25, 25),
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (NoView_by) {
                                setState(() {});
                              })
                          : DropdownButton<String>(
                              value: Feed_Formulaname,
                              items: Feed_Formula!
                                  .map((Feed_Formula) =>
                                      DropdownMenuItem<String>(
                                          value: Feed_Formula['FEED'],
                                          child: Text(
                                            Feed_Formula['FEED'],
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              color: Color.fromARGB(
                                                  255, 25, 25, 25),
                                            ),
                                          )))
                                  .toList(),
                              onChanged: (Feed_Formula) {
                                setState(() {
                                  Feed_Formulaname = Feed_Formula!;
                                });
                              }),
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

// Name and Crop
  Container Name_Crop2(StateSetter setState) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenW * 0.74,
            child: Column(children: [
              Container(
                width: screenW * 0.74,
                child: Text(
                  'Name Crop :',
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
                      child: Name_Crop == null
                          ? DropdownButton<String>(
                              value: Noname,
                              items: NoList!
                                  .map((NoView_by) => DropdownMenuItem<String>(
                                      value: NoView_by,
                                      child: Text(
                                        NoView_by,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color:
                                              Color.fromARGB(255, 25, 25, 25),
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (NoView_by) {
                                setState(() {});
                              })
                          : DropdownButton<String>(
                              value: Name_Cropname,
                              items: Name_Crop!
                                  .map((Name_Crop) => DropdownMenuItem<String>(
                                      value: Name_Crop,
                                      child: Text(
                                        Name_Crop,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserrat',
                                          color:
                                              Color.fromARGB(255, 25, 25, 25),
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (Name_Crop) {
                                setState(() {
                                  Name_Cropname = Name_Crop!;
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

  // ปุ่ม กด ปฏิทิน  เริ่มต้น และ สิ้นสุด
  Container dateTime1(StateSetter setState) {
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
                      'Order Date :',
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
                        border:
                            Border.all(color: Color(0xffcfcfcf), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    height: 40,
                    width: screenW * 0.35,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          TimeStart(setState);
                        },
                        child: Text(
                          "${dateTimeStart!.year}-${dateTimeStart!.month}-${dateTimeStart!.day}",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 25, 25, 25),
                          ),
                        ),
                      ),
                    ))
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
                      'Filling Date :',
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
                        border:
                            Border.all(color: Color(0xffcfcfcf), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    height: 40,
                    width: screenW * 0.35,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          TimeEnd(setState);
                        },
                        child: Text(
                          "${dateTimeEnd!.year}-${dateTimeEnd!.month}-${dateTimeEnd!.day}",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 25, 25, 25),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Confirm Order',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          color: Color(0xff44bca3)),
                    ),
                    Row(
                      children: [
                        Text(
                          'Date : ',
                          style: TextStyle(
                              fontSize: 18,
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
                          height: 50,
                          width: 170,
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                pickDateRange(screenW, screenH);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    '${dayS}/${monthS}/${yearS}',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  Text(
                                    "-",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  Text(
                                    '${dayE}/${monthE}/${yearE}',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
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
                      margin: EdgeInsets.only(top: 5, right: 10, bottom: 10),
                      child: TextButton(
                        onPressed: () {
                          saveExcelAgeinformation(nowresult1_1, 'OrderAPI');
                          // for(int i = 0;i<valuefirst.length;i++){
                          //   if(valuefirst[i]==true){
                          //     //print('valuefirst[$i] ====>${valuefirst[i]}');
                          //   }
                          // }
                        },
                        child: Text(
                          'Download',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
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
                          height: 32,
                          width: 32,
                          margin: EdgeInsets.only(top: 5, right: 2, bottom: 10),
                          child: TextButton(
                            onPressed: () {
                              DialogOrder(context);
                            },
                            child: Text(
                              '+',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 255, 255, 255)),
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
                          height: 32,
                          width: 230,
                          margin:
                              EdgeInsets.only(top: 5, right: 10, bottom: 10),
                          child: TextButton(
                            onPressed: () {
                              API_button_order_send(
                                  widget.Token, widget.farmnum, widget.id);
                            },
                            child: Text(
                              'Confirm Order & Send API Now!',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              loading1
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      height: screenH * 0.57,
                      child: Center())
                  : Card(
                      elevation: 10,
                      child: nowresult1_1 == null
                          ? Text('')
                          : Column(
                              children: [
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: nowresult1_1.length,
                                    key:
                                        Key('builder2 ${selected1.toString()}'),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: ColBg![index]['color']!,
                                        child: Order1(index),
                                        // child: Text('index'),
                                      );
                                    }),
                              ],
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? OOO1;
  DateTime? OOO2;
  // รายการ Order
  Order1(int index) {
    DateTime? From;
    DateTime? To;

    if (nowresult1_1[index]['c_preorder'] == null) {
      From = null;
    } else {
      From = DateTime.parse('${nowresult1_1[index]['c_preorder']}');
    }
    if (nowresult1_1[index]['c_getorder'] == null) {
      To = null;
    } else {
      To = DateTime.parse('${nowresult1_1[index]['c_getorder']}');
    }

    Start = DateTime.parse('${nowresult1_1[index]['c_preorder']}');
    OOO1 = DateTime.now();
    OOO2 = DateTime.parse(
        '${OOO1!.year.toString().padLeft(4, '0')}-${OOO1!.month.toString().padLeft(2, '0')}-${OOO1!.day.toString().padLeft(2, '0')}');

    return Container(
      child: ExpansionTile(
        iconColor: Colors.black,
        childrenPadding: EdgeInsets.all(0).copyWith(top: 0),
        backgroundColor: ColBg![index]['color']!,
        maintainState: true,
        key: Key(index.toString()),
        initiallyExpanded: index == selected1,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              IconButtonXedit(index),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  From == null
                      ? Text(
                          "",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: Color(0xff7b7b7b),
                          ),
                        )
                      : Text(
                          'Date: ${From.year}-${From.month}-${From.day}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            color: Color(0xff7b7b7b),
                          ),
                        ),
                  To == null
                      ? Text(
                          "",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: Color(0xff7b7b7b),
                          ),
                        )
                      : Text(
                          'Filling Date: ${To.year}-${To.month}-${To.day}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            color: Color(0xff7b7b7b),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Reference :',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Color(0xff7b7b7b),
                      ),
                    ),
                    Text(
                      '${nowresult1_1[index]['c_order_refer']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Color(0xff7b7b7b),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Feed: ${nowresult1_1[index]['c_formula']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Color(0xff7b7b7b),
                      ),
                    ),
                    Text(
                      'Uint: ${nowresult1_1[index]['c_unit']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Color(0xff7b7b7b),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 0, 0, 0)),
        ],
      ),
    );
  }

  // ปุ่มกด
  Row IconButtonXedit(int index) {
    if (Start!.compareTo(OOO2!) < 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Start = DateTime.parse('${nowresult1_1[index]['c_preorder']}');
              End = DateTime.parse('${nowresult1_1[index]['c_getorder']}');
              Order_Ref.text = nowresult1_1[index]['c_order_refer'];
              Ship_Conditionnameedit = '${nowresult1_1[index]['c_ship_cond']}';
              Feed_Formulanameedit = '${nowresult1_1[index]['c_formula']}';
              //  Feed_Formulanameedit =  ' ';
              Unitnameedit = '${nowresult1_1[index]['c_unit']}';
              Number2.text = '${nowresult1_1[index]['n_plan_order']}';
              Remark2.text = nowresult1_1[index]['c_remark'];
              DialogOrder1(context, index, true);
            },
            icon: Icon(
              MdiIcons.squareEditOutline,
              color: Color(0xff44bca3),
              size: 22,
            ),
          )
        ],
      );
    }
    if ((nowresult1_1[index]['n_confirm'] == 0) &&
        Start!.compareTo(OOO2!) >= 0) {
      return Row(
        children: [
          IconButton(
            onPressed: () {
              Start = DateTime.parse('${nowresult1_1[index]['c_preorder']}');
              End = DateTime.parse('${nowresult1_1[index]['c_getorder']}');
              Order_Ref.text = nowresult1_1[index]['c_order_refer'];
              Ship_Conditionnameedit = '${nowresult1_1[index]['c_ship_cond']}';
              Feed_Formulanameedit = '${nowresult1_1[index]['c_formula']}';
              //  Feed_Formulanameedit =  ' ';
              Unitnameedit = '${nowresult1_1[index]['c_unit']}';
              Number2.text = '${nowresult1_1[index]['n_plan_order']}';
              Remark2.text = nowresult1_1[index]['c_remark'];
              DialogOrder1(context, index, false);
            },
            icon: Icon(
              MdiIcons.squareEditOutline,
              color: Color(0xff44bca3),
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {
              //       print('${widget.id}');
              // print('${nowresult1_1[index]['c_order_refer']}');
              API_button_order_confirm(widget.Token, widget.farmnum, widget.id,
                  '${nowresult1_1[index]['c_order_refer']}');
              var duration = Duration(seconds: 1);

              route() {
                getjaon1_order_information();
              }

              Timer(duration, route);
            },
            icon: Icon(
              Icons.check,
              color: Color.fromARGB(255, 3, 242, 23),
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {
              //  print('${widget.id}');
              // print('${nowresult1_1[index]['c_order_refer']}');
              API_button_order_cancel(widget.Token, widget.farmnum, widget.id,
                  '${nowresult1_1[index]['c_order_refer']}');
              var duration = Duration(seconds: 1);

              route() {
                getjaon1_order_information();
              }

              Timer(duration, route);
            },
            icon: Icon(
              Icons.close,
              color: Color.fromARGB(255, 242, 3, 3),
              size: 22,
            ),
          )
        ],
      );
    }
    if ((nowresult1_1[index]['n_confirm'] == 1)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              //      print('${widget.id}');
              // print('${nowresult1_1[index]['c_order_refer']}');
              API_button_order_cancel(widget.Token, widget.farmnum, widget.id,
                  '${nowresult1_1[index]['c_order_refer']}');
              var duration = Duration(seconds: 1);

              route() {
                getjaon1_order_information();
              }

              Timer(duration, route);
            },
            icon: Icon(
              Icons.close,
              color: Color.fromARGB(255, 242, 3, 3),
              size: 22,
            ),
          )
        ],
      );
    }
    if ((nowresult1_1[index]['n_confirm'] == 2)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              //      print('${widget.id}');
              // print('${nowresult1_1[index]['c_order_refer']}');
              API_button_order_confirm(widget.Token, widget.farmnum, widget.id,
                  '${nowresult1_1[index]['c_order_refer']}');

              var duration = Duration(seconds: 1);

              route() {
                getjaon1_order_information();
              }

              Timer(duration, route);
            },
            icon: Icon(
              Icons.check,
              color: Color.fromARGB(255, 3, 242, 23),
              size: 22,
            ),
          )
        ],
      );
    }

    //     if(End!.compareTo(DateTime.now()) > 0){
    //        print("น้อยกว่า $End");
    //     }
    //     if(End!.compareTo(DateTime.now()) == 0){
    //        print("เท่ากัน");
    //     }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            if (nowresult1_1[index]['n_confirm'] != 0) {}
            DialogOrder1(context, index, true);
          },
          icon: Icon(
            MdiIcons.squareEditOutline,
            color: Color.fromARGB(255, 3, 242, 23),
            size: 22,
          ),
        )
      ],
    );
  }
}
