import 'dart:math';

// import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';


class Viewtable extends StatefulWidget {
  List<dynamic>? nowresult6_1;
   Viewtable({ Key? key,this.nowresult6_1 }) : super(key: key);
  
  @override
  State<Viewtable> createState() => _ViewtableState();
}

class _ViewtableState extends State<Viewtable> {
  late double screenW, screenH;
  bool loading6 = true;
  final List<Map> _products = List.generate(5, (i) {
    return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  });
  @override
  Widget build(BuildContext context) {

    if(widget.nowresult6_1 == null){
      setState(() {
        loading6 = true;
      });
    }
    else{
       setState(() {
        loading6 = false;
      });
    }
      screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
           loading6?Container(
                  margin: EdgeInsets.only(top: 10),
                  height: screenH * 0.30,
                  child: Center(child: CircularProgressIndicator()))
                    : Container(

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
                    width: screenW * 1,
                    height: 280,
                    // child: SingleChildScrollView(
                      child: DataTable(
                          headingRowHeight: 40.0,  
             dataRowColor: MaterialStateProperty.all(Colors.white),
            columnSpacing: 0,
            horizontalMargin: 15,
     

                        columns: [
                              DataColumn(
                            label: Container(
                          width: screenW*0.19,
                              child: Center(
                                child: Text(
                                  "Size", textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                          width: screenW*0.19,
                              child: Center(
                                child: Text(
                                  "Weight Range", textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                          width: screenW*0.19,
                              child: Center(
                                child: Text(
                                  "Percent", textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                          width: screenW*0.19,
                              child: Center(
                                child: Text(
                                  "Number", textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                        ], 
                          rows: widget.nowresult6_1!.map((item) {
                      return DataRow(cells: [
                        DataCell(Center(child: Text(item['c_size'] , textScaleFactor: 1.0,style: TextStyle(
                               
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0)),))),
                        DataCell(Center(child: Text(item['c_range'] , textScaleFactor: 1.0,style: TextStyle(
                                    
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0)),))),
                        DataCell(Center(child: Text(item['n_percent'] , textScaleFactor: 1.0,style: TextStyle(
                                 
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0)),))),
                        DataCell(Center(child: Text(item['n_number'].toString() , textScaleFactor: 1.0,style: TextStyle(
                                   
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0)),)))
                      ]);
                    }).toList(),
                      ),
            //           child: DataTable2(
            //               headingRowHeight: 40.0,  
            //  dataRowColor: MaterialStateProperty.all(Colors.white),
            // columnSpacing: 0,
            // horizontalMargin: 15,
            // minWidth: screenW*0.9,

            //             columns: [
            //                   DataColumn(
            //                 label: Center(
            //                   child: Text(
            //                     "Size", textScaleFactor: 1.0,
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 12,
            //                         fontFamily: 'Montserrat',
            //                         color: Color.fromARGB(255, 255, 255, 255)),
            //                   ),
            //                 ),
            //               ),
            //               DataColumn(
            //                 label: Center(
            //                   child: Text(
            //                     "Weight Range", textScaleFactor: 1.0,
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 12,
            //                         fontFamily: 'Montserrat',
            //                         color: Color.fromARGB(255, 255, 255, 255)),
            //                   ),
            //                 ),
            //               ),
            //               DataColumn(
            //                 label: Center(
            //                   child: Text(
            //                     "Percent", textScaleFactor: 1.0,
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 12,
            //                         fontFamily: 'Montserrat',
            //                         color: Color.fromARGB(255, 255, 255, 255)),
            //                   ),
            //                 ),
            //               ),
            //               DataColumn(
            //                 label: Center(
            //                   child: Text(
            //                     "Number", textScaleFactor: 1.0,
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 12,
            //                         fontFamily: 'Montserrat',
            //                         color: Color.fromARGB(255, 255, 255, 255)),
            //                   ),
            //                 ),
            //               ),
            //             ], 
            //               rows: widget.nowresult6_1!.map((item) {
            //           return DataRow(cells: [
            //             DataCell(Center(child: Text(item['c_size'] , textScaleFactor: 1.0,style: TextStyle(
                               
            //                         fontSize: 12,
            //                         fontFamily: 'Montserrat',
            //                         color: Color.fromARGB(255, 0, 0, 0)),))),
            //             DataCell(Center(child: Text(item['c_range'] , textScaleFactor: 1.0,style: TextStyle(
                                    
            //                         fontSize: 12,
            //                         fontFamily: 'Montserrat',
            //                         color: Color.fromARGB(255, 0, 0, 0)),))),
            //             DataCell(Center(child: Text(item['n_percent'] , textScaleFactor: 1.0,style: TextStyle(
                                 
            //                         fontSize: 12,
            //                         fontFamily: 'Montserrat',
            //                         color: Color.fromARGB(255, 0, 0, 0)),))),
            //             DataCell(Center(child: Text(item['n_number'].toString() , textScaleFactor: 1.0,style: TextStyle(
                                   
            //                         fontSize: 12,
            //                         fontFamily: 'Montserrat',
            //                         color: Color.fromARGB(255, 0, 0, 0)),)))
            //           ]);
            //         }).toList(),
            //           ),
                    // )
                  ),
                   Container(
              margin: EdgeInsets.only(top: 5),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
          ],
        ),
      )
    );
  }
}