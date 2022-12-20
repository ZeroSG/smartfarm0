
import 'package:flutter/material.dart';

// import 'Widget/D.dart';
import 'Widget/LoginU.dart';
import 'Widget/Main.dart';
import 'Widget/Setting/Farm.dart';
import 'Widget/Setting/Feed.dart';
import 'Widget/Setting/House.dart';
import 'Widget/Setting/Planning.dart';
import 'Widget/Setting/Production.dart';
import 'Widget/Setting/standard.dart';
import 'Widget/Summry.dart';
import 'Widget/login.dart';




final Map<String, WidgetBuilder> routes = {
  '/summary': (BuildContext context) => Summary(),
  '/login': (BuildContext context) => Login(),
  '/login1': (BuildContext context) => SignUp(),
   '/main': (BuildContext context) => Main1(),
   '/drawer': (BuildContext context) => Drawer(),
    //  '/D': (BuildContext context) => D(),


   '/Farm': (BuildContext context) => Farm(),
   '/Feed': (BuildContext context) => Feed(),
   '/House': (BuildContext context) => House(),
   '/Planning': (BuildContext context) => Planning(),
   '/Production': (BuildContext context) => Production(),
   '/standard': (BuildContext context) => standard(),
};