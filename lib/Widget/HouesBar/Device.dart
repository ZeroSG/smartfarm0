import 'package:flutter/material.dart';


class Climate extends StatefulWidget {
    String? Token;
     int? num;
   Climate({ Key? key,this.Token,this.num }) : super(key: key);

  @override
  State<Climate> createState() => _ClimateState();
}

class _ClimateState extends State<Climate> {
  bool loading1 = true;
  bool loading2 = false;
    late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
      screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      // body:  loading1 ? loading2 ?Container(
      //                 width: screenW,
      //                 height: screenH,
      //                 child: Center(child: CircularProgressIndicator())) 
      //                 :SingleChildScrollView(
      //   physics: BouncingScrollPhysics(),
      //                   child: Container(
      //                     child: Center(child: 
      //                     Column(children: [
      //                       Container(
      //                         margin: EdgeInsets.only(top: 30),
      //                         child: Text('Climate',   textScaleFactor: 1.0,
      //                         style: TextStyle(
      //                            color: Color.fromARGB(255, 0, 234, 255),
      //                            fontSize: 20
      //                          ),)),
      //                        Padding(
      //                          padding: const EdgeInsets.only(top: 10,right: 40,left: 40),
      //                          child: Text('ข้อมูลสภาวะแวดล้อมการเลี้ยง ที่ระบบอ่านจากอุปกรณ์ที่ติดตั้งภายในเล้า แบบเรียลไทม์อุปกรณ์ที่แนะนำมาแสดงบนเวปเพื่อตรวจสอบสภาพแวดล้อมการเลี้ยง เช่น วัดอุณหภูมิ, วัดความชื้น,วัดคาร์บอนไดอ๊อกไซด์, วัดความดันลม, วัดแอมโมเนีย, วัดแสงสว่าง, วัดความเร็วลม, วัดการใช้น้ำ เป็นต้น',
      //                             textScaleFactor: 1.0,style: TextStyle(
      //                            color: Colors.black,
      //                            fontSize: 16
      //                          ),),
      //                        ),
      //                        Padding(
      //                          padding: const EdgeInsets.all(8.0),
      //                          child: Image.asset('images/climate/info_climate.jpg',
      //                          ),
      //                        ),
      //                         Padding(
      //                          padding: const EdgeInsets.only(top: 10,right: 40,left: 40),
      //                          child: Text('ติดต่อสอบถามเพิ่มเติม เพื่อนำข้อมูลขึ้นแสดง 089-3600046',   textScaleFactor: 1.0,
      //                          style: TextStyle(
      //                            fontSize: 13,
      //                            color: Color.fromARGB(255, 144, 144, 144)
      //                          ),),
      //                        ),
      //                     ],)),
      //                   ),
      //                 )
      // : SingleChildScrollView(
      //   physics: BouncingScrollPhysics(),
      //   child: Container(
      //     child: Column(children: [
      //       Container(
      //         child: Row(
      //           children: [
      //             Container(
      //                         margin: EdgeInsets.only(top: 30),
      //                         child: Text('Monitoring Climate',   textScaleFactor: 1.0,
      //                         style: TextStyle(
      //                            color: Color.fromARGB(255, 0, 234, 255),
      //                            fontSize: 20
      //                          ),)),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(top: 20),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Climate('Lighting','10.0 Lux','images/climate/info_climate.jpg'),
      //            Climate('Ammonia','5.4 ppm','images/climate/info_climate.jpg'),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(top: 20),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //          Climate('Carbon Dioxide','0.0 ppm','images/climate/info_climate.jpg'),
      //            Climate('Total Water','163.352 m','images/climate/info_climate.jpg'),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(top: 20),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //         Climate('Water FlowRate','0.23 m/h','images/climate/info_climate.jpg'),
      //           Climate('Air Pressure','1001.6 mbar','images/climate/info_climate.jpg'),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(top: 20),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //           Climate('Air Pressure','0.0 mbar','images/climate/info_climate.jpg'),
      //           Climate1('Outside','31.7 C','68.5 %'),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(top: 20),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //            Climate1('Inside Average','31.7 C','68.5 %'),
      //             Climate1('Inside Zone 1','29.8 C','76.0 %'),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.only(top: 20),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //            Climate1('Inside Zone 2','30.7 C','72.4 %'),
      //             //  Climate1(),
      //           ],
      //         ),
      //       ),
      //     ]),
      //   ),
      // ),
    );
  }

  Card Climate(String? name,String? name1,String? Url) {
    return Card(
              elevation: 10,
              child: Container(
                height: 150,
                          width: screenW*0.45,
                  decoration: BoxDecoration(
                     border: Border.all(color: Color(0xff42d1cb), width: 3),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.3,

              ],
    colors: [
      Color(0xffddfdfa),Colors.white   
    ],),
          // RadialGradient(
          //   center: Alignment(0, -0.33),
          //   radius: 1.0,
          //   colors: <Color>[Colors.blue,Colors.white],
          // ),
        ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                            // margin: EdgeInsets.only(top: 30),
                            child: Text(name!,   textScaleFactor: 1.0,
                            style: TextStyle(
                              //  color: Color.fromARGB(255, 0, 234, 255),
                               fontSize: 16
                             ),)),
                             Container(
                               color: Colors.green[900],
                               height: 15,
                               width: 15,
                            // margin: EdgeInsets.only(top: 30),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8,left: 8),
      width: screenW * 1, height: 1, color: Color(0xff44bca3)),

      Container(
        margin: EdgeInsets.only(top: 10),
        child: Image.asset('$Url',
        width: 100,
        height: 60,
        fit: BoxFit.fill,
                             ),
      ),
       Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('$name1',   textScaleFactor: 1.0,
                            style: TextStyle(
                              //  color: Color.fromARGB(255, 0, 234, 255),
                               fontSize: 18
                             ),)),
                    ],
                  ),
              ),
            );
  }


   Card Climate1(String? name,String? name1,String? name2) {
    return Card(
              elevation: 10,
              child: Container(
                
                height: 150,
                          width: screenW*0.45,
                  decoration: BoxDecoration(
                     border: Border.all(color: Color(0xff42d1cb), width: 3),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.3,

              ],
    colors: [
      Color(0xffddfdfa),Colors.white   
    ],),
          // RadialGradient(
          //   center: Alignment(0, -0.33),
          //   radius: 1.0,
          //   colors: <Color>[Colors.blue,Colors.white],
          // ),
        ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                            // margin: EdgeInsets.only(top: 30),
                            child: Text(name!,   textScaleFactor: 1.0,
                            style: TextStyle(
                              //  color: Color.fromARGB(255, 0, 234, 255),
                               fontSize: 16
                             ),)),
                             Container(
                               color: Colors.green[900],
                               height: 15,
                               width: 15,
                            // margin: EdgeInsets.only(top: 30),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8,left: 8),
      width: screenW * 1, height: 1, color: Color(0xff44bca3)),

      Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10,left: 10),
            child: Image.asset('images/climate/info_climate.jpg',
            width: 60,
            height: 40,
            fit: BoxFit.fill,
                                 ),
          ),
           Container(
             margin: EdgeInsets.only(left: 20),
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                                      // margin: EdgeInsets.only(top: 10),
                                      child: Text(name1!,   textScaleFactor: 1.0,
                                      style: TextStyle(
                                        //  color: Color.fromARGB(255, 0, 234, 255),
                                         fontSize: 18
                                       ),)),
                                         Container(
                                  // margin: EdgeInsets.only(top: 10),
                                  child: Text('(Temperature)',   textScaleFactor: 1.0,
                                  style: TextStyle(
                                     color: Color.fromARGB(255, 155, 155, 155),
                                     fontSize: 14
                                   ),)),
               ],
             ),
           ),
        ],
      ),
       Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Container(
            margin: EdgeInsets.only(top: 10,left: 10),
            child: Image.asset('images/climate/info_climate.jpg',
            width: 60,
            height: 40,
            fit: BoxFit.fill,
                                 ),
          ),
           Container(
             margin: EdgeInsets.only(left: 20),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                                      // margin: EdgeInsets.only(top: 10),
                                      child: Text(name2!,   textScaleFactor: 1.0,
                                      style: TextStyle(
                                        //  color: Color.fromARGB(255, 0, 234, 255),
                                         fontSize: 18
                                       ),)),
                                         Container(
                                  // margin: EdgeInsets.only(top: 10),
                                  child: Text('(Hnmidiry)',   textScaleFactor: 1.0,
                                  style: TextStyle(
                                     color: Color.fromARGB(255, 155, 155, 155),
                                     fontSize: 14
                                   ),)),
               ],
             ),
           ),
         ],
       ),
                    ],
                  ),
              ),
            );
  }
}