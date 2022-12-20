import 'package:flutter/material.dart';

import 'Setting/Farm.dart';
import 'Setting/Feed.dart';
import 'Setting/House.dart';
import 'Setting/Planning.dart';
import 'Setting/Production.dart';
import 'Setting/standard.dart';




class Setting extends StatefulWidget {
    String? Token;
      String? farmname;
  GlobalKey? navigatorKey;
    int? farmnum;
    List<dynamic>? default_species;
    List<dynamic>? house;
    List<dynamic>? default_planning;
    List<dynamic>? default_formula;
    List<dynamic>? default_ship;
   Setting({ Key? key ,this.Token,this.navigatorKey,this.farmnum,this.default_species,this.default_formula,this.default_planning,this.house,this.default_ship,this.farmname}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

    late  List <dynamic>? default_species = widget.default_species;
    late  List <dynamic>? default_ship = widget.default_ship;
    late  List <dynamic>? house = widget.house;
    late  List <dynamic>? default_planning = widget.default_planning;
    late  List <dynamic>? default_formula = widget.default_formula;
     late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
       //print('widget.default_species===${widget.default_planning}');
        screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Navigator(
      // key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          // settings: settings,
          builder: (BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
         physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              // side: BorderSide(color: Colors.red)
                            ),
                  child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                     
                    child: Column(children: [
                      Container(
                        width: screenW*0.9,
                        height: 40,
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
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                    '${widget.farmname}',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'THSarabun',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                                      ),
                      ),
                       Container(
                         height: 90,
                         width: screenW*0.9,
                         child: Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Text(
                    '(บ.บีเอฟไอบรอยเลอร์ฟาร์ม จำกัด) ที่อยู่ ซอย 14 ตำบล ช่องสาริกา อำเภอ พัฒนานิคม จังหวัด ลพบุรี 15220',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'THSarabun',
                      
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                         ),
                        //  color: Colors.blue,
                       ),
                    ]),
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                Column(
                  children: [
                    newMethod('Farm','Farm Name',(() {
                      Navigator.push(context, MaterialPageRoute(
                builder: (context) =>  Farm(farmnum: widget.farmnum,Token: widget.Token,default_species:default_species,default_ship:default_ship),
            ));

                    })),
                    newMethod('House','House',(() {
                         Navigator.push(
       context, MaterialPageRoute(
          builder: (context) => House(farmnum: widget.farmnum,Token: widget.Token,house:house),
        ),
      );
                    })),
                    newMethod('Feed','Feeds In Farm',(() {
                      Navigator.push(
       context, MaterialPageRoute(
          builder: (context) => Feed(farmnum: widget.farmnum,Token: widget.Token,),
        ),
      );
                    })),
                    newMethod('standard','standard Formula',(() {
                           Navigator.push(
       context, MaterialPageRoute(
          builder: (context) => standard(farmnum: widget.farmnum,Token: widget.Token,default_formula:default_formula),
        ),
      );
                    })),
                    newMethod('Planning','Farming Plan',(() {
                        Navigator.push(
       context, MaterialPageRoute(
          builder: (context) => Planning(farmnum: widget.farmnum,Token: widget.Token,default_planning:default_planning),
        ),
      );
                    })),
                    newMethod('Production','Production Set',(() {
                      
                        Navigator.push(
       context, MaterialPageRoute(
          builder: (context) => Production(farmnum: widget.farmnum,Token: widget.Token,default_formula:default_formula,default_planning:default_planning),
        ),
      );
                    })),
                  ],
                ),
                ],
              ),
            ),
          ]),
            ),
      ),
      
    );  
    },
        );
      },
    );
  }


  Container newMethod(String name,data,Function()? onTap1) {
    return Container(
                    child: GestureDetector(
                  onTap: onTap1,
            //       () {
                    
            //          f;
                            
            // //       Navigator.push(context, MaterialPageRoute(
            // //     builder: (context) =>  Farm(),fullscreenDialog: true
            // // ));
            //         //  Navigator.pushReplacement(
            //         //                 context,
            //         //                 MaterialPageRoute(
            //         //                   builder: (context) =>
            //         //                       Farm(),
            //         //                 ));
            //       },
                  child: Container(
                     width: screenW*1,
                    height: 40,
                    decoration: BoxDecoration(
      border: Border.all(color: Color(0xffcfcfcf), width: 1),
      // borderRadius: BorderRadius.circular(30),
      color: Colors.white,
    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(
                            name,
                            style: new TextStyle(
                              color: Color.fromARGB(255, 51, 51, 51),
                              fontSize: 15,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  )),
                  );
  }
}