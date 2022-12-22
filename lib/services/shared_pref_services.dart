import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
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
   try{
     if(data != null){
       var data1 = _prefs?.setString("loggedInUsers", jsonEncode(data));
       return LogedInUserModel.fromJson(data);
     }else{
       var User = _prefs?.getString("loggedInUsers");

       lastLoggedInUser = LogedInUserModel.fromJson(jsonDecode(User.toString()));
       return lastLoggedInUser;
     }
   }catch(ex){
     return lastLoggedInUser;
   }
  }

  setPatientInfo(var data) async {
    await _initPref();
    _prefs?.setString("patientInfo", jsonEncode(data));
  }

  Future<dynamic> getPatientInfo() async {
    await _initPref();
    var p_info = _prefs?.get("patientInfo");
    if(p_info is String){
      return jsonDecode(p_info);
    }
      return null;
  }

  Future<int> getFacilityId() async {
    await _initPref();
    CurrentUser? currentUser = await getCurrentUser();
    int facilityId = -1;
    currentUser!.claims?.forEach((element) {
      if(element.claimType?.toUpperCase() == "FacilityId".toUpperCase()){
        facilityId = int.parse("${element.claimValue?? -1}");
      }
    });
    return facilityId;
  }
  Future<String> getUserLastLoginDateTime() async {
    await _initPref();
    CurrentUser? currentUser = await getCurrentUser();
    String lastLoginDateTime = "";
    lastLoginDateTime = currentUser?.userLastLogin??"";
    return lastLoginDateTime;
  }
  Future<int> getCurrentUserId() async {
    await _initPref();
    CurrentUser? currentUser = await getCurrentUser();
    int currentUserId = -1;
    currentUser!.claims?.forEach((element) {
      if(element.claimType?.toUpperCase() == "Id".toUpperCase()){
        currentUserId = int.parse("${element.claimValue?? -1}");
      }
    });
    return currentUserId;
  }



  Future<String> getCurrentAppUserId() async {
    await _initPref();
    CurrentUser? currentUser = await getCurrentUser();
    String currentAppUserId = "";
    currentUser!.claims?.forEach((element) {
      if(element.claimType?.toUpperCase() == "AppUserId".toUpperCase()){
        currentAppUserId = element.claimValue??"";
      }
    });
    return currentAppUserId;
  }

  Future<int> getCurrentUserType() async {
    await _initPref();
    CurrentUser? currentUser = await getCurrentUser();
    int currentUserType = -1;
    currentUserType = currentUser?.userType??1;
    return currentUserType;

  }

  setShortToken(String token)async{
    await _initPref();
    _prefs?.setString("shortToken", token);
  }

  dynamic getShortToken()async{
    String? token;
    await _initPref();
    try{
      token = await _prefs?.getString("shortToken");
      return token;
    }catch(e){
      return token;
    }
  }

}