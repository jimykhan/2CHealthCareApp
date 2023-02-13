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

  destorySharePref() async {
    await _initPref();
    bool clearLogs = await _prefs?.clear()??false;
    print("Share Pref History clear $clearLogs");
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

  setCurrentViewPatientId(int Id) async {
    await _initPref();
    _prefs?.setInt("currentViewPatientId", Id);
  }

  Future<int> getCurrentViewPatientId() async {
    await _initPref();
    int Id = -1;
    Id = _prefs?.getInt("currentViewPatientId")??-1;
    return Id;
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

  Future<bool> IsBleEnabled() async {
    await _initPref();
    CurrentUser? currentUser = await getCurrentUser();
    bool isBleEnable = false;
    currentUser!.claims?.forEach((element) {
      if(element.claimType?.toUpperCase() == "IsBleEnabled".toUpperCase()){
        isBleEnable = element.claimValue?.toUpperCase() == "true".toUpperCase() ? true : false;
      }
    });
    return isBleEnable;
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

  dynamic setlogRpmDataLogs(var data) async {
    await _initPref();
    String logRpmDataKey = "logRpmData";
    // _prefs?.setString("logRpmData", token);
    List<Map<dynamic, dynamic>> newList = [];
    if(!(_prefs?.containsKey(logRpmDataKey)??false)){
      newList.add(data);
      _prefs?.setString(logRpmDataKey, json.encode(newList));
      print("first rpm data missed log");
      return newList;
    }
    else {
      print("Add rpm data missed to list of log");
      var rpmData =  _prefs?.get(logRpmDataKey);
      var listofRpmData = [];
      if (rpmData != null) {
        listofRpmData = jsonDecode(rpmData.toString());
        if (listofRpmData is List) {
          listofRpmData.forEach((element) {
            newList.add(element);
          });
        }
        newList.add(data);
        _prefs?.setString(logRpmDataKey, json.encode(newList));
        return newList;
      }
    }
  }

  Future<List> getRpmDataLogs() async {
    await _initPref();
    String logRpmDataKey = "logRpmData";
    // _prefs?.setString("logRpmData", token);
    List<Map<dynamic, dynamic>> newList = [];
    if(!(_prefs?.containsKey(logRpmDataKey)??false)) return [];
    else {
      var rpmData =  _prefs?.getString(logRpmDataKey);
      var listofRpmData = [];
      if (rpmData != null) {
        listofRpmData = jsonDecode(rpmData.toString());
        if (listofRpmData is List) {
          listofRpmData.forEach((element) {
            newList.add(element);
          });
        }
        return newList;
      }
      return newList;
    }
  }

  Future<dynamic> removeRpmDataLogs(int index) async {
    String logRpmDataKey = "logRpmData";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Remove rpm data missed to list of log");
    var rpmData = prefs.get(logRpmDataKey);
    var listofRpmData = [];
    if (rpmData != null) {
      listofRpmData = jsonDecode(rpmData.toString());
    }

    if (listofRpmData is List) {
      if(listofRpmData.length >0){
        listofRpmData.removeAt(index);
      }
    }
    prefs.setString(logRpmDataKey, json.encode(listofRpmData));
    return listofRpmData;

  }

}