// import 'dart:io';

// import 'package:excel/excel.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class D extends StatefulWidget {
//    D({super.key});

//   @override
//   State<D> createState() => _DState();
// }

// class _DState extends State<D> {
//   var selectedExcel;
//   List tbleRows = [];


//   late List<dynamic> _products1 =[];
//   pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       String file = result.files.single.path.toString();
//     File  file1 = File(file);
//        print(file1);
//       var bytes = file1.readAsBytesSync();
//       var excel = Excel.decodeBytes(bytes,);
      
//       setState(() {
//         selectedExcel = excel;
//         tbleRows.clear(); 
//       });
//        print(selectedExcel["Sheet1"].sheetName);
//       Sheet sheet = selectedExcel["Sheet1"];
      
//        for (var table in excel.tables.keys) {

//       for (var row in excel.tables[table]!.rows) {
  
//         setState(() {
          
//           tbleRows.add(row);
//          _products1 =  List.generate(tbleRows.length, (i) {
//     return {"1": '', "2": "", "3": '', "4": '', "5": ''};
      
//   });
 
//         });
//       }
//     }
//     List<dynamic> _products2 = ['1','2','3','4','5'];
//       for(int i = 0;i<tbleRows.length;i++){
//         for(int f = 0;f<tbleRows[i].length;f++){
//           setState(() {
//             _products1[i]['${_products2[f]}'] += tbleRows[i][f].value.toString();
//           });

//         }
//       }
//      print("_products1 ${_products1}");
//     } else {
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
  
//      onPressed: pickFile,
//   child: selectedExcel == null? Text(
//      "Pick from storage",
//       style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
// ): Column(
//   children: [
//         Text(
    
//          "${selectedExcel["Sheet1"].sheetName}",
    
//           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    
//     ),
//     Text(
    
//          "${tbleRows[0][0].value} ${tbleRows[0][1].value}",
    
//           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    
//     ),
//     Text(
    
//          "${tbleRows[1][0].value} ${tbleRows[1][1].value} ",
    
//           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    
//     ),
//     Text(
    
//          "${tbleRows[2][0].value} ${tbleRows[2][1].value}",
    
//           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    
//     ),
//     Text(
    
//          "${selectedExcel["Sheet1"].rows.length}",
    
//           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    
//     ),
//   ],
// )),
//       ),
//     );
//   }
// }