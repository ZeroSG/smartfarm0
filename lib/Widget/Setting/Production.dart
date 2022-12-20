import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:http/http.dart' as http;

import '../API_E_B/API_B.dart';
import '../API_E_B/API_E.dart';

class Production extends StatefulWidget {
   String? Token;
   int? farmnum;
   List<dynamic>? default_formula;
   List<dynamic>? default_planning;
   Production({ Key? key ,this.Token,this.farmnum,this.default_formula,this.default_planning}) : super(key: key);

  @override
  State<Production> createState() => _ProductionState();
}

class _ProductionState extends State<Production> {
 late  String Crop = 'start crop';
  late Color color = Colors.green;

  bool Crop1 = false;
   List<dynamic>? NoList =[''];
   String? Noname ='';

  late String? name_h;
     late TextEditingController Sub_Crop = TextEditingController();
  late TextEditingController Date_Start = TextEditingController();
  late TextEditingController Date_End = TextEditingController();
  late TextEditingController 	Number_Of_animal = TextEditingController();
  late TextEditingController Age = TextEditingController();
String? _chosenValue;

 late List<dynamic>? Silo  = widget.default_planning;
 late String Siloname;
   late List<dynamic>? Standard  = widget.default_formula;
   String? Standardname;
  late double screenW, screenH;
   int selected1 = 0;
   bool Download0 = true;
  int Check = 0;
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
            '${nowresult1_1[index]['c_name']}',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Color(0xff44bca3)),
          )
        ),
        children: [
          Sub_Crop_11(index),
          DateSE_12(index),
          Standard_Silo_13(index),
          Number_Age_14(index),
          // Save_New(),
        ],
      ),
    );
  }

  Container newMethodRadio() {
    return Container(
      margin: EdgeInsets.only(left: screenW * 0.07),
      child: Row(
        children: [
          Radio(
            activeColor: Color(0xff44bca3),
            value: 0,
            groupValue: Check,
            onChanged: (val) {
              setState(() {
                Check = 0;
              });
            },
          ),
          Text(
            'Not Set',
            style: new TextStyle(fontSize: 15.0,
            fontFamily: 'Montserrat',),
          ),
          Radio(
            activeColor: Color(0xff44bca3),
            value: 1,
            groupValue: Check,
            onChanged: (val) {
              setState(() {
                Check = 1;
              });
            },
          ),
          Text(
            'By Farm',
            style: new TextStyle(fontSize: 15.0,fontFamily: 'Montserrat',),
          ),
          Radio(
            activeColor: Color(0xff44bca3),
            value: 2,
            groupValue: Check,
            onChanged: (val) {
              setState(() {
                Check = 2;
              });
            },
          ),
          Text(
            'By House',
            style: new TextStyle(fontSize: 15.0,fontFamily: 'Montserrat',),
          ),
        ],
      ),
    );
  }

   
   Container Save_New(context,StateSetter setState) {
    return Container(
      margin: EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
                          margin: EdgeInsets.only(top: 10, right: 10),
                          height: 35,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.red,
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  // stops: [0.3, 1],
                                  colors: [
                                    Color.fromARGB(255, 238, 160, 160),
                                    Color.fromARGB(255, 228, 94, 107)
                                  ])),

                          //  width: screenW*0.5,
                          child: TextButton(
                            onPressed: () {
                               Navigator.pop(context);
                            },
                            child: Text(
                              'New',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                        ),
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
                              
                            //   print('=======1=========');
                            //  print(widget.Token);
                            //  print(widget.farmnum);
                            //  print(int.parse(name_h!));

                            //  print('=======2=========');
                            //   print(Sub_Crop.text);
                               late var dayS = dateTimeStart!.day.toString().padLeft(2, '0');
                               late var monthS = dateTimeStart!.month.toString().padLeft(2, '0');
                               late var yearS = dateTimeStart!.year.toString().padLeft(4, '0');
                              // print('$yearS-$monthS-$dayS 00:00:00.000');
                            
                              if(dateTimeEnd == null){
                                dateTimeEnd = DateTime.now();
                              }
                                late var dayE = dateTimeEnd!.day.toString().padLeft(2, '0');
                               late var monthE= dateTimeEnd!.month.toString().padLeft(2, '0');
                               late var yearE = dateTimeEnd!.year.toString().padLeft(4, '0');
                              // print('$yearE-$monthE-$dayE 00:00:00.000');
                                     
                                   
                                 double Number = double.parse(Number_Of_animal.text);
                            String animal = Number.toStringAsFixed(0);
                            int M_A = int.parse(animal);

                            double A = double.parse(Age.text);
                            String ge = A.toStringAsFixed(0);
                            int AGE = int.parse(ge);     
                            //    print('=======3=========');
                            //   print(Standardname);
                            //   print(Siloname);
                              
                            //  print(M_A);
                            //   print(AGE);
                    
                             
                            API_edit_setting_production(widget.Token,widget.farmnum,int.parse(name_h!),Sub_Crop.text,
                            '$yearS-$monthS-$dayS 00:00:00.000','$yearE-$monthE-$dayE 00:00:00.000',
                            Standardname,Siloname,M_A,AGE);

                            getjaon1_settin_production();
                              Navigator.pop(context);


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
      ],),
    );
  }

  Container Number_Age4(StateSetter setState) {
    return Container(
        margin: EdgeInsets.only(top: 20,right: 10,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            width: screenW*0.35,
            child:  Column(children: [
            Container(
               width: screenW*0.35,
                margin: EdgeInsets.only(left: 5),
              child: Text('Number of animal :',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 25, 25, 25),
                                ),)),
            Container(
              margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
   border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Colors.white
),
height: 40,
width: screenW*0.35,
child: TextField(
 controller: Number_Of_animal,

style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
decoration: InputDecoration(
// filled: true,
contentPadding: EdgeInsets.only(top: 10,left: 10),
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
            ],),
          ),
          Container(
            width: screenW*0.35,
            child: Column(children: [
              Container(
               width: screenW*0.35,
               margin: EdgeInsets.only(left: 5),
              child: Text('Age of animal :',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 25, 25, 25),
                                ),)),
              Container(
              margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
color: Colors.white
),
height: 40,
width: screenW*0.35,
child: TextField(
   controller: Age,
style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
decoration: InputDecoration(
// filled: true,
contentPadding: EdgeInsets.only(top: 10,left: 10),
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
            ],),
          )
        ],),
      );
  }
  Container Number_Age_14(index) {
    return Container(
        margin: EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            width: screenW*0.40,
            child:  Column(children: [
            Container(
               width: screenW*0.40,
                margin: EdgeInsets.only(left: 5),
              child: Text('Number of animal :',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 25, 25, 25),
                                ),)),
            Container(
              margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
   border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
),
height: 40,
width: screenW*0.40,
child: Padding(
  padding: const EdgeInsets.all(10.0),
  child:   nowresult1_1[index]['n_number'] ==null?  Text('',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),)
  :     Text('${nowresult1_1[index]['n_number']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),),
)
)
            ],),
          ),
          Container(
            width: screenW*0.40,
            child: Column(children: [
              Container(
               width: screenW*0.40,
               margin: EdgeInsets.only(left: 5),
              child: Text('Age of animal :',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Color.fromARGB(255, 25, 25, 25),
                                ),)),
              Container(
              margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
),
height: 40,
width: screenW*0.40,
child: Padding(
  padding: const EdgeInsets.all(10.0),
  child:   nowresult1_1[index]['n_age'] ==null?  Text('',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),)
  :      Text('${nowresult1_1[index]['n_age']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),),
)
)
            ],),
          )
        ],),
      );
  }
  Container Standard_Silo3(StateSetter setState) {
 
    return Container(
          margin: EdgeInsets.only(top: 20,right: 10,left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: screenW*0.35,
              child:  Column(children: [
              Container(
                 width: screenW*0.35,
                  margin: EdgeInsets.only(left: 5),
                child: Text('Standard Formula :',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  ),)),
              Container(
                margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Colors.white
),
height: 40,
width: screenW*0.35,
 child: Padding(
                         padding: EdgeInsets.only(left: 10, right: 10),
                        child: DropdownButtonHideUnderline(
                                    child:widget.default_formula == null ? DropdownButton<String>(
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
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (NoView_by) {
                              setState(() {
                              });
                              
                            })
                                      : DropdownButton<String>(
                                      icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                          // value:nowresult1_1[index]['c_feedtype'] == null ? Standardname: nowresult1_1[index]['c_feedtype'],
                          value: Standardname,
                          items:  Standard!
                              .map((Standard) => DropdownMenuItem<String>(
                                  value: Standard['name'],
                                  child: Text(
                                    Standard['name'],
                                    style: TextStyle(
                                      fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  )))
                              .toList(),
                              
                          onChanged: (Standard) {
                           setState(() {
                                
                                      Standardname = Standard!;
                         
                                    });
                          }),
                                  ),
                      ),
)
              ],),
            ),
            Container(
              width: screenW*0.35,
              child: Column(children: [
                Container(
                 width: screenW*0.35,
                 margin: EdgeInsets.only(left: 5),
                child: Text('Silo Planning :',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  ),)),
                Container(
                margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
color: Colors.white
),
height: 40,
width: screenW*0.35,
 child: Padding(
                         padding: EdgeInsets.only(left: 10, right: 10),
                        child: DropdownButtonHideUnderline(
                                    child:widget.default_planning == null ? DropdownButton<String>(
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
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (NoView_by) {
                              setState(() {
                              });
                              
                            })
                                      : DropdownButton<String>(
                                      icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                            value: Siloname,
                          items:  Silo! 
                              .map((Silo) => DropdownMenuItem<String>(
                                  value: Silo['name'],
                                  child: Text(
                                    Silo['name'],
                                    style: TextStyle(
                                      fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  )))
                              .toList(),
                          onChanged: (Silo) {
                           setState(() {
                                
                                      Siloname = Silo!;
                         
                                    });
                          }),
                                  ),
                      ),
)
              ],),
            )
          ],),
        );
  }
  Container Standard_Silo_13(index) {
    return Container(
          margin: EdgeInsets.only(top: 20,right: 10,left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: screenW*0.40,
              child:  Column(children: [
              Container(
                 width: screenW*0.40,
                  margin: EdgeInsets.only(left: 5),
                child: Text('Standard Formula :',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  ),)),
              Container(
                margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
),
height: 40,
width: screenW*0.40,
child: Padding(
  padding: const EdgeInsets.all(10.0),
  child: nowresult1_1[index]['c_feedtype'] ==null?  Text('',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      ),)
  :   Text('${nowresult1_1[index]['c_feedtype']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      ),),
)
)
              ],),
            ),
            Container(
              width: screenW*0.40,
              child: Column(children: [
                Container(
                 width: screenW*0.40,
                 margin: EdgeInsets.only(left: 5),
                child: Text('Silo Planning :',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  ),)),
                Container(
                margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
),
height: 40,
width: screenW*0.40,
child: Padding(
  padding: const EdgeInsets.all(10.0),
  child:  nowresult1_1[index]['c_plan'] ==null?  Text('',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0)
                                      ),)
  :    Text('${nowresult1_1[index]['c_plan']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0)
                                      ),),
)
)
              ],),
            )
          ],),
        );
  }
 
 DateTime? dateTimeStart;
  DateTime? dateTimeStart1;

   DateTime? dateTimeEnd;
   DateTime? dateTimeEnd2 = DateTime.now() ;
    DateTime? dateTimeEnd1;
   late String? End1;

  Future<void>TimeStart(StateSetter setState) async{
    //  setState(() {
    //      dateTime_  = dateTime6;
    
    //    });

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

     if(ChooseDateTime != null){
       setState(() {

         dateTimeStart  = ChooseDateTime;
        //  dateTime6 = ChooseDateTime;
       });
     }
   }

   Future<void>TimeEnd(StateSetter setState) async{
     DateTime? ChooseDateTime2_1;


     if(dateTimeEnd == null){
       ChooseDateTime2_1 = await showDatePicker(
       
       context: context,
       firstDate: DateTime(DateTime.now().year - 5),
       lastDate: DateTime(DateTime.now().year + 5),
       initialDate: dateTimeEnd2!,
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
     }
    else{
      ChooseDateTime2_1 = await showDatePicker(
       
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

    }
     if(ChooseDateTime2_1 != null){
       setState(() {

         dateTimeEnd  = ChooseDateTime2_1;
        //  Date_End.text  = ChooseDateTime2.toIso8601String();
         //print('dateTimeEnd  $dateTimeEnd');
        //  dateTime6 = ChooseDateTime;
       });
     }
   }
 
  Container DateSE2(index,StateSetter setState) {
    return Container(
            margin: EdgeInsets.only(top: 20,right: 10,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                width: screenW*0.35,
                child:  Column(children: [
                Container(
                   width: screenW*0.35,
                    margin: EdgeInsets.only(left: 5),
                  child: Text('Date Start :',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                    ),)),
                Container(
                  margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
color: Colors.white
),
height: 40,
width: screenW*0.35,
child: Container(
   margin: EdgeInsets.only(top: 10,left: 10),
  child:   GestureDetector(
    onTap: (){
        TimeStart(setState);
    },
    child: Text("${dateTimeStart!.year}-${dateTimeStart!.month}-${dateTimeStart!.day}",
    
                                        style: TextStyle(
                                          fontSize: 13,
                                        fontFamily: 'Montserrat',
    
                                        color: Color.fromARGB(255, 0, 0, 0),
    
                                        ),),
  ),
)
)
                ],),
              ),
              Container(
                width: screenW*0.35,
                child: Column(children: [
                  Container(
                   width: screenW*0.35,
                   margin: EdgeInsets.only(left: 5),
                  child: Text('Date End :',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    ),)),
                  Container(
                  margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Colors.white
),
height: 40,
width: screenW*0.35,
child: Container(
  margin: EdgeInsets.only(top: 10,left: 10),
  child:    GestureDetector(
    onTap: (){
     TimeEnd(setState);
    },
    child: dateTimeEnd == null ? Text('')
    :Text("${dateTimeEnd!.year}-${dateTimeEnd!.month}-${dateTimeEnd!.day}",
    
                                        style: TextStyle(
                                          fontSize: 13,
                                        fontFamily: 'Montserrat',
                                        color: Color.fromARGB(255, 0, 0, 0),
    
                                        ),),
  ),
)
)
                ],),
              )
            ],),
          );
  }
 Container DateSE_12(index) {
     if(nowresult1_1[index]['c_datestart'] == null){
       dateTimeStart1 = null;
     }
     else{
        dateTimeStart1 = DateTime.parse('${nowresult1_1[index]['c_datestart']}');
     }
      if(nowresult1_1[index]['c_dateend'] == null){
       dateTimeEnd1 = null;
     }
     else{
        dateTimeEnd1 = DateTime.parse('${nowresult1_1[index]['c_dateend']}');
     }

    return Container(
            margin: EdgeInsets.only(top: 20,right: 10,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                width: screenW*0.40,
                child:  Column(children: [
                Container(
                   width: screenW*0.40,
                    margin: EdgeInsets.only(left: 5),
                  child: Text('Date Start :',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                    ),)),
                Container(
                  margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
),
height: 40,
width: screenW*0.40,
child: Padding(
  padding: const EdgeInsets.all(10.0),
  child: dateTimeStart1 == null ? Text("",
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      ),) 
                                      :Text("${dateTimeStart1!.year}-${dateTimeStart1!.month}-${dateTimeStart1!.day}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      ),),
)
)
                ],),
              ),
              Container(
                width: screenW*0.40,
                child: Column(children: [
                  Container(
                   width: screenW*0.40,
                   margin: EdgeInsets.only(left: 5),
                  child: Text('Date End :',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                    ),)),
                  Container(
                  margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
  border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
),
height: 40,
width: screenW*0.40,
child: Padding(
  padding: const EdgeInsets.all(10.0),
  child:  dateTimeEnd1 == null ? Text("",
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),) 
                                      : Text("${dateTimeEnd1!.year}-${dateTimeEnd1!.month}-${dateTimeEnd1!.day}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),),
)
)
                ],),
              )
            ],),
          );
  }
  Container Sub_Crop1(StateSetter setState) {
    return Container(
            margin: EdgeInsets.only(top: 20,right: 10,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                width: screenW*0.35,
                child:  Column(children: [
                Container(
                   width: screenW*0.35,
                    margin: EdgeInsets.only(left: 5),
                  child: Text('Sub Crop :',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    ),)),
                Container(
                  margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
   border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Colors.white
),
height: 40,
width: screenW*0.35,
child: TextField(
   controller: Sub_Crop,
  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  decoration: InputDecoration(
    // filled: true,
    contentPadding: EdgeInsets.only(top: 10,left: 10),
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
                ],),
              ),
          
            ],),
          );
  }
  

 


   
  Container Sub_Crop_11(int index) {
   DateTime?  dateTime=DateTime.now();
    //      if(nowresult1_1[index]['c_feedtype'] != null){
    //    setState(() {
    //       Standardname = nowresult1_1[index]['c_feedtype'];
    //    });
      
    //  }
    //  else{
    //    setState(() {
    //      Standardname = widget.default_planning![0]['c_feedtype'];
    //    });
    //  }
    return Container(
            margin: EdgeInsets.only(top: 20,right: 10,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                width: screenW*0.40,
                child:  Column(children: [
                Container(
                   width: screenW*0.40,
                    margin: EdgeInsets.only(left: 5),
                  child: Text('Sub Crop :',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                    ),)),
                Container(
                  margin: EdgeInsets.only(top: 5),
decoration: BoxDecoration(
   border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
  borderRadius: BorderRadius.circular(5),
 color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
),
height: 40,
width: screenW*0.40,
child: Padding(
  padding: const EdgeInsets.all(10.0),
  child:  nowresult1_1[index]['c_namecrop'] ==null?  Text('',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),)
  :   Text('${nowresult1_1[index]['c_namecrop']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),),
)
)
                ],),
              ),
           Center(
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
                              
                              setState(() {
                         name_h = nowresult1_1[index]['n_house'].toStringAsFixed(0);
                        //  print(name_h);
          if(nowresult1_1[index]['c_namecrop']==null){
             Sub_Crop.text = '${dateTime.year}-${dateTime.month}';
          }    
          else{
             Sub_Crop.text = nowresult1_1[index]['c_namecrop'].toString();
          }          
          if(nowresult1_1[index]['c_datestart']==null){
             Date_Start.text = dateTime.toIso8601String();
          }    
          else{
             Date_Start.text = nowresult1_1[index]['c_datestart'].toString();
          }     
          if(nowresult1_1[index]['c_dateend']==null){
             Date_End.text = dateTime.toIso8601String();
          }    
          else{
             Date_End.text = nowresult1_1[index]['c_dateend'].toString();
          }   
               
               
               if(nowresult1_1[index]['n_number']==null){
             Number_Of_animal.text = "0";
          }    
          else{
             Number_Of_animal.text = nowresult1_1[index]['n_number'].toString();
          }   

               if(nowresult1_1[index]['n_age']==null){
             Age.text = "0";
          }    
          else{
             Age.text = nowresult1_1[index]['n_age'].toString();
          }                     

    });



    //
       if(widget.default_formula == null){
           
       }
       else{
         if(nowresult1_1[index]['c_feedtype'] != null){
       setState(() {
          Standardname = nowresult1_1[index]['c_feedtype'];
       });
      
     }
     else{
       setState(() {
         Standardname = widget.default_formula![0]['name'];
       });
     }
       }
     if(widget.default_planning == null){
           
       }
       else{
          if(nowresult1_1[index]['c_plan'] != null){
       setState(() {
          Siloname = nowresult1_1[index]['c_plan'];
            // Siloname = widget.default_planning![0]['name'];
       });
      
     }
     else{
       setState(() {
         Siloname = widget.default_planning![0]['name'];
       });
     }
       }     
        


      if(nowresult1_1[index]['c_datestart'] != null){
         setState(() {
         dateTimeStart=DateTime.parse('${nowresult1_1[index]['c_datestart']}',);
       });
        
    }
    else{
        setState(() {
       dateTimeStart=DateTime.now();
    
       });
    
    }
    if(nowresult1_1[index]['c_dateend'] != null){
       setState(() {
      dateTimeEnd=DateTime.parse('${nowresult1_1[index]['c_dateend']}',);
      // End1 = '${dateTimeEnd!.year}-${dateTimeEnd!.month}-${dateTimeEnd!.day}';
       });
      
    }
    else{
      setState(() {
     dateTimeEnd=null;

     End1 = '';
       });

    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return Dialog(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
              child: Container(
                   height: 500,
                width: screenW * 1,
                child: Column(
                  children: <Widget>[
                                               Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 15, left: 10),
                            height: screenH * 0.06,
                            child: Text(
                               '${nowresult1_1[index]['c_name']}',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'THSarabun',
                                  color: Color.fromARGB(255, 0, 0, 0)),
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
            
                     Sub_Crop1(setState),
                     DateSE2(index,setState),
                     Standard_Silo3(setState),
                      Number_Age4(setState),
                    Save_New(context,setState),
                  ],
                ),
              ),
            ),
          );
          },
                  
        );
      },
    );
                            },
                            icon: Icon(MdiIcons.clipboardEdit,
                              color: Color.fromARGB(255, 242, 3, 3),
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),   
            ],),
          );
  }

