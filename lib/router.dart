import 'package:flutter/material.dart';

// import 'Widget/D.dart';
import 'Widget/LoginU.dart';
import 'Widget/Main.dart';

import 'Widget/login.dart';

//dcdf

final Map<String, WidgetBuilder> routes = {
  '/login': (BuildContext context) => Login(),
  '/login1': (BuildContext context) => SignUp(),
  '/main': (BuildContext context) => Main1(),
  '/drawer': (BuildContext context) => Drawer(),
  //  '/D': (BuildContext context) => D(),
};
