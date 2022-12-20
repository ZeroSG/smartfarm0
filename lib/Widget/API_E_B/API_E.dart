import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../drawer.dart';
import '../shared_preferences/shared_preferences.dart';
import 'notifications.dart';



  //edit house silo
   Future<void> API_edit_house_silo(String? Token,var Farm,var House,var Silo,var Feed) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/house-silo");

      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            "Farm": Farm,
           "House": House,
           "Silo": Silo,
           "Feed": Feed
          }));
      if (ressum.statusCode == 200) {
         showNot('edit house silo','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
         showNot('edit house silo','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }


   //edit house usage
   Future<void> API_edit_house_usage(String? Token,var Farm,var House,var production,var date,var bag,var death,var reject,var addon,var weight,var usage_1,var usage_2,var remain_1,var remain_2,var refill_1,var refill_2,var using_refill) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/house-usage");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "farm": Farm,
  "house": House,
  "production": production,
  "date": date,
  "bag": bag,
  "death": death,
  "reject": reject,
  "addon": addon,
  "weight": weight,
  "usage_1": usage_1,
  "usage_2": usage_2,
  "remain_1": remain_1,
  "remain_2": remain_2,
  "refill_1": refill_1,
  "refill_2": refill_2,
  "using_refill": using_refill,
  // 0
  "egg_fg": 0,
  "egg_ng": 0,
  "egg_avg_weight": 0,
  "egg_fg_weight": 0,
  "egg_ng_weight": 0
}));
      if (ressum.statusCode == 200) {
         showNot('edit house usage','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
        showNot('edit house usage','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

    //edit weight setting
   Future<void> API_edit_weight_setting(String? Token,var Farm,var House,var poultry_weight,var period_start,var period_end,var size_s_before,var size_m_before,var size_m_after,var size_l_after,var percent_yield,var percent_loss) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/weight-setting");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "farm": Farm,
  "house": House,
  "poultry_weight": poultry_weight,
  "period_start": period_start,
  "period_end": period_end,
  "size_s_before": size_s_before,
  "size_m_before": size_m_before,
  "size_m_after": size_m_after,
  "size_l_after": size_l_after,
  "percent_yield": percent_yield,
  "percent_loss": percent_loss
}));
      if (ressum.statusCode == 200) {
        showNot('edit weight setting','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
           showNot('edit weight setting','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

      //edit order-create
   Future<void> API_edit_order_create(String? Token,var Farm,var order_date,var filling_date,var namecrop,var ship,var feed,var number,var unit,var remark,var user) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/order-create");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
    "farm": Farm,
  "order_date": order_date,
  "filling_date ": filling_date,
  "namecrop ": namecrop,
  "ship": ship,
  "feed": feed,
  "number": number,
  "unit": unit,
  "remark": remark,
  "user": user
}));
      if (ressum.statusCode == 200) {
           showNot('edit order create','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
        showNot('edit order create','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

   //edit order-edit
   Future<void> API_edit_order_edit(String? Token,var Farm,var order_ref,var order_date,var filling_date,var namecrop,var ship,var feed,var number,var unit,var remark,var user,) async {
    
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/order-edit");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "farm": Farm,
  "order_ref": order_ref,
  "order_date": order_date,
  "filling_date ": filling_date,
  "namecrop ": namecrop,
  "ship": ship,
  "feed": feed,
  "number": number,
  "unit": unit,
  "remark": remark,
  "user": user
}));
      if (ressum.statusCode == 200) {
        showNot('edit order edit','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
        showNot('edit order edit','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

   //edit setting farm
   Future<void> API_edit_setting_farm(String? Token,var Farm,var farm_name,var species,var ea_unit,var feedmill_plant,var farm_plant,var serial_id,var central_id,var density_default,var farm_address,var farm_supervisor,
   var farm_phone,var farm_email,var line_token,var truck_chamber,var truck_number,var chamber_weight,var ship,var truck_id_1,var truck_id_2,var percent_uniform) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/setting-farm");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "farm": Farm,
  "farm_name": farm_name,
  "species": species,
  "ea_unit":ea_unit,
  "feedmill_plant": feedmill_plant,
  "farm_plant": farm_plant,
  "serial_id": serial_id,
  "central_id": central_id,
  "density_default": density_default,
  "farm_address": farm_address,
  "farm_supervisor": farm_supervisor,
  "farm_phone": farm_phone,
  "farm_email": farm_email,
  "line_token": line_token,
  "truck_chamber": truck_chamber,
  "truck_number": truck_number,
  "chamber_weight": chamber_weight,
  "ship": ship,
  "truck_id_1": truck_id_1,
  "truck_id_2": truck_id_2,
  "percent_uniform": percent_uniform
}));
      if (ressum.statusCode == 200) {
        showNot('edit setting farm','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
        showNot('edit setting farm','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }


   //edit setting house_1
   Future<void> API_edit_setting_house_1(String? Token,var Farm,var house,var house_name,var process_order,var min_usage,var max_usage,var min_weight,var max_weight,var target_weight) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/setting-house");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
"farm": Farm,
  "house": house,
  "house_name": house_name,
  "process_order": process_order,
  "min_usage": min_usage,
  "max_usage": max_usage,
  "min_weight": min_weight,
  "max_weight": max_weight,
  "target_weight": target_weight
}));
      if (ressum.statusCode == 200) {
        print('successfully');
      } else {
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

     //edit setting silo_2
   Future<void> API_edit_setting_silo_2(String? Token,var Farm,var house,var silo,var silo_name,var capacity,var topup,var silo_verylow,var silo_low,var silo_upper) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/setting-silo");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "farm": Farm,
  "house": house,
  "silo": silo,
  "silo_name": silo_name,
  "capacity": capacity,
  "topup": topup,
  "silo_verylow": silo_verylow,
  "silo_low": silo_low,
  "silo_upper": silo_upper
}));
      if (ressum.statusCode == 200) {
        showNot('edit setting house silo','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
        showNot('edit setting house silo','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }

       //edit setting production
   Future<void> API_edit_setting_production(String? Token,var Farm,var house,var namecrop,var date_start,var date_end,var standard,var plan,var unit,var age) async {
    try {
      var urlsum = Uri.https("smartfarmpro.com", "/v1/api/edit/setting-production");
      var ressum = await http.post(urlsum,
          headers: {
            "Authorization": "Bearer $Token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
  "farm": Farm,
  "house": house,
  "namecrop":namecrop,
  "date_start": date_start,
  "date_end": date_end,
  "standard": standard,
  "plan": plan,
  "unit": unit,
  "age": age
}));
      if (ressum.statusCode == 200) {
        showNot('edit setting production','${jsonDecode(ressum.body)['message']}');
        print('successfully');
      } else {
          showNot('edit setting production','${jsonDecode(ressum.body)['message']}');
        throw Exception('Failed to download');
      }
    } catch (e) {

    }
  }