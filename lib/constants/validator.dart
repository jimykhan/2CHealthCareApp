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
}