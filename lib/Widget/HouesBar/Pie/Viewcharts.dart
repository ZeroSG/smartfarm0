import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Viewcharts extends StatefulWidget {
  List<dynamic>? nowresult6_1;
   Viewcharts({ Key? key ,this.nowresult6_1}) : super(key: key);

  @override
  State<Viewcharts> createState() => _ViewchartsState();
}

class _ViewchartsState extends State<Viewcharts> {
  late double screenW, screenH;
    bool loading6 = true;
  bool isSquare = false;
  Color textC = Color(0xff505050);
  int? touchedIndex;

 List<dynamic>?   _nowresult6_1;

 List<Map<String, dynamic>> color = [];
 
         List<Color>? color1 = [Color.fromARGB(255, 0, 132, 240),Color.fromARGB(255, 241, 145, 0),Color.fromARGB(255, 0, 0, 0),Color.fromARGB(255, 0, 246, 8),Color.fromARGB(255, 255, 17, 0),Color.fromARGB(255, 25, 0, 255),Color.fromARGB(255, 255, 0, 242)];
         List<Color>? color2 = [Color.fromARGB(255, 128, 189, 238),Color.fromARGB(255, 252, 192, 104),Color.fromARGB(255, 133, 133, 133),Color.fromARGB(255, 132, 171, 133),Color.fromARGB(255, 244, 103, 93),Color.fromARGB(255, 93, 79, 225),Color.fromARGB(255, 220, 79, 194)];
 double sum = 0;
  @override
  Widget build(BuildContext context) {
    if(widget.nowresult6_1 == null){
      setState(() {
        loading6 = true;
      });
    }
    else{

      color = [
        for(int i =0 ; i< widget.nowresult6_1!.length;i++)
         { 'c_size': widget.nowresult6_1![i]['c_size'],'color': color1![i], 'color1':color2![i],},
       ];
     
     //print(color1);
       List<dynamic>   nowresult6_ = widget.nowresult6_1!.map((e) => {
    for (int i = 0; i < widget.nowresult6_1![0].keys.length; i++)
    '${widget.nowresult6_1![0].keys.elementAt(i)}' : e['${widget.nowresult6_1![0].keys.elementAt(i)}'],
    'color' : color.where((element) => element['c_size'].toString().compareTo(e['c_size'].toString()) == 0).first['color']?? null,
    'color1' : color.where((element) => element['c_size'].toString().compareTo(e['c_size'].toString()) == 0).first['color1']?? null,
    
           }).toList();

           
 
           setState(() {
             _nowresult6_1 =nowresult6_;
           });
       setState(() {
        loading6 = false;
      });
    }

    // for(int i =0 ; i< widget.nowresult6_1!.length;i++){
    //     List<dynamic>   nowresult6_ = widget.nowresult6_1!.map((e) => {
    // for (int i = 0; i < widget.nowresult6_1![0].keys.length; i++)
    // '${widget.nowresult6_1![0].keys.elementAt(i)}' : e['${widget.nowresult6_1![0].keys.elementAt(i)}'],
    // 'color' : color3![i],
    // 'color1' : color1![i],
    
    //        }).toList();
    // }
        screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
  
    for (var i = 0; i < _nowresult6_1!.length; i++) {
    sum += double.parse('${_nowresult6_1![i]['n_percent'].split(' %').first}');
  }

  //print("Sum : ${sum}");
     
    return Scaffold(
      backgroundColor: Colors.white,
      body: sum == 0
              ? Container(
                  height: screenH * 0.30,
                  child: Center(
                      child: Text(
                    'No data to display.',
                    style: TextStyle(fontSize: 18),
                  )))
                  :  Column(children: [
          Container(
            width: screenW*1,
            height: 300,
          child:loading6?Container(
                  margin: EdgeInsets.only(top: 10),
                  height: screenH * 0.30,
                  child: Center(child: CircularProgressIndicator()))
                    :  PieChart(
            PieChartData(
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 0,
                sections: showingSections()
                ),
          ),
       
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _nowresult6_1!
            .map((data) =>   
            Container(
              // padding: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                   SizedBox(width: 8,),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                      // color: data.color,
                      gradient: LinearGradient(
   begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      // stops: [0.3, 1],
      colors: [data['color'],data['color1']])
                      ),
                  ),
                  SizedBox(width: 8,),
                  Text('${data['c_size']}',
                  style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.bold,
                   color: textC
                  ),),
                ],
              ),
            )
            )
            .toList(),
        
          ),
      ]),
    );
  }

  
 List<PieChartSectionData> showingSections()=>
       _nowresult6_1!.asMap().map<int,PieChartSectionData>((index, data) {      
         final isTouched = index == touchedIndex;
         final fontSize = isTouched ? 16.0 : 12.0;
         final radius = isTouched ? 150.0 : 120.0;
         final date = isTouched ? '${data['n_percent']}' : '${data['n_percent']}';
         var value = PieChartSectionData(
           color: data['color'],
           value: double.parse('${data!['n_percent'].split(' %').first}'),
           title: date,
           radius: radius,
            badgePositionPercentageOffset: .98,
           titleStyle: TextStyle(
             fontSize: fontSize,
             fontWeight: FontWeight.bold,
             color: Color(0xffffffff),
           ),
         );
         return MapEntry(index, value);
       }).values.toList();
}
