import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/util/conversion.dart';

class ChatListVM extends ChangeNotifier{
  List<GetGroupsModel> groupIds= [];
  bool loadingGroupId = true;
  ProviderReference? _ref;
  AuthServices? _authServices;
  SignalRServices? _signalRServices;
  ChatListVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }

  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _signalRServices = _ref!.read(signalRServiceProvider);
    _signalRServices?.newMessage.stream.listen((event) {
      print("call chat list");
      groupIds.forEach((element) {
        if(element.id == event.chatGroupId){
          print("call chat list equal id");
         element.lastMessage = event.message;
         element.lastMessageTime = convertLocalToUtc(event.timeStamp!.replaceAll("Z", ""));
         notifyListeners();
        }
      });
    });
  }
  setLoadingGroupId(bool check){
    loadingGroupId = check;
    notifyListeners();
  }

  Future<dynamic> getGroupsIds() async {
    try {
      setLoadingGroupId(true);
      final chatListService = _ref!.read(chatListServiceProvider);
      _authServices = _ref!.read(authServiceProvider);
      String UserId = await _authServices!.getCurrentAppUserId();
      var response = await chatListService.getGroupsIds(UserId: UserId);

      if (response is List<GetGroupsModel>) {
        groupIds = [];
        response.forEach((element) {
          element.lastMessageTime = Jiffy(element.lastMessageTime).format("dd MMM yy, h:mm a");
          groupIds.add(element);
        });

        setLoadingGroupId(false);
      }
      else{
        setLoadingGroupId(false);
      }
    } catch (e) {
      setLoadingGroupId(false);
      print(e.toString());
    }
  }

  resetCounter(String groupId){
    if(groupIds.length>0){
      groupIds.forEach((element) {
        if(element.id.toString() == groupId){
          element.unreadMsgCount = 0;
          notifyListeners();
        }
      });
    }
  }

}