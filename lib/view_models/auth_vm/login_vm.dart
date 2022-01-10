import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/models/user/is-sms-email-verified.dart';
import 'package:twochealthcare/models/user/loged_in_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/validator/login_validator.dart';
import 'package:twochealthcare/views/auths/forget_password.dart';
import 'package:twochealthcare/views/auths/login.dart';

class LoginVM extends ChangeNotifier{
  LogedInUserModel? logedInUserModel;
  CurrentUser? currentUser;
  bool loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isEmailFieldValid = true;
  String emailErrorText = "";
  bool isPasswordFieldValid = true;
  bool obscureText = true;
  String passwordErrorText = "";
  String confirmPasswordErrorText = "";
  bool isConfirmPasswordFieldValid = true;
  ProviderReference? _ref;
  AuthServices? authService;
  FirebaseService? firebaseService;
  SignalRServices? signalRServices;
  SharedPrefServices? sharedPrefServices;

  LoginVM({ProviderReference? ref}){
    _ref = ref;
    initServices();
  }
  initServices(){
     authService = _ref!.read(authServiceProvider);
     firebaseService = _ref!.read(firebaseServiceProvider);
     sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
     signalRServices = _ref!.read(signalRServiceProvider);
  }

  onChangeEmail(String val){
    fieldValidation(val,fieldType: 0);
  }

  onChangePassword(String val){
    fieldValidation(val,fieldType: 1);
  }
  onChangeConfirmPassword(String val){
    fieldValidation(val,fieldType: 3);
  }

  setLoading(bool isLoading){
    loading = isLoading;
    notifyListeners();
  }

  Future<bool> userLogin({String? userName, String? password, bool? rememberMe}) async {
    setLoading(true);
    var res = await authService?.userLogin(userName: emailController.text,
        password: passwordController.text);
    if(res is CurrentUser){
      currentUser = res;
      setLoading(false);
      return true;
    }
    setLoading(false);
    return false;
  }

  isSmsOrEmailVerified({String? userName})async{
    setLoading(true);
    var res = await authService?.isSmsOrEmailVerified(userName: emailController.text);
    if(res is IsSmsEmailVerified){
      setLoading(false);
      Navigator.push(applicationContext!.currentContext!,PageTransition(child: forgetPassword(
        userName: emailController.text,
        isEmailVerify: res.verifiedEmail!,
        isSmsVerify: res.verifiedSMS!,
      ), type: PageTransitionType.fade));
    }
    setLoading(false);
    return false;
  }

  checkLastLoggedInUser({var body}) async{
    if(body !=null){
      logedInUserModel = await sharedPrefServices!.lastLoggedInUser(data: body);
    }
    else{
      logedInUserModel = await sharedPrefServices!.lastLoggedInUser();
    }

  }

  getCurrentUserFromSharedPref()async{
    currentUser = await authService?.getCurrentUserFromSharedPref();
  }

  bool fieldValidation(String val, {int fieldType = 0}){
    /// fieldType 0 for userName validator
    /// fieldType 1 for password validator
    /// fieldType 2 for both validator
    /// fieldType 3 for confirm password validator
    /// fieldType 4 for match password comfirm password validator
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
    else if(fieldType == 3){
      bool emailValid = LoginValidator.validPassword(val);
      if(!emailValid){
        confirmPasswordErrorText = "Please enter your confirm password";
        isConfirmPasswordFieldValid = false;
      }
      else{
        confirmPasswordErrorText = "";
        isConfirmPasswordFieldValid = true;
      }
      notifyListeners();
      return isConfirmPasswordFieldValid;}
    else if(fieldType == 4){
      String? password = passwordController.text;
      String? confirmPassword = confirmPasswordController.text;
      fieldValidation(password,fieldType: 1);
      fieldValidation(confirmPassword,fieldType: 3);
      if(password != confirmPassword){
        confirmPasswordErrorText = "Please enter your confirm password";
        isConfirmPasswordFieldValid = false;
        notifyListeners();
        return isConfirmPasswordFieldValid;
      }
      else{
        if((password == "" || password == null) || (confirmPassword == "" || confirmPassword == null)){
          confirmPasswordErrorText = "";
          isConfirmPasswordFieldValid = false;
          notifyListeners();
          return isConfirmPasswordFieldValid;
        }
        else{
          confirmPasswordErrorText = "";
          isConfirmPasswordFieldValid = true;
          notifyListeners();
          return isConfirmPasswordFieldValid;
        }
      }

    }

    else{return false;}

  }

  changePassword({String? userName,String? password,String? confirmPassword,String? pinCode,})async{
    setLoading(true);
    var res = await authService?.changePassword(userName: userName,password: passwordController.text,
        confirmPassword:confirmPasswordController.text,
    pinCode: pinCode);
    if(res){
      setLoading(false);
      return userLogin(userName: userName,password: password,rememberMe: true);
    }
    setLoading(false);
    return false;
  }




  userLogout(){
    firebaseService!.turnOfChatNotification();
    firebaseService!.turnOfReadingNotification();
    authService?.updateCurrentUser(null);
    signalRServices?.disConnectSignalR();
    currentUser = null;
    Navigator.pushAndRemoveUntil(
      applicationContext!.currentContext!,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            const Login(),
      ),
          (route) => false,
    );
  }
}