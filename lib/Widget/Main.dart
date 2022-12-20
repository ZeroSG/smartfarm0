import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../drawer.dart';

class Main1 extends StatefulWidget {
  String? Token;
     String? User;
  String? Password;
  List<dynamic>? HOUSE;
  int? farmnum;
   int?  cropnum2,cropnum1,cropnum;
  Main1({Key? key, this.Token,this.User,this.Password,this.HOUSE,this.farmnum,this.cropnum2,this.cropnum1,this.cropnum}) : super(key: key);

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
  late var result0;
  late var result2;
   late var HOUSEnum;
    late var HOUSEname;
    late  List<dynamic>?   feed;

  var name;
  var age;
  var largestGeekValue;
  var sum = 0.0, sum1 = 0.0;
  var formula1 = 'default', formula2 = 'default';
  var E_Refill1, E_Refill2;
  var A_Refill1, A_Refill2;
  var percent1, percent2;
  var siloname1, siloname2;
  var kg1, kg2;
  Color? Col11, Col2;
  late var num;
   late String? user = widget.User;
  late String? password=widget.Password;
  
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
          print(result2);
          loading = false;
          var num1 = result2.length / 2;
          num = int.parse('${num1.toInt()}');
        });

        if (result2[1]['n_index'] == 2) {
          setState(() {
            selected2 = 1;
          });
        }
        if (result2[1]['n_index'] == 1) {
          setState(() {
            selected2 = 0;
          });
        }
      //  print('${result2[0]['n_index']}   === ${result2[0 + 1]['n_index']}');
        // result2[0]['n_index'] != 2 &&result2[0 + 1]['n_index'] != 2
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
    // _createSampleData();
  }

  late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
    // //print(widget.farmnum);
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
                            // side: BorderSide(color: Colors.red)
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
                                    itemCount: result0.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        child: buildg1(index),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                  Card(
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
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: num,
                                        //   separatorBuilder:  (context, index) {
                                        //   return const SizedBox(width: 2,);
                                        // },

                                        itemBuilder: (context, index) {
                                          return Card(
                                            elevation: 10,
                                            child: Container(
                                              width: 50,
                                              height: 60,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // for(int i = 0; i<result2.length;i++){
                                                  //     if (result2[index]['n_index'] == 1){

                                                  //     }
                                                  // }
                                                  setState(() {
                                                    Duration(seconds: 20000);
                                                    Col1 = index;
                                                    // selected2 =  index + B[index];
                                                    // //print('$index + ${B[index]}  = $selected2');
                                                  });
                                                },
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 16,
                                                    color: index == Col1
                                                        ? Color.fromARGB(
                                                            255, 0, 0, 0)
                                                        : Color(0xff9d9d9d),
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: index == Col1
                                                      ? Color.fromARGB(
                                                          255, 111, 209, 186)
                                                      : Color(0xfffefefe),
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
                              key: Key('builder2 ${selected2.toString()}'),
                              itemCount: result2.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: buildg2(index),
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

  buildg1(int index) {
    return Container(
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(0).copyWith(top: 0),
        // tilePadding: EdgeInsets.symmetric(vertical: 0),
        //             childrenPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        // trailing: SizedBox.shrink(),
        maintainState: true,
        key: Key(index.toString()),
        initiallyExpanded: index == selected1,
        onExpansionChanged: (value) {
          if (value) {
            setState(() {
              Duration(seconds: 20000);
              selected1 = index;
            });
          } else {
            setState(() {
              selected1 = -1;
            });
          }
        },
        title: ListTile(
          title: Text(
            '${result0[index]['c_formula']}',
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
                                    'Remain : ${result0[index]['a_remain'].toStringAsFixed(2)} kg')),
                            Text(
                                'Usage : ${result0[index]['a_usage'].toStringAsFixed(2)} kg'),
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
                                    'Refll(Today) : ${result0[index]['a_refill'].toStringAsFixed(2)} kg')),
                            Text(
                                'Refll(Yedterday) : ${result0[index]['b_refill'].toStringAsFixed(2)} kg'),
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
  buildg2(int index) {
    // //print(result2.length);
    largestGeekValue = result2[0]['n_index'];
    if (result2[index]['n_index'] == 1) {
      var capacity1 = result2[index]['n_capacity'];
      var remain1 = result2[index]['n_remain'];

      name = result2[index]['c_name'];
      if (result2[index]['n_day'] == ''||result2[index]['n_day'] == -1000) {
        age = 'no live';
      } else {
        age = 'age ${result2[index]['n_day']} day';
      }

      E_Refill1 = result2[index]['e_refill'];
      A_Refill1 = result2[index]['a_refill'];
      upper_percent1 = result2[index]['n_upper_percent'];
      lower_percent1 = result2[index]['n_lower_percent'];
      percent1 = (remain1 / capacity1) * 100;
      kg1 = percent1 * 100;
      sum = percent1 / 100;
      if (sum < 0.0) {
        sum = 0.0;
      }
      if (sum > 1.0) {
        sum = 1.0;
      }
      //   if(percent1 >= upper_percent1){
      //     //print(upper_percent1);
      //     Col11 = Color.fromARGB(255, 0, 25, 249);
      //   }
      //  else if(percent1 <= lower_percent1){
      //       Col11 = Colors.red;
      //   }
      //   else{
      //     Col11 = Color.fromARGB(255, 0, 255, 51);
      //   }
      siloname1 = result2[index]['c_silo_name'];

      if (result2[index]['c_formula'] == '' ||
          result2[index]['c_formula'] == null) {
        formula1 = 'default';
      } else {
        formula1 = result2[index]['c_formula'];
      }
    } else if (result2[index]['n_index'] == 2) {
      var capacity2 = result2[index]['n_capacity'];
      var remain2 = result2[index]['n_remain'];
      upper_percent2 = result2[index]['n_upper_percent'];
      lower_percent2 = result2[index]['n_lower_percent'];
      // //print(index);
      
      E_Refill2 = result2[index]['e_refill'];
      A_Refill2 = result2[index]['a_refill'];
      percent2 = (remain2 / capacity2) * 100;
      kg2 = percent2 * 100;
      //   sum1 = percent2 / 100;

      //   if(sum1 < 0.0){
      //     sum1 =0.0;
      //   }
      //   if(sum1 > 1.0){
      //     sum1 =1.0;
      //   }
      //   if(percent2 >= upper_percent2){
      //     Col2 = Color.fromARGB(255, 0, 25, 249);
      //   }
      //  else if(percent2 <= lower_percent2){
      //       Col2 = Colors.red;
      //   }
      //   else{
      //     Col2 = Color.fromARGB(255, 0, 255, 51);
      //   }
      siloname2 = result2[index]['c_silo_name'];

      if (result2[index]['c_formula'] == '' ||
          result2[index]['c_formula'] == null) {
        formula2 = 'default';
      } else {
        formula2 = result2[index]['c_formula'];
      }
    }

    if (result2[index]['n_index'] == 2 && result2[index - 1]['n_index'] == 1) {
      selected2 == 1;
      return ExpansionTile(
        backgroundColor: Colors.white,
        maintainState: true,
        key: Key(index.toString()),
        initiallyExpanded: index == selected2,
        onExpansionChanged: (value) {
          if (value) {
            setState(() {
              Duration(seconds: 20000);
              selected2 = index;
            });
          } else {
            setState(() {
              selected2 = -1;
            });
          }
        },
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
                     
                                 width: (screenW * 0.46)-55,
                                  child: Column(
                                    children: [
                                      Container(
                                       width: (screenW * 0.46)-55,
                                       
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
                                       width: (screenW * 0.46)-55,
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${kg1.toStringAsFixed(2)} kg',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: (screenW * 0.46)-55,
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${percent1.toStringAsFixed(2)} %',
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
                  
                                   width: (screenW * 0.46)-55,
                                  child: Column(
                                    children: [
                                      Container(
                                       width: (screenW * 0.46)-55,
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
                                      width: (screenW * 0.46)-55,
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${kg2.toStringAsFixed(2)} kg',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                      width: (screenW * 0.46)-55,
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${percent2.toStringAsFixed(2)} %',
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
                              'Estimate Refill :$E_Refill1 kg',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 166, 165, 165)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 10),
                            child: Text(
                              'Actual Refill :$A_Refill1 kg.',
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

                            //  width: screenW*0.5,
                            child: TextButton(
                              onPressed: () {
                                for(int i = 0;i<widget.HOUSE!.length;i++){
                                  if(result2[index]['c_name'] == widget.HOUSE![i]['name'])
                                  {
                                    setState(() {
                                      HOUSEnum = widget.HOUSE![i]['id'];
                                      HOUSEname = widget.HOUSE![i]['name'];
                                        feed = widget.HOUSE![i]['feed'];
                                    });
                                    // //print(result2[index]['c_name'] );
                                    // //print(HOUSEname);
                                    // //print(HOUSEnum);
                                    // //print(widget.farmnum);
                                    // //print(widget.cropnum2);
                                  }
                                }
                                print('widget.cropnum');
                                print(widget.cropnum);
                                print(widget.cropnum1);
                                print(widget.cropnum2);
                                print('widget.cropnum');
                                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=> Drawer1(Token: widget.Token, num1: 2,User: user,Password: password,HOUSE1:HOUSEnum,HOUSE2: HOUSEname,cropnum1: widget.cropnum1,cropnum:widget.cropnum,cropnum2:widget.cropnum2,farmnum:widget.farmnum,Feed: feed,),), (route) => false);
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           Drawer1(Token: widget.Token, num1: 2,User: user,Password: password,HOUSE1:HOUSEnum,HOUSE2: HOUSEname,cropnum1: widget.cropnum1,cropnum:widget.cropnum,cropnum2:widget.cropnum2,farmnum:widget.farmnum,Feed: feed,),
                                //     ));
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
        ],
      );
    }
    try {
      if (result2.length ==1 || result2[index]['n_index'] != 2 &&result2[index + 1]['n_index'] != 2) {
        return ExpansionTile(
          backgroundColor: Colors.white,
          maintainState: true,
          key: Key(index.toString()),
          initiallyExpanded: index == selected2,
          onExpansionChanged: (value) {
            if (value) {
              setState(() {
                Duration(seconds: 20000);
                selected2 = index;
              });
            } else {
              setState(() {
                selected2 = -1;
              });
            }
          },
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
                              width:  (screenW * 0.85)-55,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Container(
                                  width:  (screenW * 0.85)-55,
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
                                    width:  (screenW * 0.85)-55,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${kg1.toStringAsFixed(2)} kg',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                   width:  (screenW * 0.85)-55,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${percent1.toStringAsFixed(2)} %',
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
                                'Estimate Refill :$E_Refill1 kg.',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 166, 165, 165)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, right: 10),
                              child: Text(
                                'Actual Refill :$A_Refill1 kg.',
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
                              margin: EdgeInsets.only(top: 5,),
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
                                   for(int i = 0;i<widget.HOUSE!.length;i++){
                                  if(result2[index]['c_name'] == widget.HOUSE![i]['name'])
                                  {
                                    setState(() {
                                      HOUSEnum = widget.HOUSE![i]['id'];
                                      HOUSEname = widget.HOUSE![i]['name'];
                                      feed = widget.HOUSE![i]['feed'];
                                    });
                                    // //print(result2[index]['c_name'] );
                                    // //print(HOUSEname);
                                    // //print(HOUSEnum);
                                    // //print(widget.farmnum);
                                    // //print(widget.cropnum2);
                                  }
                                }
                                                                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=>   Drawer1(Token: widget.Token, num1: 2,User: user,Password: password,HOUSE1:HOUSEnum,HOUSE2: HOUSEname,cropnum1: widget.cropnum1,cropnum:widget.cropnum,cropnum2:widget.cropnum2,farmnum:widget.farmnum,Feed: feed,),), (route) => false);
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //       Drawer1(Token: widget.Token, num1: 2,User: user,Password: password,HOUSE1:HOUSEnum,HOUSE2: HOUSEname,cropnum1: widget.cropnum1,cropnum:widget.cropnum,cropnum2:widget.cropnum2,farmnum:widget.farmnum,Feed: feed,),
                                  //     ));
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
          ],
        );
      }
    } catch (e) {
      //print('e =====> ${e.toString()} ');
    }
  }
}

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
