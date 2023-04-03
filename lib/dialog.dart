import 'package:flutter/material.dart';

Future<Null> normalDialog1(BuildContext context, String title,String message , var onPressed) async {
  showDialog(
     barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        // leading: Image.asset('images/maps.png',height: 600,),
        title: Text(title, textScaleFactor: 1.0,
        style: TextStyle(
          color: Colors.green,
        // fontFamily: fonts,
        )
          ),
        subtitle: Text(message,  textScaleFactor: 1.0,style: TextStyle(
        // fontFamily: fonts,
        )),

      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('ยกเลิก', textScaleFactor: 1.0,
          style: TextStyle(
            // fontFamily: fonts,
    
              fontSize: 15,
              color: Color.fromARGB(255, 0, 0, 0)),
        )),
               TextButton(onPressed: onPressed , child: Text('ตกลง', textScaleFactor: 1.0,
          style: TextStyle(
            // fontFamily: fonts,
      
              fontSize: 15,
              color: Color.fromARGB(255, 0, 0, 0)),
        )),
          ],
        )
      ],
    ),
  );
}