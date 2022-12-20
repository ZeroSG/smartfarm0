import 'dart:ui';
import 'package:charts_flutter/flutter.dart' as charts;
class BarMmodel  {
 late var yearval;
 late var salesval;

  BarMmodel (this.yearval, this.salesval);
}

class Task {
 late var task;
 late double taskvalue;
 late Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class OrdinalSales {
  final String year;
  final double sales;

  final charts.Color color;

  OrdinalSales(this.year, this.sales, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}