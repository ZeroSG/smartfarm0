

import 'package:shared_preferences/shared_preferences.dart';



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

   List<String>? getformula() => _preferences!.getStringList('Formula');
   List<String>? getplanning() => _preferences!.getStringList('Planning');
   List<String>? getNameCrop() => _preferences!.getStringList('NameCrop');
   String? getUserEmail() => _preferences!.getString('Email');
   String? getUserPassword() => _preferences!.getString('Password');

  
}