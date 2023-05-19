import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_group_model.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_message_model.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_summary_data_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/chat_services/patient_communication_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';
import 'package:twochealthcare/views/chat/components/slider_menu.dart';

class ChatListVM extends ChangeNotifier {

  List<GetGroupsModel> groupIds = [];
  List<GetGroupsModel> allGroups = [];
  ProviderReference? _ref;
  AuthServices? _authServices;
  SignalRServices? _signalRServices;
  ApplicationRouteService? _applicationRouteService;
  SharedPrefServices? _sharedPrefServices;


  PatientCommunicationService? _patientCommunicationService;
  bool isTextFieldActive = false;
  bool loadingChatList = true;
  bool pageWiseLoading = false;
  int? currentUserUserId;
  int loadingPageNumber = 1;
  List<ChatGroupModel> chatGroupList = [];
  ChatSummaryDataModel? chatSummaryData;
  List<Menu> chatTypeList = [
    Menu(id: -1, name: "All Chat",),
    Menu(id: 0, name: "New", count: 0,),
    Menu(id: 1, name: "Critical", count: 0,),
    Menu(id: 2, name: "Following", count: 0,)
  ];

  // TextEditingController searchController = TextEditingController();


  ChatListVM({ProviderReference? ref}) {
    _ref = ref;
    initService();
  }

  checkFocus(bool val) {
    isTextFieldActive = val;
    notifyListeners();
  }


  onGroupSearch(String val) {
    print("${val.length} $val");
    groupIds = [];
    groupIds.addAll(allGroups);
    if (val.length == 0) {
      groupIds = [];
      groupIds.addAll(allGroups);
    } else {
      groupIds = [];
      allGroups.forEach((element) {
        if (element.title!
            .toLowerCase()
            .contains(val.toLowerCase())) {
          groupIds.add(element);
        }
      });
    }
    notifyListeners();
  }


