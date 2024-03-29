import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Widget/LoginU.dart';
import 'Widget/login.dart';
import 'Widget/shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'router.dart';

//dcdf
String initialRoute = '/login';

void main() async {
  debugPrintGestureArenaDiagnostics = true;
  WidgetsFlutterBinding.ensureInitialized();
  late Usersharedpreferences _p = Usersharedpreferences();
  // Plugin must be initialized before using
  await _p.init();

  String? email = _p.getUserEmail();
  String? password = _p.getUserPassword();
  // List<String>? Formula10 =_p.getformula();
  // print(Formula10);
  late String? Token;
  late bool? loading = true;
  if (email == null && password == null || email == '' && password == '') {
    initialRoute = '/login';
  } else {
    initialRoute = '/login1';
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

//  late String? Token;
  @override
  Widget build(BuildContext context) {
    late Usersharedpreferences _p = Usersharedpreferences();
    String? email = _p.getUserEmail();
    String? password = _p.getUserPassword();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: initialRoute,
      // initialRoute : '/D',
    );
  }
}
