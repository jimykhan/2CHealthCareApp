import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';

class ChatScreenService{
  ProviderReference? _ref;
  ChatScreenService({ProviderReference? ref}){
    _ref = ref;
  }

  Future<dynamic> getAllMessages({required var queryParameters}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getPagedPrivateChatHistory,
          queryParameters: queryParameters,
      );
      if(response.statusCode == 200){
        List<ChatMessage> newlist = [];
        response.data.forEach((item) {
          newlist.add(ChatMessage.fromJson(item));
        });
        return newlist;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }
}