  initService() {
    _authServices = _ref!.read(authServiceProvider);
    _signalRServices = _ref!.read(signalRServiceProvider);
    _applicationRouteService = _ref!.read(applicationRouteServiceProvider);
    _patientCommunicationService =
        _ref!.read(patientCommunicationServiceProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
    // _signalRServices?.newMessage.stream.listen((event) {
    //   print("call chat list");
    //   groupIds.forEach((element) {
    //     if(element.id == event.chatGroupId){
    //       print("call chat list equal id");
    //      element.lastMessage = event.message;
    //      element.lastMessageTime = convertLocalToUtc(event.timeStamp!.replaceAll("Z", ""));
    //      element.lastMessageTime = Jiffy(element.lastMessageTime).format(Strings.dateAndTimeFormat);
    //      if(_applicationRouteService?.currentScreen() != event.chatGroupId.toString()){
    //        element.unreadMsgCount = element.unreadMsgCount! + 1;
    //        bool inList = false;
    //        unReadChats.forEach((unRead) {
    //          if(unRead.chatGroupId == element.id){
    //            unRead.unReadMessages = element.unreadMsgCount;
    //            inList = true;
    //          }
    //        });
    //        if(!inList){
    //          unReadChats.add(UnReadChat(chatGroupId: element.id,unReadMessages: element.unreadMsgCount));
    //        }
    //
    //      }
    //      notifyListeners();
    //     }
    //      else if(_applicationRouteService?.currentScreen() != event.chatGroupId.toString()){
    //       bool inList = false;
    //       unReadChats.forEach((unRead) {
    //         if(unRead.chatGroupId == element.id){
    //           unRead.unReadMessages = element.unreadMsgCount;
    //           inList = true;
    //         }
    //       });
    //       if(!inList){
    //         unReadChats.add(UnReadChat(chatGroupId: element.id,unReadMessages: element.unreadMsgCount));
    //       }
    //
    //     }
    //   });
    // });

    _signalRServices?.newMessage.stream.listen((event) {
      print("new message reached to Rx dart..");
      print(event.timeStamp.toString());
      ChatMessageModel message = ChatMessageModel.fromJson(event.toJson());
      // if (event.senderUserId != currentUserAppUserId) {


      message.messageStatus = MessageStatus.viewed;

      if (message.timeStamp != null) {
        message.timeStamp =
            convertLocalToUtc(message.timeStamp!.replaceAll("Z", ""));
        DateTime currentDate = DateTime.now();
        final lastMessageTime = DateTime.parse(message.timeStamp!);
        int difference = currentDate
            .difference(lastMessageTime)
            .inDays;
        if (difference == 1) {
          message.timeStamp = "Yesterday";
        }
        else if (difference > 1) {
          message.timeStamp =
              Jiffy(message.timeStamp).format(Strings.dateFormatFullYear);
        }
        else {
          message.timeStamp =
              Jiffy(message.timeStamp).format(Strings.TimeFormat);
        }
      }

      chatGroupList.forEach((element) {
        if (element.id == message.patientId) {
          element.lastCommunication = message;
          notifyListeners();
        }
      });


      // }
    });
  }


  Future<dynamic> getGroupsIds({bool onlounch = true}) async {
    try {
      setLoadingChatList(true);
      final chatListService = _ref!.read(chatListServiceProvider);
      _authServices = _ref!.read(authServiceProvider);
      String UserId = await _authServices!.getCurrentAppUserId();
      var response = await chatListService.getGroupsIds(UserId: UserId);

      if (response is List<GetGroupsModel>) {
        groupIds = [];
        allGroups = [];
        // unReadChats = [];
        response.forEach((element) {
          if (element.lastMessageTime != null) {
            element.lastMessageTime = Jiffy(element.lastMessageTime).format(
                Strings.dateAndTimeFormat);
          }
          groupIds.add(element);
          allGroups.add(element);

          if (element.unreadMsgCount! > 0) {
            // unReadChats.add(
            //     UnReadChat(unReadMessages: element.unreadMsgCount,
            //         chatGroupId: element.id
            //     ));
          }
        });
        setLoadingChatList(false);
        if (groupIds.length == 1 && !onlounch) {
          Navigator.push(applicationContext!.currentContext!,
              PageTransition(child: ChatScreen(
                getGroupsModel: groupIds[0], backToHome: true,),
                  type: PageTransitionType.fade));
        }
      }
      else {
        setLoadingChatList(false);
      }
    } catch (e) {
      setLoadingChatList(false);
      print(e.toString());
    }
  }


  Future<dynamic> getPatientGroupByFacilityId(
      {int? pageNumber, bool unread = false, critical = false, following = false}) async {
    try {
      pageNumber == 1 ? setLoadingChatList(true) : setPageWiseLoading(true);
      int facilityId = await _sharedPrefServices!.getFacilityId();
      String appUserId = await _authServices!.getCurrentAppUserId();

      var response = await _patientCommunicationService
          ?.getPatientGroupByFacilityId(
          facilityId: facilityId,
          pageNumber: loadingPageNumber,
          unread: unread,
          following: following,
          critical: critical,
          pageSize: 10000);
      if (response is List<ChatGroupModel>) {
        if (loadingPageNumber == 1) {
          chatGroupList = response;

          setLoadingChatList(false);
        } else {
          if (response.length != 0) {
            chatGroupList.insertAll(0, response ?? []);
          }
          setPageWiseLoading(false);
        }
        response.length > 0 ? loadingPageNumber++ : null;
        // markChatViewed();
        return chatGroupList;
      } else {
        loadingPageNumber == 1
            ? setLoadingChatList(false)
            : setPageWiseLoading(false);
        return null;
      }
    } catch (e) {
      loadingPageNumber == 1
          ? setLoadingChatList(false)
          : setPageWiseLoading(false);
    }
  }

  getChatSummaryDataByFacilityId() async {
    int? facility = await _sharedPrefServices?.getFacilityId();
    var response = await _patientCommunicationService
        ?.getChatSummaryDataByFacilityId(facilityId: facility);
    if (response is ChatSummaryDataModel) {
      chatSummaryData = response;
      chatTypeList.forEach((element) {
        if (element.id == 0) element.count = chatSummaryData?.unread ?? 0;
        if (element.id == 1) element.count = chatSummaryData?.critical ?? 0;
        if (element.id == 2) element.count = chatSummaryData?.following ?? 0;
        if (element.id == 3) element.count = chatSummaryData?.anonymous ?? 0;
      });
      // notifyListeners();
    }
  }

  setLoadingChatList(bool check) {
    loadingChatList = check;
    notifyListeners();
  }

  setPageWiseLoading(bool check) {
    pageWiseLoading = check;
    notifyListeners();
  }

  resetCounter(String groupId) {
    if (groupIds.length > 0) {
      groupIds.forEach((element) {
        if (element.id.toString() == groupId) {
          element.unreadMsgCount = 0;
          // notifyListeners();
        }
      });
    }
    // unReadChats.removeWhere((element) =>
    // element.chatGroupId == int.parse(groupId));
    // unReadChats.removeWhere((element) => element.unReadMessages! == 0);
    notifyListeners();
  }

  onChatFilterChange(Menu menu) {
    loadingPageNumber = 1;
    if (menu.id == 0) getPatientGroupByFacilityId(
        pageNumber: 1, unread: true, following: false, critical: false);
    if (menu.id == 1) getPatientGroupByFacilityId(
        pageNumber: 1, critical: true, following: false, unread: false);
    if (menu.id == 2) getPatientGroupByFacilityId(
        pageNumber: 1, following: true, unread: false, critical: false);
    if (menu.id == -1) getPatientGroupByFacilityId(pageNumber: 1);
  }
}