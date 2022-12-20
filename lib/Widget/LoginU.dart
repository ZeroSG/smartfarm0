import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../drawer.dart';
import 'shared_preferences/shared_preferences.dart';


class SignUp extends StatefulWidget {
  String? email;
   String? password;
   SignUp({ Key? key,this.email ,this.password}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
 late Usersharedpreferences _p = Usersharedpreferences();


bool loading = true;
 Future<void> getToken(context,String Username,String Password) async{
   loading = true;
  var url = Uri.https("smartfarmpro.com", "/v1/api/security/token");
  var res = await http.post(
    url,
    headers: <String,String>{
      "Content-Type" : "application/x-www-form-urlencoded"
    },
    body: {
      "Grant_Type": 'password', "Username": Username, "Password": Password
    }
  );
  if(res.statusCode == 200){
    print("token => ${res.body}");
    var token = jsonDecode(res.body);
   var Token1 = token['access_token'];
      loading = false;
    if(loading == false)  {
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=> Drawer1(Token: Token1,User: Username,Password:Password,),), (route) => false);

                              
    }
    else{
      // normalDialog(context, 'ข้อมูล','อีเมลกับรหัสผ่านไม่ถูกต้อง');
    }
  
    //  getjaon1(token['access_token']);
  }
  else{

  }
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     String? email = _p.getUserEmail();
  String? password = _p.getUserPassword();
     getToken(context,email!, password!);

  }

    double? screenW, screenH;
  @override
  Widget build(BuildContext context) {
     screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
     body: loading? Container(
                width: screenW! * 1,
                height: screenW! * 1,
                child: Center(child: CircularProgressIndicator()))
     :Container(),
    );
    
  }
}