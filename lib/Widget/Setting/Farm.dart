import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../API_E_B/API_E.dart';


class Farm extends StatefulWidget {
   String? Token;
   int? farmnum;
   List<dynamic>? default_species;
   List<dynamic>? default_ship;
   Farm({ Key? key,this.Token ,this.farmnum,this.default_species,this.default_ship}) : super(key: key);
 
  @override
  State<Farm> createState() => _FarmState();
}

class _FarmState extends State<Farm> {
  // List<String> Species = ['Broiler Parent stock','Fattening Pig'];
  // String Speciesname = 'Broiler Parent stock';
 
    late double screenW, screenH;
     late List<dynamic>? Species = widget.default_species;


   late List<dynamic>? Ship_Condition = widget.default_ship;
 late String? Ship_Conditionname;

 late TextEditingController Speciesname1 = TextEditingController();
 late TextEditingController Speciesnum1 = TextEditingController();

  late TextEditingController Serial_SmartEE = TextEditingController();
  late TextEditingController Central_ID = TextEditingController();

   late TextEditingController Name = TextEditingController();
  late TextEditingController BTG_Plant = TextEditingController();
  late TextEditingController Farm_ID = TextEditingController();
  late TextEditingController Default_Density = TextEditingController();
  late TextEditingController Farm_Address = TextEditingController();
  late TextEditingController Supervisor = TextEditingController();
  late TextEditingController Phone = TextEditingController();
  late TextEditingController E_mail = TextEditingController();
  late TextEditingController Line_Token = TextEditingController();
  late TextEditingController Chamber_Number = TextEditingController();
  late TextEditingController Truck_Number = TextEditingController();
  late TextEditingController Chamber_Weight = TextEditingController();
  late TextEditingController Car_ID1 = TextEditingController();
  late TextEditingController Car_ID2 = TextEditingController();
  late TextEditingController Target_Uniform = TextEditingController();
  late String Ship_Conditionnum;
   late String Speciesname ;
  late int? Speciesnum;
 
bool loading1 = true;
  List<dynamic> nowresult1_1 = []; 
    Future<void> getjaon1_setting_farm() async {
    try {
      loading1 = true;
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/setting/setting-farm");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer ${widget.Token}",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
         "Farm": widget.farmnum,
}));
      if (ressum.statusCode == 200) {
        var result1_1 = json.decode(ressum.body)['result']['view1'];
        
       setState(() {
        //  //print("Farm ===>$result1_1",);
        //   //print("${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day} $dat2",);
         nowresult1_1 = result1_1;
  
       
  // FarmName.text = nowresult1_1[0]["c_name_ea"].toString();
  if(nowresult1_1[0]["c_serial"] == null){
        Serial_SmartEE.text= ' ';
  }else{
     Serial_SmartEE.text= nowresult1_1[0]["c_serial"].toString();
  }
   if(nowresult1_1[0]["c_notify_token"] == null){
        Line_Token.text= ' ';
  }else{
    Line_Token.text = nowresult1_1[0]["c_notify_token"].toString();
  }
   if(nowresult1_1[0]["n_central"] == null){
        Central_ID.text= ' ';
  }else{
     Central_ID.text= nowresult1_1[0]["n_central"].toString();
  }
  

   
  // print(widget.default_species![0]["name"].toString());
         
          // Speciesnum =nowresult1_1[0]["n_farm_type"];
          Speciesname =  widget.default_species![0]["name"];  
          Speciesnum =  widget.default_species![0]["id"];    
          for(int i = 0; i< Species!.length;i++){
                     if(nowresult1_1[0]["n_farm_type"]== Species![i]["id"]){
                      
                      
                        
                            Speciesname =  '${Species![i]["name"]}';  
                          Speciesnum =  widget.default_species![i]["id"];  
                      
                      
                //        print('i===${Species![i]["id"]}');
                //  Speciesname =  '${Species![i]["name"]}';     
                //  Speciesnum = i;
                  //  Speciesnum =  widget.default_species![i]["id"];  
                  //  Speciesname1.text =  Speciesname!; 
           }
           else{
                 
                      // Speciesname =  widget.default_species![0]["name"];   
                 
           
            //  Speciesnum =  widget.default_species![0]["id"];   
           }
           
           }
           

   
           for(int i = 0; i< widget.default_ship!.length;i++){
            if(nowresult1_1[0]["c_ship_cond"] == null){
               Ship_Conditionname  = widget.default_ship![1]["name"];  
               Ship_Conditionnum = widget.default_ship![1]["code"];  
            }
            else{
              if(nowresult1_1[0]["c_ship_cond"]== widget.default_ship![i]["code"]){
      
               Ship_Conditionname  = widget.default_ship![i]["name"];   
               Ship_Conditionnum = widget.default_ship![i]["code"];  
           }}
            }
           
         print(Speciesname);
  
  //  Ship_Conditionname = widget.default_species![0]["name"];



    if( nowresult1_1[0]["c_name_ea"] == null){
      Name.text= ' ';
   }else{
     Name.text= nowresult1_1[0]["c_name_ea"].toString();
   }

  if( nowresult1_1[0]["c_customer_sp"] == null){
      BTG_Plant.text= ' ';
   }else{
     BTG_Plant.text= nowresult1_1[0]["c_customer_sp"].toString();
   }
   if( nowresult1_1[0]["c_customer_sh"] == null){
      Farm_ID.text= ' ';
   }else{
     Farm_ID.text= nowresult1_1[0]["c_customer_sh"].toString();
   }
    if( nowresult1_1[0]["n_density"] == null){
      Default_Density.text= ' ';
   }else{
     Default_Density.text= nowresult1_1[0]["n_density"].toString();
   }
    if( nowresult1_1[0]["c_address"] == null){
      Farm_Address.text= ' ';
   }else{
     Farm_Address.text= nowresult1_1[0]["c_address"].toString();
   }
   if( nowresult1_1[0]["c_supervisor"] == null){
      Supervisor.text= ' ';
   }else{
     Supervisor.text= nowresult1_1[0]["c_supervisor"].toString();
   }
   if( nowresult1_1[0]["c_phone"] == null){
      Phone.text= ' ';
   }else{
     Phone.text= nowresult1_1[0]["c_phone"].toString();
   }

   if( nowresult1_1[0]["c_email"] == null){
      E_mail.text= ' ';
   }else{
     E_mail.text= nowresult1_1[0]["c_email"].toString();
   }

   if( nowresult1_1[0]["n_box"] == null){
      Chamber_Number.text= ' ';
   }else{
     Chamber_Number.text= nowresult1_1[0]["n_box"].toString();
   }

    if( nowresult1_1[0]["n_tow"] == null){
      Truck_Number.text= ' ';
   }else{
     Truck_Number.text= nowresult1_1[0]["n_tow"].toString();
   }
     if( nowresult1_1[0]["n_weight"] == null){
      Chamber_Weight.text= ' ';
   }else{
     Chamber_Weight.text= nowresult1_1[0]["n_weight"].toString();
   }
    if( nowresult1_1[0]["c_serial1"] == null){
      Car_ID1.text= ' ';
   }else{
     Car_ID1.text= nowresult1_1[0]["c_serial1"].toString();
   }

    if( nowresult1_1[0]["c_serial_tow"] == null){
      Car_ID2.text= ' ';
   }else{
     Car_ID2.text= nowresult1_1[0]["c_serial_tow"].toString();
   }

   
     
   if( nowresult1_1[0]["n_uniform"] == null){
      Target_Uniform.text= ' ';
   }else{
     Target_Uniform.text= nowresult1_1[0]["n_uniform"].toString();
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

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getjaon1_setting_farm();
    // _createSampleData();
  }

  @override
  Widget build(BuildContext context) {
    
    // //print(widget.default_species);
    // //print(widget.default_species![0]["name"]);
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
          //   appBar: AppBar(
          // title: Text('Farm Name',style: TextStyle(
          //                 fontSize: 17,
          //                 fontFamily: 'Montserrat',
          //                 fontWeight: FontWeight.bold,
          //                   color: Color.fromARGB(255, 0, 0, 0)),),
          
          // backgroundColor: Color.fromARGB(255, 255, 255, 255)),
          body:  SingleChildScrollView(
         physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:loading1
            ? Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator()))
            : Column(
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
                        Text('Farm Name',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            color: Color.fromARGB(255, 25, 25, 25),
                                            ),)   ,       
                        ],
                      ),
                      Text(
                          '${nowresult1_1[0]['c_name']??''}',
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'THSarabun',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),      
                    ],
                  ),
                  Species1(),
                  Name_BTG2(),
                  Farm_SerialSEE3(),
                  Central_Default4(),
                  Farm_Address5(),
                  Supervisor_Truck6(),
                  Email7(),
                  Line_Token8(),
                  Chamber_Truck_Num9(),
                  Chamber_Weight10(),
                  Ship_Condition11(),
                   Car_ID1_2_12(),
                  Target_Uniform13(),
          
          
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
                              var name = nowresult1_1[0]["c_name"];
                            //    print('=======1=========');
                            //  print(widget.Token);
                            //  print(widget.farmnum);
                            //  print(nowresult1_1[0]["c_name"]);
                            //  print(Speciesnum);
                            
                            //  print('=======2=========');
                            //  print(Name.text);
                            //  print(BTG_Plant.text);
                            //  print(Farm_ID.text);
                            //  print(Serial_SmartEE.text);

                              
                            //    print('=======3=========');
                            //  print(int.parse(Central_ID.text));
                            //  print(int.parse(Default_Density.text));
                            //  print(Farm_Address.text);
                            //  print(Supervisor.text);

                            //     print('=======4=========');
                            //  print(Phone.text);
                            //  print(E_mail.text);
                            //  print( Line_Token.text);
                            //  print(int.parse(Chamber_Number.text));
                            //  print(int.parse(Truck_Number.text));
                            //  print(double.parse(Chamber_Weight.text));

                            //    print('=======5=========');
                            //  print(Ship_Conditionnum);
                            //  print(Car_ID1.text);
                            //  print( Car_ID2.text);
                            //  print(double.parse(Target_Uniform.text));
                            //  double Uniform  =  double.parse(Target_Uniform.text).toStringAsFixed(0) ;
                            double Chamber = double.parse(Chamber_Weight.text);
                            String Weight = Chamber.toStringAsFixed(0);
                            int C_W = int.parse(Weight);

                            double Uniform = double.parse(Target_Uniform.text);
                            String Target = Uniform.toStringAsFixed(0);
                            int T_U = int.parse(Target);
                            

                            API_edit_setting_farm(widget.Token,widget.farmnum,name,Speciesnum,
                            Name.text,BTG_Plant.text,Farm_ID.text,Serial_SmartEE.text,
                            int.parse(Central_ID.text),int.parse(Default_Density.text),Farm_Address.text,Supervisor.text,
                            Phone.text,E_mail.text,Line_Token.text,int.parse(Chamber_Number.text),int.parse(Truck_Number.text),C_W,
                            Ship_Conditionnum,Car_ID1.text,Car_ID2.text,T_U);
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

  Container Target_Uniform13() {
    return Container(
        margin: EdgeInsets.only(top: 20,right: 10,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            width: screenW*0.4,
            child:  Column(children: [
            Container(
               width: screenW*0.4,
                margin: EdgeInsets.only(left: 5),
              child: Text('Target %Uniform',
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
width: screenW*0.4,
child: TextField(
 controller: Target_Uniform,
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

  Container Car_ID1_2_12() {
    return Container(
        margin: EdgeInsets.only(top: 20,right: 10,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            width: screenW*0.4,
            child:  Column(children: [
            Container(
               width: screenW*0.4,
                margin: EdgeInsets.only(left: 5),
              child: Text('Car ID 1',
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
width: screenW*0.4,
child: TextField(
 controller: Car_ID1,
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
            width: screenW*0.4,
            child: Column(children: [
              Container(
               width: screenW*0.4,
               margin: EdgeInsets.only(left: 5),
              child: Text('Car ID 1',
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
width: screenW*0.4,
child: TextField(
controller: Car_ID2,
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

  Container Ship_Condition11() {
    return Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(children: [
              Container(
              width: screenW*0.95,
              child: Text('Ship Condition',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                    ),),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
      borderRadius: BorderRadius.circular(25),
      color: Colors.white,
    ),
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
                          value: Ship_Conditionname,
                          items:  Ship_Condition!
                              .map((Ship_Condition) => DropdownMenuItem<String>(
                                  value: Ship_Condition["name"],
                                  child: Text(
                                    Ship_Condition["name"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    fontFamily: 'THSarabun',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                    ),
                                  )))
                              .toList(),
                          onChanged: (Ship_Condition) {
                           setState(() {
                                
                                      Ship_Conditionname = Ship_Condition!;
                                       for(int i = 0;i<widget.default_ship!.length;i++){
                                    if(widget.default_ship![i]['name'] == Ship_Condition){
                                      Ship_Conditionnum = widget.default_ship![i]['code'];
                                    }}
                                    });
                          }),
                                  ),
                      ),
                    ),
  )
            ]),
          );
  }

  Container Chamber_Weight10() {
    return Container(
          margin: EdgeInsets.only(top: 20,right: 10,left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: screenW*0.4,
              child:  Column(children: [
              Container(
                 width: screenW*0.4,
                  margin: EdgeInsets.only(left: 5),
                child: Text('Chamber Weight (kg.)',
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
width: screenW*0.4,
child: TextField(
 controller: Chamber_Weight,
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

  Container Chamber_Truck_Num9() {
    return Container(
          margin: EdgeInsets.only(top: 20,right: 10,left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: screenW*0.4,
              child:  Column(children: [
              Container(
                 width: screenW*0.4,
                  margin: EdgeInsets.only(left: 5),
                child: Text('Chamber Number',
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
width: screenW*0.4,
child: TextField(
 controller: Chamber_Number,
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
              width: screenW*0.4,
              child: Column(children: [
                Container(
                 width: screenW*0.4,
                 margin: EdgeInsets.only(left: 5),
                child: Text('Truck Number',
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
width: screenW*0.4,
child: TextField(
 controller: Truck_Number,
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

  Container Line_Token8() {
    return Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(children: [
                Container(
                width: screenW*0.95,
                child: Text('Line Token',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      height: 40,
      width: screenW*0.95,
      child: TextField(
         controller: Line_Token,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          // filled: true,
          contentPadding: EdgeInsets.only(top: 10,left: 10),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color(0xff7d7d7d)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xffcfcfcf)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xffcfcfcf)),
          ),
        ),
      ),
    )
              ]),
            );
  }

  Container Email7() {
    return Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(children: [
                  Container(
                  width: screenW*0.95,
                  child: Text('E-mail',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: Color.fromARGB(255, 25, 25, 25),
                                        ),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        height: 40,
        width: screenW*0.95,
        child: TextField(
           controller: E_mail,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          decoration: InputDecoration(
            // filled: true,
            contentPadding: EdgeInsets.only(top: 10,left: 10),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Color(0xff7d7d7d)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0xffcfcfcf)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0xffcfcfcf)),
            ),
          ),
        ),
      )
                ]),
              );
  }

  Container Supervisor_Truck6() {
    return Container(
            margin: EdgeInsets.only(top: 20,right: 10,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                width: screenW*0.4,
                child:  Column(children: [
                Container(
                   width: screenW*0.4,
                    margin: EdgeInsets.only(left: 5),
                  child: Text('Supervisor',
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
width: screenW*0.4,
child: TextField(
  controller: Supervisor,
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
                width: screenW*0.4,
                child: Column(children: [
                  Container(
                   width: screenW*0.4,
                   margin: EdgeInsets.only(left: 5),
                  child: Text('Phone',
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
width: screenW*0.4,
child: TextField(
   controller: Phone,
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

  Container Farm_Address5() {
    return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(children: [
                    Container(
                    width: screenW*0.95,
                    child: Text('Farm Address',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          color: Color.fromARGB(255, 25, 25, 25),
                                          ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffcfcfcf), width: 1.5),
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          height: 80,
          width: screenW*0.95,
          child: TextField(
            maxLines: 4,
             controller: Farm_Address,
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            decoration: InputDecoration(
              // filled: true,
              contentPadding: EdgeInsets.only(top: 10,left: 10),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Color(0xff7d7d7d)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Color(0xffcfcfcf)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Color(0xffcfcfcf)),
              ),
            ),
          ),
        )
                  ]),
                );
  }

  Container Central_Default4() {
    return Container(
              margin: EdgeInsets.only(top: 20,right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: screenW*0.4,
                  child:  Column(children: [
                  Container(
                     width: screenW*0.4,
                      margin: EdgeInsets.only(left: 5),
                    child: Text('Central ID',
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
    color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
  ),
  height: 40,
  width: screenW*0.4,
  child: TextField(
    readOnly:true,
     controller: Central_ID,
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
                ),
                Container(
                  width: screenW*0.4,
                  child: Column(children: [
                    Container(
                     width: screenW*0.4,
                     margin: EdgeInsets.only(left: 5),
                    child: Text('Default Density',
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
  width: screenW*0.4,
  child: TextField(
     controller: Default_Density,
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

  Container Farm_SerialSEE3() {
    return Container(
              margin: EdgeInsets.only(top: 20,right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: screenW*0.4,
                  child:  Column(children: [
                  Container(
                     width: screenW*0.4,
                      margin: EdgeInsets.only(left: 5),
                    child: Text('Farm ID',
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
  width: screenW*0.4,
  child: TextField(
     controller: Farm_ID,
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
                  width: screenW*0.4,
                  child: Column(children: [
                    Container(
                     width: screenW*0.4,
                     margin: EdgeInsets.only(left: 5),
                    child: Text('Serial SmartEE',
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
    color: Color.fromARGB(0, 209, 240, 251).withOpacity(0.3),
  ),
  height: 40,
  width: screenW*0.4,
  child: TextField(
     readOnly:true,
     controller: Serial_SmartEE,
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

  Container Name_BTG2() {
    return Container(
                margin: EdgeInsets.only(top: 20,right: 10,left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Container(
                    width: screenW*0.4,
                    child:  Column(children: [
                    Container(
                       width: screenW*0.4,
                        margin: EdgeInsets.only(left: 5),
                      child: Text('Name (ea)',
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
    width: screenW*0.4,
    child: TextField(
       controller: Name,
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
                    width: screenW*0.4,
                    child: Column(children: [
                      Container(
                       width: screenW*0.4,
                       margin: EdgeInsets.only(left: 5),
                      child: Text('BTG Plant',
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
    width: screenW*0.4,
    child: TextField(
       controller: BTG_Plant,
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

  Container Species1() {
    return Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(children: [
                  Container(
                    width: screenW*0.95,
                    child: Text('Species',
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
                          value: Speciesname,
                          items:  Species!
                              .map((Species) => DropdownMenuItem<String>(
                                  value: Species["name"],
                                  child: Text(
                                    Species["name"],
                                    style: TextStyle(
                                      fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(255, 25, 25, 25),
                                    ),
                                  )))
                              .toList(),
                          onChanged: (Species) {
                           setState(() {
                                
                                      Speciesname = Species!;
                                        for(int i = 0; i< widget.default_species!.length;i++){
                     if(Species== widget.default_species![i]["name"]){
                  setState(() {
                    // Speciesnum = widget.default_species![i]["id"];
                  });
           }}
                                    
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