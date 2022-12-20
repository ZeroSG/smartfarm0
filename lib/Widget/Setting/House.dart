import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../API_E_B/API_E.dart';

class House extends StatefulWidget {
   String? Token;
   int? farmnum;
   List<dynamic>? house;
   List<dynamic>? Feed;
   House({ Key? key ,this.Token,this.farmnum,this.house}) : super(key: key);

  @override
  State<House> createState() => _HouseState();
}

class _HouseState extends State<House> {
  late double screenW, screenH;
   late List<dynamic>? House = widget.house;
 late String Housename = widget.house![0]['name'];
 late int Houseid = widget.house![0]['id'];
  late List<dynamic>? Silo = nowresult1_2;
 late String? Siloname=nowresult1_2[0]['c_name'];
  bool Check = false;
  late int Checkid = 0;

   //House
   late TextEditingController Minimum_Usage = TextEditingController();
  late TextEditingController Maximum_Usage = TextEditingController();
  late TextEditingController  Minimum_Weight = TextEditingController();
  late TextEditingController Maximum_Weight = TextEditingController();
  late TextEditingController  Target_Weight = TextEditingController();
  // Silo
  late double Siloid = nowresult1_2[0]["n_silo"];
  late TextEditingController Capacity = TextEditingController();
  late TextEditingController Topup = TextEditingController();
  late TextEditingController  Very_Lower  = TextEditingController();
  late TextEditingController Lower = TextEditingController();
  late TextEditingController Upper_Percent = TextEditingController();

