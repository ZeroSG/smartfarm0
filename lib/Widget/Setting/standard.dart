import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:data_table_2/data_table_2.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

import 'package:http/http.dart' as http;

import '../API_E_B/API_B.dart';

class standard extends StatefulWidget {
  String? Token;
   int? farmnum;
   List<dynamic>? default_formula;
   standard({ Key? key,this.Token ,this.farmnum ,this.default_formula}) : super(key: key);

  @override
  State<standard> createState() => _standardState();
}

class _standardState extends State<standard> {
  late double screenW, screenH;
  File? file;
 late List<dynamic>? Formula  = widget.default_formula;
  late String Formulaname = widget.default_formula![0]['name'];

   final List<Map> _products1 = List.generate(1, (i) {
    return {"id": '', "name": "", "price": ''};
  });

      var selectedExcel;
  List tbleRows = [];
late List<dynamic> _fileList =[];
  late String? filename;
   pickFile(StateSetter setState) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
       type: FileType.custom,
  allowedExtensions: ['xlsx'],
      // allowedExtensions: ['xlsx'],
    );
     
    if (result != null) {
      String file2 = result.files.single.path.toString();
        String namef = file2.split('/').last;
         
    File  file1 = File(file2);
    //  print(file1.extension);
      var bytes = file1.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes,);
    
      setState(() {
        selectedExcel = excel;
        tbleRows.clear(); 
        filename = namef;
        file = file1;
      });
  //     //  print(selectedExcel["Sheet1"].sheetName);
      Sheet sheet = selectedExcel["Sheet1"];
      
       for (var table in excel.tables.keys) {

      for (var row in excel.tables[table]!.rows) {
  
        setState(() {
          
          tbleRows.add(row);
         _fileList =  List.generate(tbleRows.length, (i) {
    return {"1": '', "2": "", "3": '', "4": '', "5": ''};
      
  });
 
        });
      }
    }
    List<dynamic> _fileList2 = ['1','2','3','4','5'];
      for(int i = 0;i<tbleRows.length;i++){
        for(int f = 0;f<tbleRows[i].length;f++){
          setState(() {
            _fileList[i]['${_fileList2[f]}'] += tbleRows[i][f].value.toString();
          });

        }
      }
     print("_fileList ${_fileList}");
    } else {
    }
  }
   List<dynamic>? NoList =[''];
   String? Noname ='';

  bool loading1 = true;
  List<dynamic> nowresult1_1 = []; 
    Future<void> getjaon1_setting_formula() async {
    try {
      loading1 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/setting/setting-formula");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "Farm": widget.farmnum,
  "Formula": Formulaname
}));
      if (ressum.statusCode == 200) {
        var result1_1 = json.decode(ressum.body)['result']['view1'];
        
       setState(() {
         print("standard ==> $result1_1",);
        //   //print("${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2",);
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


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.default_formula != null){
       getjaon1_setting_formula();
    }
    else{
      loading1 = false;
    }

    // _createSampleData();
  }
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
            body:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Text('Standard Formula',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(255, 25, 25, 25),
                                                    ),)   ,       
                                ],
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
                                  width: 100,
                                  margin: EdgeInsets.only(top: 5,bottom: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                      tbleRows = [];
                                     filename = null;
                                    file = null;
                                      });
                                     Upload(context);
                                    },
                                    child: Text(
                                      'Upload',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 13,
                                          color: Color.fromARGB(255, 255, 255, 255)),
                                    ),
                                  ),
                                ),    
                            ],
                          ),
                  Formula1(),
                 loading1
            ? Container(
                width: screenW * 0.5,
                height: screenW * 0.5,
                child: Center(child: CircularProgressIndicator()))
            :  newDataTable(),
                  ],
                ),
              ),
            ),
    );
  }

  Stack newDataTable() {
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
                     height: screenH*0.5,
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
                     height: 50.0, 
                   ),
                   Container(
                     width: screenW*0.95,
                     margin: EdgeInsets.only(top: 10),
                     child: Container(
                                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    
                    ),
                                margin: EdgeInsets.only(top: 5),
                             
                                height: screenH*0.5,
                                // child: SingleChildScrollView(
              
              child: DataTable2(
                                 headingRowHeight: 40.0,  
                             dataRowColor: MaterialStateProperty.all(Colors.white),
                             
                            columnSpacing: 1,
                            horizontalMargin: 15,
                            minWidth: 600,
            
                    columns: [
                     
                         DataColumn(
                        label: Center(
                          child: Text(
                            "Day",
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
                            "Body Weight",
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
                            "Daily Gain",
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
                            "Daily Intake",
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
                            "Cum Intake",
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
                            "Fcr",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                        
                    ], 
                      rows: nowresult1_1 == null ?   _products1.map((item) {
                return  DataRow(cells: [
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(''))),
                      DataCell(Center(child: Text(''))),

                ]);
                                  }).toList()
                                  
                       : nowresult1_1.map((item) {
              return DataRow(cells: [
                   DataCell(Center(child: Text(item['n_day']==null?'':item['n_day'].toString()))),
                    DataCell(Center(child: Text(item['n_body_weight']==null?'':item['n_body_weight'].toString()))),
                    DataCell(Center(child: Text(item['n_daily_gain']==null?'':item['n_daily_gain'].toString()))),
                    DataCell(Center(child: Text(item['n_daily_intake']==null?'':item['n_daily_intake'].toString()))),
                    DataCell(Center(child: Text(item['n_cum_intake']==null?'':item['n_cum_intake'].toString()))),
                    DataCell(Center(child: Text(item['n_fcr']==null?'':item['n_fcr'].toString()))),

              ]);
                                }).toList(),
              ),
                                // )
                              ),
                   ),
                 ],
               );
  }

  Future<dynamic> Upload(BuildContext context) {
    return showDialog(
      barrierColor: Color.fromARGB(255, 148, 174, 149).withOpacity(0.3),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
      builder:(BuildContext context, StateSetter setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 230,
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
                          "",
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
               
                Container(
                  width: screenW * 1,
                  margin: EdgeInsets.only(top: 15,left: 15),
                  child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: screenW*0.2,
                          decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        color: Color.fromARGB(255, 255, 255, 255)                   ),
                          child: TextButton(
                            child: Text('เลือกไฟล์', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'THSarabun',
                                  color: Color.fromARGB(255, 0, 0, 0)),),
                            onPressed: (){
                              
                              pickFile(setState);
                            },
                          ),
                        ),
                        Container(
                          height: 35,
                          width: screenW*0.5,
                           decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        color: Color.fromARGB(255, 255, 255, 255)  ),
                        child: Container(
                          width: screenW*0.4,
                           margin: EdgeInsets.only(top: 8,left: 10),
                          child: Text(file != null?filename!:'ไม่ได้เลือกไฟล์ใด', style: TextStyle(
                                    fontSize: file != null?14:18,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight:  file != null?FontWeight.normal: FontWeight.bold,
                                    fontFamily:file != null? 'Montserrat': 'THSarabun',
                                    color: Color.fromARGB(255, 0, 0, 0)),),
                        ),
                        ),
                      ],
                    ),
                  
                ),
                Container(
    margin: EdgeInsets.only(top: 10,bottom: 10,left: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                           
                          },
                          child: Text(
                            'Upload',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                      ),
    ],),
  )
                
                  
                  
              ],
            ),
          ));},);}
          );
  }

  Container Formula1() {
    return Container(
                  child: Column(
                    children: [
                       Container(
         width: screenW*0.80,
          margin: EdgeInsets.only(left: 5),
        child: Text('Formula',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Color.fromARGB(255, 25, 25, 25),
                          ),)),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Container(
                              child: Center(
              child: Container(
                 margin: EdgeInsets.only(top: 5),
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
                                    child: widget.default_formula == null || Formula == null || Formula == [] ? DropdownButton<String>(
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
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (NoView_by) {
                              setState(() {
                              });
                              
                            })
                                      :DropdownButton<String>(
                                        icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                          value: Formulaname,
                          items:  Formula!
                              .map((Formula) => DropdownMenuItem<String>(
                                  value: Formula['name'],
                                  child: Text(
                                    Formula['name'],
                                    style: TextStyle(
                                      fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                    ),
                                  )))
                              .toList(),
                          onChanged: (Formula) {
                           setState(() {
                                
                                      Formulaname = Formula!;
                                     getjaon1_setting_formula();
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
                              onPressed: () {
                                if(Formula!.length > 1) {    
                                print('=======1=========');
                             print(widget.Token);
                             print(widget.farmnum);
                             print(Formulaname);
                                // API_button_delete_standard(widget.Token,widget.farmnum,Formulaname);


                                   late  List<dynamic> Formula0 = [];
                            
                             for(int i = 0;i<Formula!.length;i++){
                               if(Formula![i]['name'] !=Formulaname){
                                  Formula0 += [Formula![i]];
                               }
                             }
                              Formulaname = Formula0[0]['name'];
                             Formula = Formula0;
                             print('3   $Formula'); 
                           
                              getjaon1_setting_formula();
                            }
                              },
                              icon: Icon(IcoFontIcons.uiDelete,
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
                    ],
                  ),
             
               );
  }
}