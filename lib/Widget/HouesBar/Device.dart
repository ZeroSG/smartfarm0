import 'package:flutter/material.dart';


class Device extends StatefulWidget {
    String? Token;
     int? num;
   Device({ Key? key,this.Token,this.num }) : super(key: key);

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}