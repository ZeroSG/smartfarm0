import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'notifications.dart';




  //button house estimate
   Future<void> API_button_house_estimate(String? Token,var Farm) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/button/house-estimate");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": Farm,
          }));
      if (ressum.statusCode == 200) {
        initInfo();

        showNot('house estimate','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
        initInfo();
        
        showNot('house estimate','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }


    //button order send
   Future<void> API_button_order_send(String? Token,var Farm, var user) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/button/order-send");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
              "farm": Farm,
              "user": user
          }));
      if (ressum.statusCode == 200) {
         showNot('order send','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
         showNot('order send','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }


  //button setting feed
   Future<void> API_button_setting_feed(String? Token,var Farm, var feed) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/button/setting-feed");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
              "farm": Farm,
               "feed": feed
          }));
      if (ressum.statusCode == 200) {
        showNot('setting feed','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
        showNot('setting feed','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

//button delete standard
Future<void> API_button_delete_standard(String? Token,var Farm, var standard) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/button/delete-standard");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
              "farm": Farm,
               "standard": standard
          }));
      if (ressum.statusCode == 200) {
        showNot('delete standard','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
        showNot('delete standard','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

  //button delete planning
Future<void> API_button_delete_planning(String? Token,var Farm, var plan) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/button/delete-planning");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
              "farm": Farm,
                 "plan": plan
          }));
      if (ressum.statusCode == 200) {
         showNot('delete planning','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
         showNot('delete planning','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }


    //button production start
Future<void> API_button_production_start(String? Token,var Farm, var truck_allow) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/button/production-start");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
              "farm": Farm,
                 "truck_allow": truck_allow
          }));
      if (ressum.statusCode == 200) {
         showNot('production start','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
          showNot('production start','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

      //button production stop
Future<void> API_button_production_stop(String? Token,var Farm) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/button/production-stop");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
              "farm": Farm,

          }));
      if (ressum.statusCode == 200) {
          showNot('production stop','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
         showNot('production stop','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }