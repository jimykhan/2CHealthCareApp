import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/chat_services/chat_screen_service.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';

class ChatScreenVM extends ChangeNotifier{
  List<ChatMessage> chatMessageList = [];
  bool allMessagesLoading = true;
  bool pageWiseLoading = false;
  String? currentUserAppUserId;
  String? chatGroupId;
  int loadingPageNumber = 1;
  ProviderReference? _ref;
  AuthServices? _authServices;
  ChatScreenService? _chatScreenService;
  SignalRServices? _signalRServices;
  bool isMessageEmpty = true;
  FocusNode? myFocusNode = FocusNode();

  ChatScreenVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }

  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _chatScreenService = _ref!.read(chatScreenServiceProvider);
    _signalRServices = _ref!.read(signalRServiceProvider);
    _signalRServices?.newMessage.stream.listen((event) {
      print("new message reached to Rx dart..");
      if(event.senderUserId != currentUserAppUserId) {
        event.isSender = false;
        event.messageStatus = MessageStatus.viewed;
        print(chatMessageList.length.toString());
        chatMessageList.add(event);
        print(chatMessageList.length.toString());
        notifyListeners();
        ChatScreen.jumpToListIndex(isDelayed: true);
      }
    });
  }

  setAllMessagesLoading(bool check){
    allMessagesLoading = check;
    notifyListeners();
  }

  setPageWiseLoading(bool check){
    pageWiseLoading = check;
    notifyListeners();
  }

  checkMessageField(var field) {

    if (field is String) {
      if (field.length > 0){
        isMessageEmpty = false;

        // if
      }

      else{
        isMessageEmpty = true;
        myFocusNode!.unfocus();
    }

    }
    notifyListeners();
  }

  Future<dynamic> getAllMessages({String? chatGroupId,int? pageNumber}) async {
    try{
      pageNumber == 1 ? setAllMessagesLoading(true) : setPageWiseLoading(true);
      String UserId = await _authServices!.getCurrentAppUserId();
      currentUserAppUserId = UserId;
      var queryParameters = {
        "userId": UserId,
        "chatGroupId": chatGroupId,
        "pageNumber": loadingPageNumber.toString()
      };
      print(queryParameters);
      var response = await _chatScreenService?.getAllMessages(userId: UserId,queryParameters: queryParameters);
      if(response is List<ChatMessage>){
        if(loadingPageNumber == 1){
          chatMessageList = [];
          response.forEach((item) {
            chatMessageList.add(item);
          });
          setAllMessagesLoading(false);
        }else{
          if(response.length !=0){
            chatMessageList.insertAll(0, response);
          }
          setPageWiseLoading(false);
        }
        response.length > 0 ? loadingPageNumber ++ : null;
        markChatViewed();
        return chatMessageList;
      }
      else{
        loadingPageNumber == 1 ? setAllMessagesLoading(false) : setPageWiseLoading(false);
        return null;
      }
    }
    catch(e){
      loadingPageNumber == 1 ? setAllMessagesLoading(false) : setPageWiseLoading(false);
    }

  }

  Future<dynamic> sendTextMessage({String? message}) async {
    try{
      isMessageEmpty = true;
      chatMessageList.add(ChatMessage(
        id: 0,
        message: message,
        sentToAll: false,
        viewedByAll: false,
        senderUserId: currentUserAppUserId,
        isSender: true,
        messageStatus: MessageStatus.not_sent,
        timeStamp: DateTime.now().toString(),
      ));
      notifyListeners();
       var body = {
          "senderUserId": currentUserAppUserId,
          "chatGroupId": chatGroupId,
          "message": message,
          "linkUrl": "string",
        };
      var response = await _chatScreenService?.sendTextMessage(body: body,currentUserAppUserId: currentUserAppUserId);
      if(response is ChatMessage){
        chatMessageList.removeLast();
        response.messageStatus = MessageStatus.not_view;
        chatMessageList.add(response);
        notifyListeners();
        return true;
      }else{
        return false;
      }
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> markChatViewed() async {
    try{
      var response = await _chatScreenService?.markChatViewed(chatGroupId: chatGroupId,currentUserAppUserId: currentUserAppUserId);
      if(response is bool && response){
        chatMessageList.forEach((element) {
          element.messageStatus = MessageStatus.viewed;
        });
        notifyListeners();
        return true;
      }else{
        return false;
      }
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

}