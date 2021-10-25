import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/login_services.dart';
import 'package:twochealthcare/validator/login_validator.dart';

class LoginVM extends ChangeNotifier{
  CurrentUser? currentUser;
  bool loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailFieldValid = true;
  String emailErrorText = "";
  bool isPasswordFieldValid = true;
  String passwordErrorText = "";
  ProviderReference? _ref;
  LoginVM({ProviderReference? ref}){
    _ref = ref;
  }

  onChangeEmail(String val){
    fieldValidation(val,fieldType: 0);
  }

  onChangePassword(String val){
    fieldValidation(val,fieldType: 1);
  }

  setLoading(bool isLoading){
    loading = isLoading;
    notifyListeners();
  }

  userLogin({String? userName, String? password, String? rememberMe}) async {
    LoginServices loginService = _ref!.read(loginServiceProvider);
    var res = await loginService.userLogin();
    if(res is CurrentUser){
      currentUser = res;
    }


  }



  bool fieldValidation(String val, {int fieldType = 0}){
    /// fieldType 0 for userName validator
    /// fieldType 1 for password validator
    /// fieldType 2 for both validator
    if(fieldType == 0){
      bool emailValid = LoginValidator.validUserName(val);
      if(!emailValid){
        emailErrorText = "Please enter your Email / User Name";
        isEmailFieldValid = false;
      }
      else{
        emailErrorText = "";
        isEmailFieldValid = true;
      }
      notifyListeners();
      return isEmailFieldValid;
    }
    else if(fieldType == 1){
      bool emailValid = LoginValidator.validPassword(val);
      if(!emailValid){
        passwordErrorText = "Please enter your password";
        isPasswordFieldValid = false;
      }
      else{
        passwordErrorText = "";
        isPasswordFieldValid = true;
      }
      notifyListeners();
      return isPasswordFieldValid;}
    else if(fieldType == 2){return false;}
    else{return false;}

  }
}