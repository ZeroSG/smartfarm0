import 'package:flutter/material.dart';

import '../drawer.dart';
import 'HouesBar/Device.dart';
import 'HouesBar/Inrake&Order.dart';
import 'HouesBar/Weight.dart';

class House extends StatefulWidget {
       String? User;
  String? Password;
    String? Token;
    int? HOUSE1;
    String? HOUSE2;
    List<dynamic>? Feed;
    // หน้า House // Inrake&Order
  List<dynamic>? samount1;
    List<dynamic>? View;
     List<dynamic>? day;
  // หน้า House
  List<dynamic>? HOUSE;
  int? farmnum,cropnum2,cropnum1,cropnum;
   int? numIndex;
   House({ Key? key,this.Token,this.User,this.Password,this.HOUSE,this.HOUSE1,this.HOUSE2,this.cropnum2,this.farmnum,this.View,this.samount1,this.cropnum,this.day,this.numIndex,this.cropnum1,this.Feed}) : super(key: key);
   
  @override
  State<House> createState() => _HouseState();
}

class _HouseState extends State<House> {
 late  List<dynamic>?   feed = widget.Feed;
  late double screenW, screenH;
  late String? sHOUSE = widget.HOUSE2;
 late int? num = widget.HOUSE1;
 late int? numIndex = widget.numIndex;
 List<dynamic>? NoList =[''];
   String? Noname ='';
      late String? user = widget.User;
  late String? password=widget.Password;
  @override
  Widget build(BuildContext context) {
    //print(sHOUSE);
        screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
     if(numIndex==null){
      setState(() {
        numIndex = 0;
        // sHOUSE = widget.HOUSE![0]['name'];
      });
    }

    if(widget.HOUSE != null){

       if(feed==null){
      setState(() {
        feed = widget.HOUSE![0]['feed'];
      });
    }
      
   
          // print('2332$feed');
        if(num==null){
      setState(() {
        num = widget.HOUSE![0]['id'];
        
        // sHOUSE = widget.HOUSE![0]['name'];
      });
    }
    // setState(() {
    //   feed = widget.HOUSE![num!]['feed'];
    //   print(feed);
    // });
      if(sHOUSE==null){
      setState(() {
        sHOUSE = widget.HOUSE![0]['name'];
      });
    }
    
    }
      
        return 
        newDefaultTabController1(context);
  }

    Scaffold newDefaultTabController1(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          initialIndex: numIndex!,
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
              SliverAppBar(
                automaticallyImplyLeading : false,
                toolbarHeight : 95,
                backgroundColor: Colors.white,
                // expandedHeight: 80,
                title: Column(children: [
                   Container(
                     margin: EdgeInsets.only(top: 10),
                     child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                            Text(' '),
                Container(
                width: screenW*0.5,
                height: 32,
                margin: EdgeInsets.only(right: 10,top: 10,bottom: 5),
                child: Container(
                      height: 30,
                      width: screenW*0.3,
                      child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Color(0xfff1f1f1),
                                border: Border.all(color: Color(0xffe0eaeb), width: 3),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                                ]),
                        child: Padding(
                           padding: EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButtonHideUnderline(
                                      child: 
                                      widget.HOUSE == null 
                                      ? DropdownButton<String>(
                                         icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                            value: Noname,
                            items:  NoList!
                                .map((NoHOUSE) => DropdownMenuItem<String>(
                                    value: NoHOUSE,
                                    child: Text(
                                      NoHOUSE,
                                      style: TextStyle(
                                        fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      overflow: TextOverflow.ellipsis,
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (NoHOUSE) {
                              
                            })
                                      :
                                      DropdownButton<String>(
                                         icon: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 20,
                            ),
                            value: sHOUSE,
                            items:  widget.HOUSE!
                                .map((HOUSE) => DropdownMenuItem<String>(
                                    value: HOUSE['name'],
                                    child: Text(
                                      HOUSE['name'],
                                      style: TextStyle(
                                        fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      overflow: TextOverflow.ellipsis,
                                      color: Color.fromARGB(255, 25, 25, 25),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (HOUSE) {
                              for(int i = 0;i<widget.HOUSE!.length;i++){
                                    if(widget.HOUSE![i]['name'] == HOUSE){
                                     setState(() {
                                      //  //print(sHOUSE);
                                      num = widget.HOUSE![i]['id'];
                                      feed = widget.HOUSE![i]['feed'];
                                      sHOUSE = HOUSE!; 
                                     
                                      // //print('sHOUSE $sHOUSE');
                                      // //print('widget.cropnum1 ${widget.cropnum1}');
                                      // //print('widget.cropnum2 ${widget.cropnum2}');
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=>   Drawer1(Token: widget.Token, num1: 2,numIndex:numIndex,User: user,Password: password,HOUSE1:num,HOUSE2: sHOUSE,cropnum1: widget.cropnum1,cropnum:widget.cropnum,cropnum2:widget.cropnum2,farmnum:widget.farmnum,Feed: feed,),), (route) => false);
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //        Drawer1(Token: widget.Token, num1: 2,numIndex:numIndex,User: user,Password: password,HOUSE1:num,HOUSE2: sHOUSE,cropnum1: widget.cropnum1,cropnum:widget.cropnum,cropnum2:widget.cropnum2,farmnum:widget.farmnum,Feed: feed,),
                                      //   ));
                                     
                                    } 
                                  );
                                  // //print(num);
                                    }
                                  
                                 }
                            }),
                                    ),
                        ),
                      ),
                  )
              ),
  
                     ],
                 ),
                   ),

                 Container(
               width: screenW*0.9,
               height: 45,
               decoration: BoxDecoration(
                 color: Color.fromARGB(255, 198, 198, 198),
                 borderRadius: BorderRadius.circular(25.0)
               ),
               child:  TabBar(
                 
                 onTap :(value) {
                   setState(() {
                     numIndex = value;
                   });
                 },
                 indicator: BoxDecoration(
                   color: Color(0xff44bca3),
                   borderRadius: BorderRadius.circular(25.0)
                 ),
                 labelColor: Colors.white,  
                 unselectedLabelColor: Color.fromARGB(255, 74, 74, 74),
                 tabs:  [
                     Tab(text: 'Inrake&Order',),
                     Tab(text: 'Device',),
                     Tab(text: 'Weight',),
                 ],
                 
               ),
             ),
            Container(
                 margin: EdgeInsets.only(top: 5),
              width: screenW * 1,
              height: screenH * 0.001,
              color: Color.fromARGB(255, 112, 112, 112)),
                ]),
              )
              
              ];
              
            },  body: 
             
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                      child: TabBarView(
                        
                        physics: NeverScrollableScrollPhysics(),
                 children:<Widget> [
                   Inrake_Order(Token: widget.Token,User: user,Password: password,num:num,farmnum: widget.farmnum,cropnum: widget.cropnum,cropnum1: widget.cropnum1,cropnum2: widget.cropnum2,samount1:widget.samount1,View:widget.View,day: widget.day,HOUSEname:sHOUSE,Feed: feed,),
                   Device(Token: widget.Token),
                   Weight(Token: widget.Token,num:num,farmnum: widget.farmnum,HOUSE2:sHOUSE),
                 ],
              )),
                    ),
          ),     
        ),
      );
  }
}

