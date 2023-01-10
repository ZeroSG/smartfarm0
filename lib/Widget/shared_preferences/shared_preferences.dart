

import 'package:shared_preferences/shared_preferences.dart';


// class Usersharedpreferences{
//   Future createCache(String email) async{
//      SharedPreferences _preferences = await SharedPreferences.getInstance();
//      _preferences.setString('email', email);
//   }
//   Future readCache(String email) async{
//      SharedPreferences _preferences = await SharedPreferences.getInstance();
//      _preferences.getString('email');
//   }
//     Future removeCache(String email) async{
//      SharedPreferences _preferences = await SharedPreferences.getInstance();
//      _preferences.remove('email');
//   }
// }
class Usersharedpreferences {
  static  SharedPreferences? _preferences;
    static  SharedPreferences? _preferences1;




 Future<void> init() async{
     _preferences = await SharedPreferences.getInstance();
          _preferences1 = await SharedPreferences.getInstance();
    
  }

   Future<void> setUserEmail(String Email,String Password) async{
     await _preferences!.setString('Email', Email);
     await _preferences!.setString('Password', Password);
       print(Email);
        print(Password);
  }

    Future setListdefault_planning(List<String>? Planning) async{
     await _preferences!.setStringList('Planning', Planning!);

       print('List $Planning');

  }

  
      Future setListdefault_formula(List<String>? Formula) async{
     await _preferences!.setStringList('Formula',  Formula!);

      print('List $Formula');

  }


      Future setListNameCrop(List<String>? NameCrop) async{
     await _preferences!.setStringList('NameCrop', NameCrop!);

       print('List $NameCrop');

  }
  //  static Future setUserPassword(String Password) async{

  //      await _preferences1!.setString(_keyPassword, Password);

  // }
  // static Future setUserToken(String Token) async{
  //    await _preferences!.setString(_keyToken, Token);
  // }
   List<String>? getformula() => _preferences!.getStringList('Formula');
   List<String>? getplanning() => _preferences!.getStringList('Planning');
   List<String>? getListNameCrop() => _preferences!.getStringList('NameCrop');
   String? getUserEmail() => _preferences!.getString('Email');
   String? getUserPassword() => _preferences!.getString('Password');
  // static String? getUserToken() => _preferences!.getString(_keyToken);
  
}