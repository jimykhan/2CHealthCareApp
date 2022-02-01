import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/conversion.dart';

class ChatListService{
  ProviderReference? _ref;
  ChatListService({ProviderReference? ref}){
    _ref = ref;
  }
  Future<dynamic> getGroupsIds({required String UserId}) async {
    try {
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getChatGroupsByUserId+"/$UserId"
      );
      if (response is Response) {
        if (response.statusCode == 200) {

          List<GetGroupsModel> groupIds= [];
          response.data.forEach((item) {
            groupIds.add(GetGroupsModel.fromJson(item));
          });
          groupIds.forEach((element) {
            if(element.lastMessageTime !=null){
              element.lastMessageTime = convertLocalToUtc(element.lastMessageTime!.replaceAll("Z", ""));
            }

          });
          if (groupIds.length == 0) {

          }
          return groupIds;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
    }
  }

  Future<dynamic> checkChatStatus({int? facilityId}) async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.checkChatStatus+"/$facilityId");
      if(response.statusCode == 200){
        return response.data;
      }else{
        return false;
      }
    }
    catch(e){
      print(e.toString());
      return -1;
    }
  }



}