bool loading1 = true;
  List<dynamic> nowresult1_1 = []; 
    Future<void> getjaon1_settin_production() async {
    try {
      loading1 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/setting/setting-production");
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
        
       setState(() {
         //print("Production ==> $result1_1",);
        //   //print("${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2",);
         nowresult1_1 = result1_1;
         loading1 = false;
       });
    //     for(int index = 0 ; index< nowresult1_1.length;index++){
    //         if(nowresult1_1[index]['c_feedtype'] != null){
    //    setState(() {
    //       Standardname = nowresult1_1[index]['c_feedtype'];
    //    });
      
    //  }
    //  else{
    //    setState(() {
    //      Standardname = widget.default_planning![0]['c_feedtype'];
    //    });
    //  }
    //     }
//                if(nowresult1_1[index]['c_feedtype'] != null){
//                  setState(() {
//                    Standardname = nowresult1_1[index]['c_feedtype'];
//                  });
//     }else{
//       setState(() {
//         Standardname =  widget.default_formula![0]['name'];
//       });

//     }
//     if(nowresult1_1[index]['c_plan'] != null){
//       setState(() {
//          Siloname = nowresult1_1[index]['c_plan'];
//       });
//     }else {
//  setState(() {
//      Siloname = widget.default_planning![0]['name'];

//  });


//     }
//          }
          
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
    getjaon1_settin_production();
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
                                              Text('Production Set',
                                                                      style: TextStyle(
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight.bold,
                                                                      fontFamily: 'Montserrat',
                                                                      color: Color.fromARGB(255, 25, 25, 25),
                                                                      ),),
                                                  ],
                                                ),   
                        

                        GestureDetector(
                  onTap: (() {
                    if(Crop1 == false){
                      setState(() {
                        
                        Crop ='press to end crop';
                        color = Colors.red;
                        Crop1 = true;
                      });
                      print(Check);
                       print('start');
                      //  API_button_production_start(widget.Token,widget.farmnum,Check); 
                     
                    }
                    else if(Crop1 == true){
                       setState(() {
                        
                         Crop ='start crop';
                         color = Colors.green;
                          Crop1 = false;
                       });
           
                       
                      print('stop');
                      //  API_button_production_stop(widget.Token,widget.farmnum);
                    }
                  }),
                  child: Container(
                     width: 160,
                    height: 35,
                    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1),
      borderRadius: BorderRadius.circular(10),
      color: color,
    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Text(
                              Crop,
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

                  newMethodRadio(),                          
                  
                  Card(
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
                                          'House',
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
                                      itemCount: nowresult1_1.length,
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
                  ],
                ),
              ),
            ),
          ),
    );
  }
}