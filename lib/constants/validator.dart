import 'package:easy_mask/easy_mask.dart';

MagicMask mask = MagicMask.buildMask('\\+1 (999) 999 99 99');
class Validator{
  static bool emailValidator(String val){
    if(val.length>0){
      return true;
    }
    else{
      return false;
    }
  }

  static bool AddressValidator(String val){
    if(val.length>0){
      return true;
    }
    else{
      return false;
    }
  }
  static bool PhoneNumberValidator(String val){
    if(val.length == 12){
      return true;
    }
    else{
      return false;
    }
  }
  static bool ZipCodeValidator(String val){
    if(val.length == 5){
      return true;
    }
    else{
      return false;
    }
  }
}