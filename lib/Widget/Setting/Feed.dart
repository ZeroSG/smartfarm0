import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

import 'package:http/http.dart' as http;

class Feed extends StatefulWidget {
   String? Token;
   int? farmnum;
   
   Feed({ Key? key,this.Token,this.farmnum }) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
   late double screenW, screenH;
   final List<Map> _products1 = List.generate(1, (i) {
    return {"id": '', "name": "", "price": ''};
  });

   final List<Map> _products2 = List.generate(1, (i) {
    return {"id": '', "name": "", "price": ''};
  });
   List<String> Feeds = [];
  String Feedsname = '';

  bool loading1 = true;
  List<dynamic> nowresult1_1 = []; 
  List<dynamic> nowresult1_2 = []; 
    Future<void> getjaon1_setting_feeds() async {
    try {
      loading1 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/setting/setting-feed");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "Farm": widget.farmnum
}));
      if (ressum.statusCode == 200) {
        var result1_1 = json.decode(ressum.body)['result']['view1'];
        var result1_2 = json.decode(ressum.body)['result']['view2'];
       setState(() {
        //  //print("Feed ===>$result1_1",);
        //   //print("${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2",);
         nowresult1_1 = result1_1;
         nowresult1_2 = result1_2;
         loading1 = false;
       });
       
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
    getjaon1_setting_feeds();
    // _createSampleData();
  }
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
            body:  SingleChildScrollView(
         physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: loading1
            ? Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator()))
            : Container(
            
                  child:  Column(
                    children: [
                      Row(
                        
                              children: [
                                Container(
                                      margin: EdgeInsets.only(),
                                          child: GestureDetector(
                                        onTap: 
                                        () {
                                          
                                     Navigator.pop(context);
                                        },
                                        child: Container(
                                           width: 32,
                                          height: 40,
                                       
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.arrow_back_ios)
                                          ),
                                        )),
                                        ),
                              Text('Feeds InFarm',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  color: Color.fromARGB(255, 25, 25, 25),
                                                  ),),   
                                                    
                              ],
                            ),
                     Feeds1(),  
                      DataTable(), 
                      Feedmills_Orders3(),  
                     Container(),   
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Container Feeds1() {
    return Container(
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Container(
                            child: Center(
                child: Container(
                   margin: EdgeInsets.only(top: 10),
                  height: 40,
                  width: screenW*0.70,
                  child: DecoratedBox(
                        decoration: BoxDecoration(
                             border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
                            ),
                    child: Padding(
                       padding: EdgeInsets.only(left: 10, right: 10),
                      child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                        value: Feedsname,
                        items:  Feeds
                            .map((Feeds) => DropdownMenuItem<String>(
                                value: Feeds,
                                child: Text(
                                  Feeds,
                                  style: TextStyle(
                                    fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  ),
                                )))
                            .toList(),
                        onChanged: (Feeds) {
                         setState(() {
                              
                                    Feedsname = Feeds!;
                       
                                  });
                        }),
                                ),
                    ),
                  ),
                )), 
                         ), 
                         SizedBox(
                           width: 5,
                         ),
                         Container(
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
                            onPressed: () {},
                            icon: Icon(IcoFontIcons.uiAdd,
                              color: Color.fromARGB(255, 242, 3, 3),
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                         ), 
                      ],
                    ),
               
                 );
  }

  Stack DataTable() {
    return Stack(
                   children: [
                     Container(
                       width: screenW*0.95,
                       margin: EdgeInsets.only(top: 10),
                      //  color: Colors.blueAccent,
                       decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      ),
                       height: 184,
                     ),
                     Container(
                       width: screenW*0.95,
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
                       width: screenW*0.95,
                       margin: EdgeInsets.only(top: 10),
                       child: Container(
                                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      
                      ),
                                  margin: EdgeInsets.only(top: 5),
                               
                                  height: 184,
                                  // child: SingleChildScrollView(
                
                child:  DataTable2(
                                   headingRowHeight: 40.0,  
                               dataRowColor: MaterialStateProperty.all(Colors.white),
                               
                              columnSpacing: 1,
                              horizontalMargin: 15,
                              minWidth: 200,
              
                      columns: [
                        DataColumn(
                          label: Center(
                            child: Text(
                              "#",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                           DataColumn(
                          label: Center(
                            child: Text(
                              "FEED",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                           DataColumn(
                          label: Center(
                            child: Text(
                              "BAG",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                           DataColumn(
                          label: Center(
                            child: Text(
                              "KG",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                          
                      ],   rows: nowresult1_1 == null ?   _products1.map((item) {
                return  DataRow(cells: [
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(''))),

                ]);
                                  }).toList()
                                  
                       :  nowresult1_1.map((item) {
                return  DataRow(cells: [
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(item['FEED']==null?'':item['FEED'].toString()))),
                      DataCell(Center(child: Text(item['BAG']==null?'':item['BAG'].toString()))),
                      DataCell(Center(child: Text(item['KG']==null?'':item['KG'].toString()))),

                ]);
                                  }).toList(),
                ),
                                  // )
                                ),
                     ),
                   ],
                 );
  }

  Container Feedmills_Orders3() {
    return Container(
       margin: EdgeInsets.only(top: 10),
             width: screenW*0.95,
            child: Column(
              children: [
                Container(
                   width: screenW*0.9,
                  child: Text('Feedmills Orders',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: Color.fromARGB(255, 25, 25, 25),
                                        ),),
                ),


                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Stack(
                    children: [
                      Container(
                       margin: EdgeInsets.only(top: 5),
                        //  color: Colors.blueAccent,
                         decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        ),
                         height: 274,
                       ),
                       Container(
                        margin: EdgeInsets.only(top: 5),
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
                                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        ),
                                    margin: EdgeInsets.only(top: 5),
                                 
                                    height: 274,
                                    // child: SingleChildScrollView(
                      
                      child: DataTable2(
                                     headingRowHeight: 40.0,  
                                 dataRowColor: MaterialStateProperty.all(Colors.white),
                                 
                                columnSpacing: 1,
                                horizontalMargin: 15,
                                minWidth: 1100,
                
                        columns: [
                             DataColumn(
                            label: Center(
                              child: Text(
                                "FEED",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                             DataColumn(
                            label: Center(
                              child: Text(
                                "TYPE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                             DataColumn(
                            label: Center(
                              child: Text(
                                "BGT-NM",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                             DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-LP",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                             DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-LR1",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                             DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-LR2",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                             DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-LR3",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                              DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-LR4",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-NT",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-PC",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-PD",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-SK1",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                "BTG-SK2",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ], 
                          rows: nowresult1_2 == null ? _products2.map((item) {
                      return DataRow(cells: [
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                        DataCell(Center(child: Text(''))),
                
                        
                      ]);
                                    }).toList()
                       :   nowresult1_2.map((item) {
                      return DataRow(cells: [
                        DataCell(Center(child: Text(item['FEED']==null?'':item['FEED'].toString()))),
                        DataCell(Center(child: Text(item['TYPE']==null?'':item['TYPE'].toString()))),
                        DataCell(Center(child: Text(item['BGT-NM']==null?'':item['BGT-NM'].toString()))),
                        DataCell(Center(child: Text(item['BTG-LP']==null?'':item['BTG-LP'].toString()))),
                        DataCell(Center(child: Text(item['BTG-LR1']==null?'':item['BTG-LR1'].toString()))),
                        DataCell(Center(child: Text(item['BTG-LR2']==null?'':item['BTG-LR2'].toString()))),
                        DataCell(Center(child: Text(item['BTG-LR3']==null?'':item['BTG-LR3'].toString()))),
                        DataCell(Center(child: Text(item['BTG-LR4']==null?'':item['BTG-LR4'].toString()))),
                        DataCell(Center(child: Text(item['BTG-NT']==null?'':item['BTG-NT'].toString()))),
                        DataCell(Center(child: Text(item['BTG-PC']==null?'':item['BTG-PC'].toString()))),
                        DataCell(Center(child: Text(item['BTG-PD']==null?'':item['BTG-PD'].toString()))),
                        DataCell(Center(child: Text(item['BTG-SK1']==null?'':item['BTG-SK1'].toString()))),
                        DataCell(Center(child: Text(item['BTG-SK2']==null?'':item['BTG-SK2'].toString()))),
                
                        
                      ]);
                                    }).toList(),
                      ),
                                    // )
                                  ),
                    ],
                  ),
                ),                        
              ],
            ),
          );
  }
}