  bool loading1 = true;
  List<dynamic> nowresult1_1 = []; 
  List<dynamic> nowresult1_2 = []; 
    Future<void> getjaon1_setting_house() async {
    try {
      loading1 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/setting/setting-house");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "Farm": widget.farmnum,
  "House": Houseid
}));
      if (ressum.statusCode == 200) {
        var result1_1 = json.decode(ressum.body)['result']['view1'];
        var result1_2 = json.decode(ressum.body)['result']['view2'];
        
       setState(() {
         //print("House===> $result1_1",);
  
         nowresult1_1 = result1_1;
          nowresult1_2 = result1_2;
         Minimum_Usage.text= nowresult1_1[0]["n_min_intake_percent"].toString();
  Maximum_Usage.text= nowresult1_1[0]["n_max_intake_percent"].toString();
  Minimum_Weight.text= nowresult1_1[0]["n_min_weight_percent"].toString();
  Maximum_Weight.text= nowresult1_1[0]["n_max_weight_percent"].toString();
  Target_Weight.text= nowresult1_1[0]["n_target_weight"].toString();

   

   if(nowresult1_1[0]["n_use_process"]==0){
     Check = false;
   } 
   else if(nowresult1_1[0]["n_use_process"]==1){
      Check = true; 
   } 

  
         Capacity.text= nowresult1_2[0]["n_capacity"].toString();
  Topup.text= nowresult1_2[0]["n_topup"].toString();
  Very_Lower.text= nowresult1_2[0]["n_verylower_percent"].toString();
  Lower.text= nowresult1_2[0]["n_lower_percent"].toString();
  Upper_Percent.text= nowresult1_2[0]["n_upper_percent"].toString();
   
    
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
    getjaon1_setting_house();
    // _createSampleData();
  }
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
            body:  SingleChildScrollView(
         physics: BouncingScrollPhysics(),
              child: Container(
                  
                      child: loading1
            ? Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator()))
            : Column(
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
                                    Text('House',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        fontFamily: 'Montserrat',
                                                        color: Color.fromARGB(255, 25, 25, 25),
                                                        ),),   
                                                          
                                    ],
                                  ),
                       //House
                        House1(),
                        Check2(),
                        MinMax_Usage3(),
                        MinMax_Weight4(),
                        Target5(),
                        //Silo
                        Silo6(),
                        Capacity_Topup7(),
                        Very_Lower8(),
                        Upper9(),
            
                        Save(),
                        ],
                      ),
                    ),
            ),
    );
  }

  Container Save() {
    return Container(
      margin: EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(''),
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
                            //  print(Houseid);
                            //  print(Housename);

                             
  

                             double MinimumU = double.parse(Minimum_Usage.text);
                            String Usage1 = MinimumU.toStringAsFixed(0);
                            int MinU = int.parse(Usage1);

                            double MaximumU = double.parse(Maximum_Usage.text);
                            String Usage2 = MaximumU.toStringAsFixed(0);
                            int MaxU = int.parse(Usage2);

                              double MinimumW = double.parse(Minimum_Weight.text);
                            String Weight1 = MinimumW.toStringAsFixed(0);
                            int MinW = int.parse(Weight1);

                            double MaximumW = double.parse(Maximum_Weight.text);
                            String Weight2 = MaximumW.toStringAsFixed(0);
                            int MaxW = int.parse(Weight2);

                            double Target = double.parse(Target_Weight.text);
                            String Weight = Target.toStringAsFixed(0);
                            int T_W = int.parse(Weight);


                            //  print('=======2=========');
                            //  print(Checkid);
                            //  print(MinU);
                            //  print(MaxU);
                            //  print(MinW);
                            //   print(MaxW);
                            //    print(T_W);

                             API_edit_setting_house_1(widget.Token,widget.farmnum,Houseid,Housename,Checkid,MinU,MaxU,MinW,MaxW,T_W);

                          
                            String num = Siloid.toStringAsFixed(0);
                            int Siloidnum = int.parse(num);

                                double Cap = double.parse(Capacity.text);
                            String acity = Cap.toStringAsFixed(0);
                            int Cap_acity = int.parse(acity);

                            double Top = double.parse(Topup.text);
                            String up = Top.toStringAsFixed(0);
                            int Top_up = int.parse(up);

                              double Very = double.parse(Very_Lower.text);
                            String Lower1 = Very.toStringAsFixed(0);
                            int Very_Lower1 = int.parse(Lower1);

                            double L = double.parse(Lower.text);
                            String ower = L.toStringAsFixed(0);
                            int L_ower = int.parse(ower);

                            double Upper = double.parse(Upper_Percent.text);
                            String Percent = Upper.toStringAsFixed(0);
                            int U_P = int.parse(Percent);


                             print('=======2=========');
                             print(Siloidnum);
                             print(Siloname);
                             print(Cap_acity);
                             print(Top_up);
                             print(Very_Lower1);
                              print(L_ower);
                               print(U_P);
                             API_edit_setting_silo_2(widget.Token,widget.farmnum,Houseid,Siloidnum,Siloname,Cap_acity,Top_up,Very_Lower1,L_ower,U_P);
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
   //Silo
  Container Upper9() {
    return Container(
    margin: EdgeInsets.only(top: 20,right: 10,left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Container(
        width: screenW*0.45,
        child:  Column(children: [
        Container(
           width: screenW*0.45,
            margin: EdgeInsets.only(left: 5),
          child: Text('Upper Percent',
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
borderRadius: BorderRadius.circular(30),
color: Colors.white,
),
height: 40,
width: screenW*0.45,
child: TextField(
 controller: Upper_Percent,
keyboardType: TextInputType.emailAddress,
style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
decoration: InputDecoration(
// filled: true,
contentPadding: EdgeInsets.only(top: 10,left: 10),
border: InputBorder.none,
hintStyle: TextStyle(color: Color(0xff7d7d7d)),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(30),
borderSide: BorderSide(color: Color(0xffcfcfcf)),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(30),
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

  Container Very_Lower8() {
    return Container(
              margin: EdgeInsets.only(top: 20,right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: screenW*0.45,
                  child:  Column(children: [
                  Container(
                     width: screenW*0.45,
                      margin: EdgeInsets.only(left: 5),
                    child: Text('Very Lower Percent',
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
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            height: 40,
            width: screenW*0.45,
            child: TextField(
               controller: Very_Lower,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                // filled: true,
                contentPadding: EdgeInsets.only(top: 10,left: 10),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xffcfcfcf)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xffcfcfcf)),
                ),
              ),
            ),
          )
                  ],),
                ),
                Container(
                  width: screenW*0.45,
                  child: Column(children: [
                    Container(
                     width: screenW*0.45,
                     margin: EdgeInsets.only(left: 5),
                    child: Text('Lower Percent',
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
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 255, 255, 255)
            ),
            height: 40,
            width: screenW*0.45,
            child: TextField(
               controller: Lower,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                // filled: true,
                contentPadding: EdgeInsets.only(top: 10,left: 10),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xffcfcfcf)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
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

  Container Capacity_Topup7() {
    return Container(
              margin: EdgeInsets.only(top: 20,right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: screenW*0.45,
                  child:  Column(children: [
                  Container(
                     width: screenW*0.45,
                      margin: EdgeInsets.only(left: 5),
                    child: Text('Capacity',
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
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            height: 40,
            width: screenW*0.45,
            child: TextField(
               controller: Capacity,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                // filled: true,
                contentPadding: EdgeInsets.only(top: 10,left: 10),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color(0xff7d7d7d)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xffcfcfcf)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xffcfcfcf)),
                ),
              ),
            ),
          )
                  ],),
                ),
                Container(
                  width: screenW*0.45,
                  child: Column(children: [
                    Container(
                     width: screenW*0.45,
                     margin: EdgeInsets.only(left: 5),
                    child: Text('Topup',
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
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 255, 255, 255)
            ),
            height: 40,
            width: screenW*0.45,
            child: TextField(
               controller: Topup,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                // filled: true,
                contentPadding: EdgeInsets.only(top: 10,left: 10),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xffcfcfcf)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
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

  Container Silo6() {
    return Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(children: [
                Container(
                  width: screenW*0.95,
                  child: Text('Silo',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: Color.fromARGB(255, 25, 25, 25),
                                        ),),
                ),
                 Center(
                child: Container(
                   margin: EdgeInsets.only(top: 10),
                  height: 40,
                  width: screenW*0.95,
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
                        value: Siloname,
                        items:  Silo!
                            .map((Silo) => DropdownMenuItem<String>(
                                value: Silo['c_name'],
                                child: Text(
                                  Silo['c_name'],
                                  style: TextStyle(
                                    fontSize: 12,
                                     fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  ),
                                )))
                            .toList(),
                        onChanged: (Silo) {
                         setState(() {
                              
                                    Siloname = Silo!;
                             for(int i = 0 ; i< nowresult1_2.length;i++){
                       if(nowresult1_2[i]['c_name'] == Siloname){
                         Siloid= nowresult1_2[i]["n_silo"];
                       Capacity.text= nowresult1_2[i]["n_capacity"].toString();
                       Topup.text= nowresult1_2[i]["n_topup"].toString();
                       Very_Lower.text= nowresult1_2[i]["n_verylower_percent"].toString();
                      Lower.text= nowresult1_2[i]["n_lower_percent"].toString();
                      Upper_Percent.text= nowresult1_2[i]["n_upper_percent"].toString();
      }
    }
                                  });
                        }),
                                ),
                    ),
                  ),
                )), 
              ]),
            );
  }

  //House
  Container Target5() {
    return Container(
      margin: EdgeInsets.only(top: 20,right: 10,left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          width: screenW*0.45,
          child:  Column(children: [
          Container(
             width: screenW*0.45,
              margin: EdgeInsets.only(left: 5),
            child: Text('Target Weight(gram)',
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
borderRadius: BorderRadius.circular(30),
color: Colors.white,
),
height: 40,
width: screenW*0.45,
child: TextField(
 controller: Target_Weight,
keyboardType: TextInputType.emailAddress,
style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
decoration: InputDecoration(
// filled: true,
contentPadding: EdgeInsets.only(top: 10,left: 10),
border: InputBorder.none,
hintStyle: TextStyle(color: Color(0xff7d7d7d)),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(30),
borderSide: BorderSide(color: Color(0xffcfcfcf)),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(30),
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

  Container MinMax_Weight4() {
    return Container(
              margin: EdgeInsets.only(top: 20,right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: screenW*0.45,
                  child:  Column(children: [
                  Container(
                     width: screenW*0.45,
                      margin: EdgeInsets.only(left: 5),
                    child: Text('Minimum Weight Percent',
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
    borderRadius: BorderRadius.circular(30),
    color: Colors.white,
  ),
  height: 40,
  width: screenW*0.45,
  child: TextField(
     controller: Minimum_Weight,
    keyboardType: TextInputType.emailAddress,
    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    decoration: InputDecoration(
      // filled: true,
      contentPadding: EdgeInsets.only(top: 10,left: 10),
      border: InputBorder.none,
      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xffcfcfcf)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xffcfcfcf)),
      ),
    ),
  ),
)
                  ],),
                ),
                Container(
                  width: screenW*0.45,
                  child: Column(children: [
                    Container(
                     width: screenW*0.45,
                     margin: EdgeInsets.only(left: 5),
                    child: Text('Maximum Weight Percent',
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
    borderRadius: BorderRadius.circular(30),
    color: Color.fromARGB(255, 255, 255, 255)
  ),
  height: 40,
  width: screenW*0.45,
  child: TextField(
     controller: Maximum_Weight,
    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    decoration: InputDecoration(
      // filled: true,
      contentPadding: EdgeInsets.only(top: 10,left: 10),
      border: InputBorder.none,
      hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xffcfcfcf)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
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

  Container MinMax_Usage3() {
    return Container(
              margin: EdgeInsets.only(top: 20,right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: screenW*0.45,
                  child:  Column(children: [
                  Container(
                     width: screenW*0.45,
                      margin: EdgeInsets.only(left: 5),
                    child: Text('Minimum Usage Percent',
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
    borderRadius: BorderRadius.circular(30),
    color: Colors.white,
  ),
  height: 40,
  width: screenW*0.45,
  child: TextField(
     controller: Minimum_Usage,
    keyboardType: TextInputType.emailAddress,
    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    decoration: InputDecoration(
      // filled: true,
      contentPadding: EdgeInsets.only(top: 10,left: 10),
      border: InputBorder.none,
      hintStyle: TextStyle(color: Color(0xff7d7d7d)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xffcfcfcf)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xffcfcfcf)),
      ),
    ),
  ),
)
                  ],),
                ),
                Container(
                  width: screenW*0.45,
                  child: Column(children: [
                    Container(
                     width: screenW*0.45,
                     margin: EdgeInsets.only(left: 5),
                    child: Text('Maximum Usage Percent',
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
    borderRadius: BorderRadius.circular(30),
    color: Color.fromARGB(255, 255, 255, 255)
  ),
  height: 40,
  width: screenW*0.45,
  child: TextField(
     controller: Maximum_Usage,
    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    decoration: InputDecoration(
      // filled: true,
      contentPadding: EdgeInsets.only(top: 10,left: 10),
      border: InputBorder.none,
      hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xffcfcfcf)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
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

  Container Check2() {
    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                           Checkbox(
            value: Check,
            // activeColor: Color(0xff83bb56),
            visualDensity: VisualDensity.compact,
            onChanged: (bool? value) {
              setState(() {
                Check = value!;
                print(value);
                if(value == true){
                  Checkid = 1;
                }else{
                   Checkid = 0;
                }
              });
               
                        },
            // onChanged: (val) => onTap(val),
          ),
                          Flexible(
            child: 
                Text(
                  'Use Process Order',
                  style: TextStyle(
                           fontSize: 15,
                          // fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
               
               
              
          ),
                        ],
                      ),
                    );
  }

  Container House1() {
    return Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(children: [
                 Center(
                child: Container(
                   margin: EdgeInsets.only(top: 10),
                  height: 40,
                  width: screenW*0.95,
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
                        value: Housename,
                        items:  House!
                            .map((House) => DropdownMenuItem<String>(
                                value: House['name'],
                                child: Text(
                                  House['name'],
                                  style: TextStyle(
                                    fontSize: 13,
                                     fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  ),
                                )))
                            .toList(),
                        onChanged: (House1) {
                         setState(() {
                              
                                    Housename = House1!;
                              for(int i = 0 ; i< House!.length;i++){
                                if(House![i]['name'] == Housename) {
                                    Houseid = House![i]['id'];
                                }
           }
                                getjaon1_setting_house();
                                  });
                        }),
                                ),
                    ),
                  ),
                )), 
              ]),
            );
  }
}