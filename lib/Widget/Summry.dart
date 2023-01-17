import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:intl/intl.dart';



import 'DB/SummaryDb.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:charts_flutter/src/text_element.dart' as chartText;
import 'package:charts_flutter/src/text_style.dart' as chartStyle;

import 'downloadExcel/download.dart';
import 'shared_preferences/shared_preferences.dart';

class Summary extends StatefulWidget {
  String? Token;
  Widget? child;
  List<dynamic>? sex;
  List<dynamic>? type;
  List<dynamic>? View_by;
  int? farmnum, cropnum2;
  Summary(
      {Key? key,
      this.child,
      this.Token,
      this.sex,
      this.type,
      this.View_by,
      this.cropnum2,
      this.farmnum})
      : super(key: key);
  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  UniqueKey? K1;
  UniqueKey? K2;
  late double _time = 1;
  late Map<String, Map<String, double>> _measures;
  TextEditingController _Numder = TextEditingController();

  bool Age = true;
  bool Daily = false;
  List<double> D = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
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
    Color.fromARGB(255, 125, 193, 202),
    Color.fromARGB(255, 143, 126, 221),
    Color.fromARGB(255, 65, 173, 101),
    Color.fromARGB(255, 183, 167, 255),
    Color.fromARGB(255, 247, 31, 92),
    Color.fromARGB(255, 226, 255, 99),
    Color.fromARGB(255, 138, 215, 22)
  ];
  List<Color> C2 = [
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
    Color.fromARGB(255, 125, 193, 202),
    Color.fromARGB(255, 143, 126, 221),
    Color.fromARGB(255, 65, 173, 101),
    Color.fromARGB(255, 183, 167, 255),
    Color.fromARGB(255, 247, 31, 92),
    Color.fromARGB(255, 226, 255, 99),
    Color.fromARGB(255, 138, 215, 22)
  ];
  // List<String> sex = [];
  late String? ssex = widget.sex![0]['name'];
  late String? stype = widget.type![0]['name'];
  late String? sView_by = widget.View_by![0]['name'];
  late int num1 = widget.type![0]['id'];
  late int num2 = widget.View_by![6]['id'];
  late String sGraph = 'กราฟเส้นแบบเป็นเห็นทั้งหมด';
  List<String> Graph = [
    'กราฟเส้นแบบเป็นเห็นทั้งหมด',
    'กราฟเส้นแบบเลื่อนได้',
  ];
  List<dynamic>? NoList = [''];
  String? Noname = '';
  var linesalesdata0;
  var linesalesdata1;
  var linesalesdata2;
  var linesalesdata3;
  var linesalesdata4;
  var linesalesdata5;

  bool loading = true;
  bool loading2 = true;
  late SummaryDb _summaryDb;

  late List<Map<String, double>> result1 = [];

  // late List<dynamic> result11 = [];
  late String null1;
  late String null2;
  late List<dynamic> result2;
  var numberL;
  late List<Map<String, double>> result3;
  late int T1, T2, T3;
  late List<int> T1_2, T2_2, T3_2;
  List<String> result2_1 = [];

  Future<void> getjaon_summary_age_information() async {
    try {
      null1 = '';
      loading = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/summary/age-info");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "farm": widget.farmnum,
            "crop": widget.cropnum2,
            "formula": Formulaname,
            "view1": num1
          }));
      if (ressum.statusCode == 200) {
        _summaryDb = summaryDbFromJson(ressum.body);

        setState(() {
          result1 = _summaryDb.result!.view1!;
          loading = false;
        });

      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      print('e ===> ${e.toString()} ');
      if (e.toString() == "Exception: Failed to download") {
        setState(() {
          null1 = "ไม่มีค่า";
          loading = true;
        });
      }
    }
  }

  Future<void> getjaon2_daily_information() async {
    try {
   
      null2 = '';
      loading2 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/summary/daily-info");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "farm": widget.farmnum,
            "crop": widget.cropnum2,
            "view1": num2
          }));
      if (ressum.statusCode == 200) {

        var result11 = json.decode(ressum.body)['result']['view1'];
        setState(() {
          result2 = result11;
          loading2 = false;
        });

        // //print('index1========${result2.asMap().keys.toList()}');
        // for(int j = 0;j<result2.length;j++){

        //     late int index1 = result2.indexWhere(((result) => result[j]['n_day'] == result[j]['n_day']));
        //     setState(() {
        //       num = index1;
        //     });
        //     //print('num======> $num');
        //     //print('index1======> $index1');
        // }

      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {
      print('e ===> ${e.toString()} ');
      if (e.toString() == "Exception: Failed to download") {
        setState(() {
            null2 = "ไม่มีค่า";
            loading2 = true;

        });

        //print('e ===> $null1 ');
      }
    }
  }

  List<charts.Series<Map<String, double>, double>> _createSampleData() {
    for (int j = 0; j < widget.sex!.length; j++) {
      if (ssex == widget.sex![j]['name']) {
        return [
          for (int i = 0; i < result1[0].keys.length; i++)
            if (result1[0].keys.elementAt(i) != 'day')
              charts.Series<Map<String, double>, double>(
                colorFn: (__, _) => charts.ColorUtil.fromDartColor(C[i]),
                id: '${result1[0].keys.elementAt(i)}',
                data: result1,
                domainFn: (Map<String, double> result0, _) => result0['day']!,
                measureFn: (Map<String, double> result0, _) =>
                    result0['${result1[0].keys.elementAt(i)}'] ?? null,
              ),
        ];
      }
    }
    return [];
  }

  List<charts.Series<dynamic, String>> _createSampleData1() {
    for (int j = 0; j < widget.View_by!.length; j++) {
      if (sView_by == widget.View_by![j]['name']) {
        return [
          for (int i = 0; i < result2[0].keys.length; i++)
            if (result2[0].keys.elementAt(i) != 'n_day' &&
                result2[0].keys.elementAt(i) != 'day')
              charts.Series<dynamic, String>(
                colorFn: (__, _) => charts.ColorUtil.fromDartColor(C2[i]),
                id: '${result2[0].keys.elementAt(i)}',
                data: result2,
                domainFn: (dynamic daily20, _) =>
                    daily20['day'] ?? daily20['n_day'],
                measureFn: (dynamic daily20, _) =>
                    daily20['${result2[0].keys.elementAt(i)}'] ?? null,
                // daily20['${result2[0].keys.elementAt(1)}'] ?? null,
              )..setAttribute(charts.rendererIdKey, 'customLine'),
        ];
      }
    }
    return [];
  }

  ReceivePort _port = ReceivePort();
 Usersharedpreferences _p =Usersharedpreferences();
    late  List<String>? Formula = [];
   late String Formulaname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
     Formulaname = '';
    Formula =  _p.getformula();
    Formulaname = Formula![0];
    if (widget.cropnum2 != null) {
      getjaon_summary_age_information();
      getjaon2_daily_information();
    }

    // _createSampleData();
  }

  late double screenW, screenH;
  var size;
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    size = MediaQuery.of(context).size;
    if (widget.sex == null) {
    } else {

    }
    return Scaffold(
      body:
          // SingleChildScrollView(
          //   physics: BouncingScrollPhysics(),
          //   child:
        SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(child: build1(context)),
                        Card(child: build2(context)),
                      ],
                    ),
                  ),
                ),
      // ),
    );
  }

  Widget build1(BuildContext context) => ExpansionTile(
        // key: K2,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Age = false;
              // K1 = UniqueKey();
            });
          } else {
            setState(() {
              Age = true;
              // Daily = false;
              // K1 = UniqueKey();
            });
          }
        },
        initiallyExpanded: Age,
        title: Age? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Age lnformation',
              style: TextStyle(
                  fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
            ),
             Center(
                  child: Container(
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
                    margin: EdgeInsets.only(left: 10),
                    child: TextButton(
                      onPressed: () {
                        saveExcelAgeinformation(result1, 'Agelnformation');
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
                ),
          ],
        )
        : Text(
          'Age lnformation',
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          Age_lnformation(),
          widget.cropnum2 == null
              ? Container(
                  height:  250,
                  child: Center(
                      child: Text(
                    'No data to display.',
                    style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                  )),
                )
              : null1 == "ไม่มีค่า"
                  ? Container(
                      height:250,
                      child: Center(
                          child: Text(
                        'ไม่มีค่า',
                        style: TextStyle(fontSize: 18),
                      )))
                  : loading
                      ? CircularProgressIndicator()
                      : g(),
        ],
      );
  Widget build2(BuildContext context) => ExpansionTile(
        // key: K1,
        onExpansionChanged: (value) {
          if (value == false) {
            setState(() {
              Daily = false;
              // K2 = UniqueKey();
            });
          } else {
            setState(() {
              // Age = false;
              Daily = true;
              // K2 = UniqueKey();
            });
          }
        },
        initiallyExpanded: Daily,
        maintainState: true,
        title: Daily ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Information',
              style: TextStyle(
                  fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
            ),
            Center(
                  child: Container(
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
                    margin: EdgeInsets.only(left: 10),
                    child: TextButton(
                      onPressed: () {
                        saveExcelAgeinformation(result2, 'DailyInformation');
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
                ),
          ],
        )
        :Text(
          'Daily Information',
          style: TextStyle(
              fontSize: 15, fontFamily: 'Montserrat', color: Color(0xff44bca3)),
        ),
        children: [
          Daily_Information(),
          widget.cropnum2 == null
              ? Container(
                  height: 250,
                  child: Center(
                      child: Text(
                    'No data to display.',
                    style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                  )),
                )
              : null2 == "ไม่มีค่า"
                  ? Container(
                      height:250,
                      child: Center(
                          child: Text(
                        'ไม่มีค่า',
                        style: TextStyle(fontSize: 18),
                      )))
                  : loading2
                      ? CircularProgressIndicator()
                      : kg(),
       
        ],
      );

  Container kg() {
    var num = result2.length;
    if (sGraph == 'กราฟเส้นแบบเป็นเห็นทั้งหมด') {
      setState(() {
        num = result2.length;
      });
    }
    if (sGraph == 'กราฟเส้นแบบเลื่อนได้') {
      setState(() {
        num = 10;
      });
    }
   

    double? Number;

    if (result2.length < 100) {
      Number = result2.length / 15;
    }
    if (result2.length > 100) {
      Number = result2.length / 12;
    }
    String Number1 = Number!.toStringAsFixed(0);
    int Number2 = int.parse('$Number1');

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 250,
      child: charts.BarChart(
        _createSampleData1(),
        animate: false,

        defaultRenderer: new charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.stacked, strokeWidthPx: 2.0),

        animationDuration: Duration(seconds: 1),

        customSeriesRenderers: [
          new charts.LineRendererConfig(
              includeArea: true,
              includeLine: true,
              includePoints: false,
              strokeWidthPx: 1,
              customRendererId: 'customLine')
        ],
        selectionModels: [
          charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              updatedListener: (model) {},
              changedListener: (charts.SelectionModel model) {
                if (model.hasDatumSelection) {
                  selectedDatum1 = [];
                  for (int j = 0; j < widget.View_by!.length; j++) {
                    if (sView_by == widget.View_by![j]['name']) {
                      model.selectedDatum
                          .forEach((charts.SeriesDatum datumPair) {
                        selectedDatum1!.add({
                          'text':
                              '${datumPair.datum['day'] ?? datumPair.datum['n_day']}',
                          for (int i = 1; i < result2[0].keys.length; i++)
                            'text${i}':
                                '${datumPair.datum['${result2[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                        });
                      });
                    }
                  }
                }
                if (model.hasDatumSelection)
                  var selectedVal = model.selectedSeries[0]
                      .measureFn(model.selectedDatum[0].index)
                      .toString();
              })
        ],
        behaviors: [
          charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer1(
                size: size,
                sView_by: sView_by,
                result2: result2,
                View_by: widget.View_by,
                sizeW: screenW),
          ),
          new charts.ChartTitle(
            'Date',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: charts.TextStyleSpec(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: charts.MaterialPalette.black),
          ),
          new charts.ChartTitle(
            'kg.',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: charts.TextStyleSpec(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: charts.MaterialPalette.black),
          ),
          new charts.SelectNearest(
              eventTrigger: charts.SelectionTrigger.pressHold),
          new charts.PanAndZoomBehavior(),
          new charts.SeriesLegend(
            
            // legendDefaultMeasure: charts.LegendDefaultMeasure.average,
            // showMeasures: true,
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.black,
                fontFamily: 'Montserrat',
                fontSize: 11),
            // desiredMaxRows: 4,
            desiredMaxColumns: 3,
            cellPadding: EdgeInsets.symmetric(horizontal: screenW * 0.02),
            // horizontalFirst: false,
            // outsideJustification: charts.OutsideJustification.start,
            // cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          ),
        ],

        //       domainAxis: new charts.NumericAxisSpec(

        // tickProviderSpec: charts.BasicNumericTickProviderSpec(
        //   zeroBound: true,
        //   desiredTickCount: 10,
        // ),
        // renderSpec: new charts.GridlineRendererSpec(
        //     labelStyle: new charts.TextStyleSpec(

        //         fontSize: 13, color: charts.MaterialPalette.black),
        //     lineStyle: new charts.LineStyleSpec(
        //         color: charts.MaterialPalette.black))),

        domainAxis: charts.OrdinalAxisSpec(
          showAxisLine: false,
          renderSpec: charts.SmallTickRendererSpec(
            labelRotation: 50,
            labelStyle: new charts.TextStyleSpec(
                fontSize: 13,
                color: charts.MaterialPalette.black,
                fontFamily: 'Montserrat'),
          ),
          viewport: new charts.OrdinalViewport(result2[0]['day'], num),
          tickProviderSpec:
              charts.StaticOrdinalTickProviderSpec(<charts.TickSpec<String>>[
            new charts.TickSpec('${result2[0]['day'] ?? result2[0]['n_day']}',
                style: charts.TextStyleSpec(fontFamily: 'Montserrat')),
            for (int i = 0; i < result2.length; i++)
              if (i * Number2 > 0 && i * Number2 < result2.length)
                new charts.TickSpec(
                    '${result2[i * Number2]['day'] ?? result2[i * Number2]['n_day']}',
                    style: charts.TextStyleSpec(fontFamily: 'Montserrat')),
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
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 13, fontFamily: 'Montserrat'),
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),
      ),
    );
  }

  Container Daily_Information() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Center(
                    child: Container(
                  height: 40,
                  width: screenW * 0.40,
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
                        child: widget.View_by == null
                            ? DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: Noname,
                                items: NoList!
                                    .map(
                                        (NoView_by) => DropdownMenuItem<String>(
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
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                isExpanded: true,
                                value: sView_by,
                                items: widget.View_by!
                                    .map((View_by) => DropdownMenuItem<String>(
                                        value: View_by['name'],
                                        child: Text(
                                          View_by['name'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Montserrat',
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (View_by) {
                                  setState(() {
                                    // sView_by = View_by!;
                                    for (int i = 0;
                                        i < widget.View_by!.length;
                                        i++) {
                                      if (widget.View_by![i]['name'] ==
                                          View_by) {
                                        setState(() {
                                          num2 = widget.View_by![i]['id'];
                                          sView_by = View_by;
                                          getjaon2_daily_information();
                                        });
                                      }
                                    }
                                  });
                                }),
                      ),
                    ),
                  ),
                )),
                Center(
                    child: Container(
                  height: 40,
                  width: screenW * 0.40,
                  margin: EdgeInsets.only(left: 10),
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
                            icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                            isExpanded: true,
                            value: sGraph,
                            items:
                                Graph.map((Graph) => DropdownMenuItem<String>(
                                    value: Graph,
                                    child: Text(
                                      Graph,
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
                            }),
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
    // return Container(
    //      margin: EdgeInsets.only(top: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: [
    //                      Container(
    //               height: 40,
    //               width: screenW * 0.42,
    //               margin: EdgeInsets.only(top: 10, right: 10),
    //               child: DecoratedBox(
    //                 decoration: BoxDecoration(
    //                     color: Color(0xfff1f1f1),
    //                     border: Border.all(color: Color(0xffe0eaeb), width: 3),
    //                     borderRadius: BorderRadius.circular(50),
    //                     boxShadow: <BoxShadow>[
    //                       BoxShadow(
    //                           color: Color.fromRGBO(0, 0, 0, 0.57),
    //                           blurRadius: 5)
    //                     ]),
    //                 child: Padding(
    //                   padding: EdgeInsets.only(left: 10, right: 10),
    //                   child: DropdownButtonHideUnderline(
    //                     child: DropdownButton<String>(
    //                         isExpanded: true,
    //                         icon: Icon(
    //                           Icons.arrow_drop_down_circle,
    //                           size: 20,
    //                         ),
    //                         value: sView_by,
    //                         items:
    //                             widget.View_by!.map((View_by) => DropdownMenuItem<String>(
    //                                 value: View_by['name'],
    //                                 child: Text(
    //                                   View_by['name'],
    //                                   style: TextStyle(
    //                                     fontSize: 14,
    //                                     // fontWeight: FontWeight.bold,
    //                                     fontFamily: 'Montserrat',
    //                                     color: Color.fromARGB(255, 25, 25, 25),
    //                                   ),
    //                                 ))).toList(),
    //                         onChanged: (View_by) {
    //                           setState(() {
    //                             // sView_by = View_by!;
    //                             for(int i = 0;i<widget.View_by!.length;i++){
    //                                 if(widget.View_by![i]['name'] == View_by){
    //                                  setState(() {
    //                                   num2 = widget.View_by![i]['id'];
    //                                   sView_by = View_by;
    //                                   getjaon2();
    //                                 });
    //                                 }}
    //                           });
    //                         }),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //                     Container(
    //               height: 40,
    //               width: screenW * 0.42,
    //               margin: EdgeInsets.only(top: 10),
    //               child: DecoratedBox(
    //                 decoration: BoxDecoration(
    //                     color: Color(0xfff1f1f1),
    //                     border: Border.all(color: Color(0xffe0eaeb), width: 3),
    //                     borderRadius: BorderRadius.circular(50),
    //                     boxShadow: <BoxShadow>[
    //                       BoxShadow(
    //                           color: Color.fromRGBO(0, 0, 0, 0.57),
    //                           blurRadius: 5)
    //                     ]),
    //                 child: Padding(
    //                   padding: EdgeInsets.only(left: 10, right: 10),
    //                   child: DropdownButtonHideUnderline(
    //                     child: DropdownButton<String>(
    //                         isExpanded: true,
    //                         icon: Icon(
    //                           Icons.arrow_drop_down_circle,
    //                           size: 20,
    //                         ),
    //                         value: sGraph,
    //                         items:
    //                             Graph.map((Graph) => DropdownMenuItem<String>(
    //                                 value: Graph,
    //                                 child: Text(
    //                                   Graph,
    //                                   style: TextStyle(
    //                                     fontSize: 16,
    //                                     fontWeight: FontWeight.bold,
    //                                     fontFamily: 'THSarabun',
    //                                     color: Color.fromARGB(255, 25, 25, 25),
    //                                   ),
    //                                 ))).toList(),
    //                         onChanged: (Graph) {
    //                           setState(() {
    //                             sGraph = Graph!;
    //                           });
    //                         }),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //                   ],
    //                 ),
    // );
  }

  Container g() {
  
    double? Number;
    int? T;
    if (result1.length < 100) {
      Number = result1.length / 15;
    }
    if (result1.length > 100) {
      Number = result1.length / 12;
    }
    String Number1 = Number!.toStringAsFixed(0);
    int Number2 = int.parse('$Number1');
    if (result1.length < 100) {
      Number = result1.length / Number2 - 5;
      T = 10;
    }
    if (result1.length > 100) {
      Number = result1.length / Number2;
      T = 5;
    }
     if (result1.length > 500) {
      Number = result1.length / Number2;
      T = 4;
    }
    Number1 = Number.toStringAsFixed(0);
    Number2 = int.parse('$Number1') + T!;

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 250,
      child: charts.LineChart(
        _createSampleData(),
        animate: false,
        // defaultRenderer: new charts.LineRendererConfig(includePoints: true),
        animationDuration: Duration(seconds: 1),
        domainAxis: new charts.NumericAxisSpec(
            viewport: charts.NumericExtents(-10, result1.length - 2),
            tickProviderSpec: charts.BasicNumericTickProviderSpec(
              zeroBound: true,
              desiredTickCount: Number2,
            ),
            renderSpec: new charts.SmallTickRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                fontSize: 13,
                fontFamily: 'Montserrat',
              ),
            )),
        // domainAxis: charts.NumericAxisSpec(
        //   showAxisLine: false,
        //   // viewport: charts.NumericExtents(-10, widget.day!),
        //    renderSpec: charts.SmallTickRendererSpec(
        //       minimumPaddingBetweenLabelsPx: 0,
        //       labelAnchor: charts.TickLabelAnchor.centered,
        //       labelStyle: charts.TextStyleSpec(
        //         fontSize: 13,
        //         color: charts.MaterialPalette.black,
        //       ),
        //       // labelRotation: 80,
        //    ),
        //    viewport: charts.NumericExtents(-10, result1.length-2),
        //   tickProviderSpec:
        //        charts.StaticNumericTickProviderSpec(<charts.TickSpec<int>>[

        //     for (int i = -12; i < result1.length; i++)
        //       if (i *Number2 < result1.length && i * Number2 >= -10)
        //          charts.TickSpec(i * Number2),
        //   ]

        //   // charts.BasicNumericTickProviderSpec(
        //   //     zeroBound: false,
        //   //     desiredTickCount: 20,

        //     ),
        //   ),

        behaviors: [
          new charts.SelectNearest(
              eventTrigger: charts.SelectionTrigger.pressHold),
          charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer(
                size: size,
                ssex: ssex,
                result1: result1,
                sex: widget.sex,
                sizeW: screenW),
          ),
          new charts.PanAndZoomBehavior(),
          new charts.SeriesLegend(
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.black,
                fontFamily: 'Montserrat',
                fontSize: 11),
            // desiredMaxRows: 4,
            desiredMaxColumns: 3,
            cellPadding: EdgeInsets.symmetric(horizontal: screenW * 0.02),
            // horizontalFirst: false,
            // outsideJustification: charts.OutsideJustification.start,
            // cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          ),
          new charts.ChartTitle(
            'day',
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
            'g.',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea,
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 14,
              fontFamily: 'Montserrat',
              color: charts.MaterialPalette.black,
            ),
          ),
        ],

        defaultRenderer: charts.LineRendererConfig(
            includeArea: true,
            includeLine: true,
            includePoints: false,
            strokeWidthPx: 1),
        selectionModels: [
          charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              updatedListener: (model) {},
              changedListener: (charts.SelectionModel model) {
                if (model.hasDatumSelection) {
                  selectedDatum = [];
                  for (int j = 0; j < widget.sex!.length; j++) {
                    if (ssex == widget.sex![j]['name']) {
                      model.selectedDatum
                          .forEach((charts.SeriesDatum datumPair) {
                        selectedDatum!.add({
                          // 'color': datumPair.series.colorFn!(0),

                          'text': '${datumPair.datum['day']}',
                          for (int i = 1; i < result1[0].keys.length; i++)
                            'text${i}':
                                '${datumPair.datum['${result1[0].keys.elementAt(i)}'] ?? 'undefeated'}',
                        });
                      });
                    }
                  }
                }
                if (model.hasDatumSelection)
                  var selectedVal = model.selectedSeries[0]
                      .measureFn(model.selectedDatum[0].index)
                      .toString();
              })
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
                  fontFamily: 'Montserrat',
                ),
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),
      ),
    );
  }

  Container Age_lnformation() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Center(
                    child: Container(
                  height: 40,
                  width: screenW * 0.40,
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
                    child: Container(
                     width: screenW * 0.25,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: DropdownButtonHideUnderline(
                          
                          child: widget.sex == null
                              ? DropdownButton<String>(
                              isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                    size: 20,
                                  ),
                                  value: Noname,
                                  items: NoList!
                                      .map((Nosex) => DropdownMenuItem<String>(
                                          value: Nosex,
                                          child: Text(
                                            Nosex,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                              color:
                                                  Color.fromARGB(255, 25, 25, 25),
                                            ),
                                          )))
                                      .toList(),
                                  onChanged: (Nosex) {
                                    setState(() {});
                                  })
                                  
                              : ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 1.0),
                                child: DropdownButton<String>(
                                  
                                  isExpanded: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down_circle,
                                      size: 20,
                                    ),
                                   
                                    value: Formulaname,
                                    items: Formula!
                                        .map((sex) => DropdownMenuItem<String>(
                                          
                                            value: sex,
                                            child:   SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                                              child: Text(
                                                sex,
                                                style: TextStyle(
                                                  // overflow: TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      Color.fromARGB(255, 25, 25, 25),
                                                ),
                                              ),
                                            )))
                                        .toList(),
                                    onChanged: (sex) {
                                      setState(() {
                                        Formulaname = sex!;
                                      });
                                      getjaon_summary_age_information();
                                      // _createSampleData();
                                      // _generateData();
                                    }),
                              ),
                        ),
                      ),
                    ),
                  ),
                )),
                Center(
                    child: Container(
                  height: 40,
                  width: screenW * 0.40,
                  margin: EdgeInsets.only(left: 10),
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
                        child: widget.type == null
                            ? DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: Noname,
                                items: NoList!
                                    .map((Notype) => DropdownMenuItem<String>(
                                        value: Notype,
                                        child: Text(
                                          Notype,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (Notype) {
                                  setState(() {});
                                })
                            : DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 20,
                                ),
                                value: stype,
                                items: widget.type!
                                    .map((type) => DropdownMenuItem<String>(
                                        value: type['name'].toString(),
                                        child: Text(
                                          type['name'],
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (type) => {
                                      for (int i = 0;
                                          i < widget.type!.length;
                                          i++)
                                        {
                                          if (widget.type![i]['name'] == type)
                                            {
                                              setState(() {
                                                num1 = widget.type![i]['id'];
                                                stype = type!;
                                                getjaon_summary_age_information();
                                              }),
                                            }
                                        }
                                    }),
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
}

List? selectedDatum;
String? unit;

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  final Size? size;
  final double? sizeW;
  late String? ssex;
  List<Map<String, double>>? result1;
  List<dynamic>? sex;

  CustomCircleSymbolRenderer(
      {this.size, this.ssex, this.result1, this.sex, this.sizeW});

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

    //  //print("datum: $tooltips");

    num tipTextLen = (tooltips[0]['text']).length;
    num rectWidth = bounds.width + tipTextLen * 8.3;
    num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;

    num left = bounds.left > (size?.width ?? 300) / 4
        ? (bounds.left > size!.width / 4
            ? bounds.left - rectWidth
            : bounds.left - rectWidth / 2)
        : bounds.left - 40;

    if (left > sizeW! / 2) {
      canvas.drawRRect(
        Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * result1![0].keys.length),
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
      for (int j = 0; j < sex!.length; j++) {
        if (ssex == sex![j]['name']) {
          canvas.drawText(
              chartText.TextElement('day : ' + tooltips[0]['text'],
                  style: textStyle),
              (110 - 10.0 - 35).round(),
              (25.0 - 5).round());
          for (int i = 1; i < result1![0].keys.length; i++) {
            //'${NumberFormat.compact().format(double.parse('${tooltips[0]['text$i']}'))}',

            if (tooltips[0]['text$i'] == 'undefeated') {
              unit2 = 'undefeated';
            } else {
              unit2 =
                  '${NumberFormat.compact().format(double.parse('${tooltips[0]['text$i']}'))}';
            }
            canvas.drawText(
                chartText.TextElement(
                    '${result1![0].keys.elementAt(i)} : ' + '$unit2',
                    style: textStyle),
                (110 - 10.0 - 35).round(),
                (13 + (i * 13) + 7).round());
          }
        }
      }
    }
    if (left < sizeW! / 2) {
      canvas.drawRRect(
        Rectangle((sizeW! - 130) - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * result1![0].keys.length),
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
      for (int j = 0; j < sex!.length; j++) {
        if (ssex == sex![j]['name']) {
          canvas.drawText(
              chartText.TextElement('day : ' + tooltips[0]['text'],
                  style: textStyle),
              ((sizeW! - 130) - 10.0 - 35).round(),
              (25.0 - 5).round());
          for (int i = 1; i < result1![0].keys.length; i++) {
            //'${NumberFormat.compact().format(double.parse('${tooltips[0]['text$i']}'))}',

            if (tooltips[0]['text$i'] == 'undefeated') {
              unit2 = 'undefeated';
            } else {
              unit2 =
                  '${NumberFormat.compact().format(double.parse('${tooltips[0]['text$i']}'))}';
            }
            canvas.drawText(
                chartText.TextElement(
                    '${result1![0].keys.elementAt(i)} : ' + '$unit2',
                    style: textStyle),
                ((sizeW! - 130) - 10.0 - 35).round(),
                (13 + (i * 13) + 7).round());
          }
        }
      }
    }
  }
}

List? selectedDatum1;
String? unit1;
String? unit2;

class CustomCircleSymbolRenderer1 extends charts.CircleSymbolRenderer {
  final Size? size;
  final double? sizeW;
  late String? sView_by;
  late List<dynamic>? result2;
  List<dynamic>? View_by;

  CustomCircleSymbolRenderer1(
      {this.size, this.sView_by, this.View_by, this.result2, this.sizeW});

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

    num tipTextLen = (tooltips[0]['text']).length;
    num rectWidth = bounds.width + tipTextLen * 8.3;
    num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;

    num left = bounds.left > (size?.width ?? 300) / 4
        ? (bounds.left > size!.width / 4
            ? bounds.left - rectWidth
            : bounds.left - rectWidth / 2)
        : bounds.left - 40;

//print("tipTextLen: $left");
    if (left > sizeW! / 2) {
      canvas.drawRRect(
        Rectangle(110.0 - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * result2![0].keys.length),
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
      for (int j = 0; j < View_by!.length; j++) {
        if (sView_by == View_by![j]['name']) {
          canvas.drawText(
              chartText.TextElement('day : ' + tooltips[0]['text'],
                  style: textStyle),
              (110 - 10.0 - 35).round(),
              (25.0 - 5).round());
          for (int i = 1; i < result2![0].keys.length; i++) {
            //'${NumberFormat.compact().format(double.parse('${tooltips[0]['text$i']}'))}',

            if (tooltips[0]['text$i'] == 'undefeated') {
              unit2 = 'undefeated';
            } else {
              unit2 =
                  '${NumberFormat.compact().format(double.parse('${tooltips[0]['text$i']}'))}';
            }
            canvas.drawText(
                chartText.TextElement(
                    '${result2![0].keys.elementAt(i)} : ' + '$unit2',
                    style: textStyle),
                (110 - 10.0 - 35).round(),
                (13 + (i * 13) + 7).round());
          }
        }
      }
    }
    if (left < sizeW! / 2) {
      canvas.drawRRect(
        Rectangle((sizeW! - 130) - 5.0 - 50, 15 - 0, 150 + 0,
            bounds.height + 14 * result2![0].keys.length),
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
      for (int j = 0; j < View_by!.length; j++) {
        if (sView_by == View_by![j]['name']) {
          canvas.drawText(
              chartText.TextElement('day : ' + tooltips[0]['text'],
                  style: textStyle),
              ((sizeW! - 130) - 10.0 - 35).round(),
              (25.0 - 5).round());
          for (int i = 1; i < result2![0].keys.length; i++) {
            if (tooltips[0]['text$i'] == 'undefeated') {
              unit2 = 'undefeated';
            } else {
              unit2 =
                  '${NumberFormat.compact().format(double.parse('${tooltips[0]['text$i']}'))}';
            }
            canvas.drawText(
                chartText.TextElement(
                    '${result2![0].keys.elementAt(i)} : ' + '$unit2',
                    style: textStyle),
                ((sizeW! - 130) - 10.0 - 35).round(),
                (13 + (i * 13) + 7).round());
          }
        }
      }
    }
  }
}
