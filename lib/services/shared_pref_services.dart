import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/models/user/loged_in_user.dart';

class SharedPrefServices{
  ProviderReference? _ref;
  SharedPreferences? _prefs;
  SharedPrefServices({ProviderReference? ref}){
    _ref = ref;
    _initPref();
  }

  _initPref() async {
    if(_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  setCurrentUser(var data) async {
    await _initPref();
    _prefs?.setString("currentUser", jsonEncode(data));
  }

  Future<CurrentUser?> getCurrentUser()  async {
    await _initPref();
    var data1 = _prefs?.get("currentUser");
    CurrentUser? userdata;
    if(data1!=null || data1!='null' || data1!=""){
      try{
        userdata = CurrentUser.fromJson(jsonDecode(data1.toString()));
      }catch(e){
        return userdata;
      }
    }
    return userdata;
  }

  dynamic getBearerToken() async {
    await _initPref();
    CurrentUser? currentUser = await getCurrentUser();
    String? token = currentUser?.bearerToken;
    print("this is token ${token}");
    return token;
  }

  Future<LogedInUserModel?> lastLoggedInUser({var data}) async {
    await _initPref();
    LogedInUserModel? lastLoggedInUser;
    if(data != null){
      var data1 = _prefs?.setString("loggedInUsers", jsonEncode(data));
      return LogedInUserModel.fromJson(data);
    }else{
      var User = _prefs?.getString("loggedInUsers");
      return LogedInUserModel.fromJson(jsonDecode(User.toString()));
    }
  }

  setPatientInfo(var data) async {
    await _initPref();
    _prefs?.setString("patientInfo", jsonEncode(data));
  }

  Future<dynamic> getPatientInfo(var data) async {
    await _initPref();
    var p_info = _prefs?.get("patientInfo");
    if(p_info is String){
      return jsonDecode(p_info);
    }
      return null;
  }




}