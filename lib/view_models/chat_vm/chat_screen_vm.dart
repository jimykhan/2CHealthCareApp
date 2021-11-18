import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/chat_services/chat_screen_service.dart';

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
  bool isMessageEmpty = true;

  ChatScreenVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _chatScreenService = _ref!.read(chatScreenServiceProvider);

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
      if (field.length > 0)
        isMessageEmpty = false;
      else
        isMessageEmpty = true;
    }
    notifyListeners();
  }

  Future<dynamic> getAllMessages({String? chatGroupId,int? pageNumber}) async {
    try{
      // pageNumber != null ? loadingPageNumber = pageNumber : null;
      // loadingPageNumber = pageNumber!;
      print("this is page Number $pageNumber");
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
            // chatMessageList.addAll(response);
          }
          setPageWiseLoading(false);
        }
        response.length > 0 ? loadingPageNumber ++ : null;
        return chatMessageList;
      }
      else{
        loadingPageNumber == 1 ? setAllMessagesLoading(false) : setPageWiseLoading(false);
        return null;
      }
    }
    catch(e){
      loadingPageNumber == 1 ? setAllMessagesLoading(false) : setPageWiseLoading(false);
      print(e.toString());
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
}