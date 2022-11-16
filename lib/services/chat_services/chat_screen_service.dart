import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/data_format.dart';

class ChatScreenService{
  ProviderReference? _ref;
  ChatScreenService({ProviderReference? ref}){
    _ref = ref;
  }

  Future<dynamic> getAllMessages({String? userId, required var queryParameters}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getPagedPrivateChatHistory,
          queryParameters: queryParameters,
      );
      if(response.statusCode == 200){
        ChatHistoryModel  chatlist;
        chatlist = ChatHistoryModel.fromJson(response.data);
        chatlist.chats?.forEach((element) {
          element.messageStatus = MessageStatus.viewed;
          element.timeStamp  = convertLocalToUtc(element.timeStamp);
          if(element.senderUserId == userId){
            element.isSender = true;
          }else{
            element.isSender = false;
          }
          if(element.chatType != null){
            if(element.chatType == 0) element.messageType = ChatMessageType.text;
            if(element.chatType == 1) element.messageType = ChatMessageType.document;
            if(element.chatType == 2) element.messageType = ChatMessageType.image;
            if(element.chatType == 3) element.messageType = ChatMessageType.audio;
          }
        });
        chatlist.chats = chatlist.chats?.reversed.toList();
        return chatlist;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }


  Future<dynamic> sendTextMessage({var body, String? currentUserAppUserId}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.sendMessage,
        data: body,
      );
      if(response.statusCode == 200){
        ChatMessage newMessage = ChatMessage.fromJson(response.data);
        newMessage.messageStatus = MessageStatus.not_view;
        if (newMessage.senderUserId == currentUserAppUserId) {
          newMessage.isSender = true;
        } else {
          newMessage.isSender = false;
        }
        if(newMessage.chatType != null){
          if(newMessage.chatType == 0) newMessage.messageType = ChatMessageType.text;
          if(newMessage.chatType == 1) newMessage.messageType = ChatMessageType.document;
          if(newMessage.chatType == 2) newMessage.messageType = ChatMessageType.image;
          if(newMessage.chatType == 3) newMessage.messageType = ChatMessageType.audio;
        }
        return newMessage;
      }else{
        return false;
      }
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> markChatViewed({String? chatGroupId, String? currentUserAppUserId}) async {
    try{
      var body ={
        "applicationUserId": currentUserAppUserId,
        "chatGroupId": chatGroupId
      };
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.markChatViewed,
        data: body,
      );
      if(response.statusCode == 200){
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

// if (response is Response) {
// print("THIS IS STATUS CODE ${response.statusCode}");
// if (response.statusCode == 200) {
// ChatMessage newMessage;
// newMessage = ChatMessage.fromJson(response.data);
// if (newMessage != null) {
// newMessage.messageStatus = MessageStatus.not_view;
// print(
// "this is new Messager sender Id = ${newMessage.senderUserId} and this is current user id = ${UserId}");
// if (newMessage.senderUserId == UserId) {
// newMessage.isSender = false;
// listOfMessage.removeLast();
// listOfMessage.add(newMessage);
// } else {
// newMessage.isSender = true;
// }
// notifyListeners();
// print("is sender = ${newMessage.isSender}");
// }
//
// // notifyListeners();
// } else if (response.statusCode == 204) {
// } else {
// return false;
// }
// }