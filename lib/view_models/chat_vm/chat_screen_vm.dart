import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/chat_services/chat_screen_service.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/util/conversion.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';

class ChatScreenVM extends ChangeNotifier {
  ChatHistoryModel chatMessageList = ChatHistoryModel();
  List<Participients>? participients = [];
  bool allMessagesLoading = true;
  bool pageWiseLoading = false;

  // bool isSearchFieldValid = true;
  TextEditingController? searchController;
  String? currentUserAppUserId;
  String? chatGroupId;
  int loadingPageNumber = 1;
  ProviderReference? _ref;
  AuthServices? _authServices;
  ChatScreenService? _chatScreenService;
  ChatListVM? _chatListVM;
  ApplicationRouteService? _applicationRouteService;
  SignalRServices? _signalRServices;
  bool isMessageEmpty = true;
  FocusNode? myFocusNode;

  ChatScreenVM({ProviderReference? ref}) {
    _ref = ref;
    initService();
  }

  dispose() {
    myFocusNode?.dispose();
    chatMessageList.chats = [];
    chatMessageList.participients = [];
  }


  searchListener() {
    searchController = TextEditingController();
    participients = [];
    participients!.addAll(chatMessageList.participients ?? []);
    searchController?.addListener(() {
      if (searchController!.text == "") {
        participients = [];
        participients!.addAll(chatMessageList.participients ?? []);
      } else {
        participients = [];
        chatMessageList.participients!.forEach((element) {
          if (element.fullName!
              .toLowerCase()
              .contains(searchController!.text.toLowerCase())) {
            participients!.add(element);
          }
        });
      }
      notifyListeners();
    });
  }

  disposeSearchController() {
    searchController?.dispose();
  }
  initChatScreen(){
    myFocusNode = FocusNode();
    myFocusNode?.addListener(() {
      print("addListener has focus ${myFocusNode?.hasFocus}");
      if(myFocusNode?.hasFocus??false){
        print("addListener has focus true");
        ChatScreen.jumpToListIndex(isDelayed: false);
      }
    });
  }

  initService() {
    chatMessageList.chats = [];
    chatMessageList.participients = [];
    _authServices = _ref!.read(authServiceProvider);
    _chatListVM = _ref!.read(chatListVMProvider);
    _chatScreenService = _ref!.read(chatScreenServiceProvider);
    _signalRServices = _ref!.read(signalRServiceProvider);
    _applicationRouteService = _ref!.read(applicationRouteServiceProvider);

    _signalRServices?.newMessage.stream.listen((event) {
      print("new message reached to Rx dart..");
      print(event.timeStamp.toString());
      if (event.senderUserId != currentUserAppUserId) {
        event.isSender = false;
        event.messageStatus = MessageStatus.viewed;
        event.timeStamp =
            convertLocalToUtc(event.timeStamp!.replaceAll("Z", ""));
        chatMessageList.chats!.add(event);
        print("${_applicationRouteService!.currentScreen()} ==  ${event.chatGroupId}");
        if (_applicationRouteService!.currentScreen() == event.chatGroupId.toString()) {
          print("this is appUserId  = ${currentUserAppUserId}");
          _signalRServices!.MarkChatGroupViewed(
              chatGroupId: event.chatGroupId!, userId: currentUserAppUserId!);
        }
        notifyListeners();
        chatMessageList.chats!.length == 0
            ? null
            : ChatScreen.jumpToListIndex(isDelayed: true);
      }
    });
    _signalRServices?.onChatViewed.stream.listen((event) {
      print("new message reached to Rx dart..");
      if (chatMessageList.chats!.length > 0) {
        if (event["chatGroupId"] == chatMessageList.chats![0].chatGroupId) {
          List<Participients> updateParticipantList = [];
          event["participients"].forEach((e) {
            updateParticipantList.add(Participients.fromJson(e));
          });
          chatMessageList.participients = [];
          chatMessageList.participients!.addAll(updateParticipantList);
          notifyListeners();
        }
      }
    });
  }

  setAllMessagesLoading(bool check) {
    allMessagesLoading = check;
    notifyListeners();
  }

  setPageWiseLoading(bool check) {
    pageWiseLoading = check;
    notifyListeners();
  }

  checkMessageField(var field) {
    if (field is String) {
      if (field.length > 0) {
        isMessageEmpty = false;

        // if
      } else {
        isMessageEmpty = true;
        myFocusNode!.unfocus();
      }
    }
    notifyListeners();
  }

  Future<dynamic> getAllMessages({String? chatGroupId, int? pageNumber}) async {
    try {
      pageNumber == 1 ? setAllMessagesLoading(true) : setPageWiseLoading(true);
      String UserId = await _authServices!.getCurrentAppUserId();
      currentUserAppUserId = UserId;
      var queryParameters = {
        "userId": UserId,
        "chatGroupId": chatGroupId,
        "pageNumber": loadingPageNumber.toString()
      };
      print(queryParameters);
      var response = await _chatScreenService?.getAllMessages(
          userId: UserId, queryParameters: queryParameters);
      if (response is ChatHistoryModel) {
        if (loadingPageNumber == 1) {
          _chatListVM!.resetCounter(chatGroupId!);
          chatMessageList.chats = [];
          chatMessageList.participients = [];
          response.chats?.forEach((item) {
            chatMessageList.chats!.add(item);
          });
          response.participients?.forEach((item) {
            chatMessageList.participients!.add(item);
          });
          setAllMessagesLoading(false);
        } else {
          if (response.chats?.length != 0) {
            chatMessageList.chats!.insertAll(0, response.chats ?? []);
          }
          setPageWiseLoading(false);
        }
        response.chats!.length > 0 ? loadingPageNumber++ : null;
        // markChatViewed();
        return chatMessageList;
      } else {
        loadingPageNumber == 1
            ? setAllMessagesLoading(false)
            : setPageWiseLoading(false);
        return null;
      }
    } catch (e) {
      loadingPageNumber == 1
          ? setAllMessagesLoading(false)
          : setPageWiseLoading(false);
    }
  }

  Future<dynamic> sendTextMessage({String? message}) async {
    try {
      isMessageEmpty = true;
      chatMessageList.chats!.add(ChatMessage(
        id: -1,
        message: message,
        sentToAll: false,
        viewedByAll: false,
        senderUserId: currentUserAppUserId,
        isSender: true,
        messageStatus: MessageStatus.not_sent,
        // timeStamp: DateTime(2021,DateTime.now().month,DateTime.now().month,03,33).toString(),
        timeStamp: DateTime.now().toString(),
      ));
      notifyListeners();
      var body = {
        "senderUserId": currentUserAppUserId,
        "chatGroupId": chatGroupId,
        "message": message,
        "linkUrl": "string",
      };
      var response = await _chatScreenService?.sendTextMessage(
          body: body, currentUserAppUserId: currentUserAppUserId);
      if (response is ChatMessage) {
        print("yes run this okay");
        chatMessageList.chats!.removeLast();
        response.messageStatus = MessageStatus.not_view;
        chatMessageList.chats!.add(response);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> markChatViewed() async {
    try {
      var response = await _chatScreenService?.markChatViewed(
          chatGroupId: chatGroupId, currentUserAppUserId: currentUserAppUserId);
      if (response is bool && response) {
        chatMessageList.chats!.forEach((element) {
          element.messageStatus = MessageStatus.viewed;
        });
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
