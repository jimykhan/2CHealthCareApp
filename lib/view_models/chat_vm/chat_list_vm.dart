import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';

class ChatListVM extends ChangeNotifier{
  List<UnReadChat> unReadChats = [];
  List<GetGroupsModel> groupIds= [];
  List<GetGroupsModel> allGroups= [];
  bool loadingGroupId = true;
  ProviderReference? _ref;
  AuthServices? _authServices;
  SignalRServices? _signalRServices;
  ApplicationRouteService? _applicationRouteService;
  // TextEditingController searchController = TextEditingController();
  bool searchedGroup = false;

  ChatListVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }

  onClickSearch(){
    searchedGroup = !searchedGroup;
    notifyListeners();
  }
  onGroupSearch(String val){
    print("${val.length} $val");
    groupIds = [];
    groupIds.addAll(allGroups);
    if(val.length == 0){
      groupIds = [];
      groupIds.addAll(allGroups);
    }else{
      groupIds = [];
      allGroups.forEach((element) {
        if(element.title!
            .toLowerCase()
            .contains(val.toLowerCase())){
          groupIds.add(element);
        }
      });
    }
    notifyListeners();
  }
  onGroupSearchSubmit(String val){
    searchedGroup = false;
    notifyListeners();
  }

  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _signalRServices = _ref!.read(signalRServiceProvider);
    _applicationRouteService = _ref!.read(applicationRouteServiceProvider);
    _signalRServices?.newMessage.stream.listen((event) {
      print("call chat list");
      groupIds.forEach((element) {
        if(element.id == event.chatGroupId){
          print("call chat list equal id");
         element.lastMessage = event.message;
         element.lastMessageTime = convertLocalToUtc(event.timeStamp!.replaceAll("Z", ""));
         element.lastMessageTime = Jiffy(element.lastMessageTime).format(Strings.dateAndTimeFormat);
         if(_applicationRouteService?.currentScreen() != event.chatGroupId.toString()){
           element.unreadMsgCount = element.unreadMsgCount! + 1;
           bool inList = false;
           unReadChats.forEach((unRead) {
             if(unRead.chatGroupId == element.id){
               unRead.unReadMessages = element.unreadMsgCount;
               inList = true;
             }
           });
           if(!inList){
             unReadChats.add(UnReadChat(chatGroupId: element.id,unReadMessages: element.unreadMsgCount));
           }

         }
         notifyListeners();
        }
         else if(_applicationRouteService?.currentScreen() != event.chatGroupId.toString()){
          bool inList = false;
          unReadChats.forEach((unRead) {
            if(unRead.chatGroupId == element.id){
              unRead.unReadMessages = element.unreadMsgCount;
              inList = true;
            }
          });
          if(!inList){
            unReadChats.add(UnReadChat(chatGroupId: element.id,unReadMessages: element.unreadMsgCount));
          }

        }
      });
    });
  }

  setLoadingGroupId(bool check){
    loadingGroupId = check;
    notifyListeners();
  }

  Future<dynamic> getGroupsIds({bool onlounch = true}) async {
    try {
      setLoadingGroupId(true);
      final chatListService = _ref!.read(chatListServiceProvider);
      _authServices = _ref!.read(authServiceProvider);
      String UserId = await _authServices!.getCurrentAppUserId();
      var response = await chatListService.getGroupsIds(UserId: UserId);

      if (response is List<GetGroupsModel>) {
        groupIds = [];
        allGroups = [];
        response.forEach((element) {
          if(element.lastMessageTime != null){
            element.lastMessageTime = Jiffy(element.lastMessageTime).format(Strings.dateAndTimeFormat);
          }
          groupIds.add(element);
          allGroups.add(element);
          unReadChats = [];
          if(element.unreadMsgCount!>0){
            unReadChats.add(
                UnReadChat(unReadMessages: element.unreadMsgCount,
                  chatGroupId: element.id
            ));
          }
        });
        setLoadingGroupId(false);
        if(groupIds.length == 1 && !onlounch){
          Navigator.push(applicationContext!.currentContext!,
              PageTransition(child: ChatScreen(getGroupsModel: groupIds[0],backToHome: true,),
                  type: PageTransitionType.fade));
        }
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
    unReadChats.removeWhere((element) => element.chatGroupId == int.parse(groupId));
  }

}
class UnReadChat{
  int? unReadMessages;
  int? chatGroupId;
  UnReadChat({this.chatGroupId,this.unReadMessages});
}