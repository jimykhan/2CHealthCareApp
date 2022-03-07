import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
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
              DateTime currentDate = DateTime.now();
              final lastMessageTime = DateTime.parse(element.lastMessageTime!);
              int difference = currentDate.difference(lastMessageTime).inDays;
              if(difference == 1){
                element.timeStamp = "Yesterdays";
              }
              else if(difference>1){
                element.timeStamp = Jiffy(element.lastMessageTime).format(Strings.dateFormatFullYear);
              }
              else{
                element.timeStamp = Jiffy(element.lastMessageTime).format(Strings.TimeFormat);
              }
            }});

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
      Response response = await dio.dio!.get(FacilityController.facilityServiceConfigByFacilityId+"/$facilityId");
      if(response.statusCode == 200){
        return response.data['chatService'];
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