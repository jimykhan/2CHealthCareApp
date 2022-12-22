import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
// import 'package:new_version/new_version.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/chat_services/chat_list_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class AdminHomeVM extends ChangeNotifier{
  AuthServices? _authService;
  ChatListService? chatListService;
  SharedPrefServices? _sharedPrefServices;
  ProviderReference? _ref;
  bool adminHomeScreenLoading = false;
  bool reset = false;

  AdminHomeVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    chatListService = _ref!.read(chatListServiceProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
  }
  resetAdminHome(){
    if(!reset){
      Future.delayed(Duration(seconds: 2),(){
        reset = true;
        notifyListeners();
      });
    }
  }

  setAdminHomeScreenLoading(check){
    adminHomeScreenLoading = check;
    notifyListeners();
  }
}