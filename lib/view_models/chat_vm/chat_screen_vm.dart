import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    allMessagesLoading = check;
    notifyListeners();
  }

  Future<dynamic> getAllMessages({String? chatGroupId,int? pageNumber}) async {
    try{
      pageNumber != null ? loadingPageNumber = pageNumber : null;
      pageNumber == 1 ? setAllMessagesLoading(true) : setPageWiseLoading(true);
      String UserId = await _authServices!.getCurrentAppUserId();
      var queryParameters = {
        "userId": UserId,
        "chatGroupId": chatGroupId,
        "pageNumber": loadingPageNumber.toString()
      };
      print(queryParameters);
      var response = await _chatScreenService?.getAllMessages(queryParameters: queryParameters);
      if(response is List<ChatMessage>){
        loadingPageNumber == 1 ? chatMessageList = [] : null;
        response.forEach((item) {
          chatMessageList.add(item);
        });
        loadingPageNumber == 1 ? setAllMessagesLoading(false) : setPageWiseLoading(false);
        loadingPageNumber ++ ;
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
}