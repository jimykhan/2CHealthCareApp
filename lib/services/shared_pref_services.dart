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

  Future<LogedInUserModel?> lastLoggedInUser({var data, String? userId}) async {
    await _initPref();
    List newList = [];
    LogedInUserModel? lastLoggedInUser;
    // bool isKeyAvail = _prefs?.containsKey("loggedInUsers")??false;
    if(_prefs?.containsKey("loggedInUsers")??false){
      String? allUser = _prefs?.getString("loggedInUsers");
      var listOfUser = jsonDecode(allUser??"");
      if(listOfUser is List){
        listOfUser.forEach((element) {
          if(element["id"] == userId){
            data == null ? null : element["lastLogedIn"] = data["lastLogedIn"];
            lastLoggedInUser = LogedInUserModel.fromJson(element);
          }
        });
        _prefs?.setString("loggedInUsers", jsonEncode(listOfUser));
        return lastLoggedInUser!;
      }
    }else{
      newList.add(data);
      _prefs?.setString("loggedInUsers", jsonEncode(newList));
      return LogedInUserModel.fromJson(data);
    }
  }



}