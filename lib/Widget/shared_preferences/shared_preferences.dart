

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




 Future<void> init() async{
     _preferences = await SharedPreferences.getInstance();
    
  }

   Future<void> setUserEmail(String Email,String Password) async{
     await _preferences!.setString('Email', Email);
     await _preferences!.setString('Password', Password);
       print(Email);
        print(Password);
  }
  //  static Future setUserPassword(String Password) async{

  //      await _preferences1!.setString(_keyPassword, Password);

  // }
  // static Future setUserToken(String Token) async{
  //    await _preferences!.setString(_keyToken, Token);
  // }


   String? getUserEmail() => _preferences!.getString('Email');
   String? getUserPassword() => _preferences!.getString('Password');
  // static String? getUserToken() => _preferences!.getString(_keyToken);
  
}