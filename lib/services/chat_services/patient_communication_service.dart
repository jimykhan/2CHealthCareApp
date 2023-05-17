import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_group_model.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_message_model.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_summary_data_model.dart';
import 'package:twochealthcare/models/patient_communication_models/communication_history_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/util/data_format.dart';

class PatientCommunicationService{
  ProviderReference? _ref;
  late DioServices _dioService;

  PatientCommunicationService({ProviderReference? ref}){
    _ref = ref;
    _dioService = _ref!.read(dioServicesProvider);
  }

  Future<dynamic> getCommunicationHistory({String? appUserId,int? patientId, required int pageNumber, int pageSize = 10}) async {
    try{
      Response response = await _dioService.dio!.get(PatientCommunicationController.getCommunicationHistoryByPatientId+"/$patientId?PageNumber=$pageNumber&PageSize=$pageSize",
      );
      if(response.statusCode == 200){
        CommunicationHistoryModel  chatlist = CommunicationHistoryModel(results: []);
        chatlist = CommunicationHistoryModel.fromJson(response.data);
        chatlist.results?.forEach((element) {
          element.messageStatus = MessageStatus.viewed;
          element.timeStamp  = convertLocalToUtc(element.timeStamp);
          if(element.senderUserId == appUserId){
            element.isSender = true;
          }else{
            element.isSender = false;
          }
          if(element.type != null){
            if(element.type == 0) element.messageType = ChatMessageType.text;
            if(element.type == 1) element.messageType = ChatMessageType.sms;
            if(element.type == 2) element.messageType = ChatMessageType.document;
            if(element.type == 3) element.messageType = ChatMessageType.image;
            if(element.type == 4) element.messageType = ChatMessageType.audio;
          }
        });
        chatlist.results = chatlist.results?.reversed.toList();
        return chatlist;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }
  Future<dynamic> getUnReadMessageById({required int userId,}) async {
    try{
      Response response = await _dioService.dio!.get(PatientCommunicationController.getUnReadCountByPatient+"/$userId",
      );
      if(response.statusCode == 200){
        return response.data;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }

  Future<dynamic> getGenerateCasesFromMessageList({String? appUserId,int? facility,int? patientId}) async {
    try{
        _dioService.dio!.get(PatientCommunicationController.getGenerateCasesFromMessageList+"/$facility?patientId=$patientId",
      );
      // if(response.statusCode == 200){
      //   List<ChatMessageModel>? chatMessageList = [];
      //
      //   response.data?.forEach((element) {
      //     ChatMessageModel newMessage = ChatMessageModel.fromJson(element);
      //     newMessage.messageStatus = MessageStatus.viewed;
      //     newMessage.timeStamp  = convertLocalToUtc(newMessage.timeStamp);
      //     if(newMessage.senderUserId == appUserId){
      //       newMessage.isSender = true;
      //     }else{
      //       newMessage.isSender = false;
      //     }
      //     if(newMessage.type != null){
      //       if(newMessage.type == 0) newMessage.messageType = ChatMessageType.text;
      //       if(newMessage.type == 1) newMessage.messageType = ChatMessageType.sms;
      //       if(newMessage.type == 2) newMessage.messageType = ChatMessageType.document;
      //       if(newMessage.type == 3) newMessage.messageType = ChatMessageType.image;
      //       if(newMessage.type == 4) newMessage.messageType = ChatMessageType.audio;
      //     }
      //     chatMessageList?.add(newMessage);
      //   });
      //
      //   chatMessageList = chatMessageList.reversed.toList();
      //   return chatMessageList;
      //
      // }else{
      //   return null;
      // }
    }
    catch(e){
      print(e.toString());
    }

  }


  Future<dynamic> getPatientGroupByFacilityId({int? facilityId, required int pageNumber, int pageSize = 10,bool unread = false,critical = false,following = false}) async {
    // try{
      Response response = await _dioService.dio!.get(PatientCommunicationController.getPatientGroupsByFacilityId+"/$facilityId?"
          "following=$following&critical=$critical&unread=$unread&PageNumber=$pageNumber&PageSize=$pageSize",
      );
      if (response is Response) {
        if (response.statusCode == 200) {

          List<ChatGroupModel> groupIds= [];
          response.data["results"].forEach((item) {
            groupIds.add(ChatGroupModel.fromJson(item));
          });
          groupIds.forEach((element) {
            if(element.lastMessageTime !=null){
              element.lastMessageTime = convertLocalToUtc(element.lastMessageTime!.replaceAll("Z", ""));
              DateTime currentDate = DateTime.now();
              final lastMessageTime = DateTime.parse(element.lastMessageTime!);
              int difference = currentDate.difference(lastMessageTime).inDays;
              if(difference == 1){
                element.timeStamp = "Yesterday";
              }
              else if(difference>1){
                element.timeStamp = Jiffy(element.lastMessageTime).format(Strings.dateFormatFullYear);
              }
              else{
                element.timeStamp = Jiffy(element.lastMessageTime).format(Strings.TimeFormat);
              }
            }

            if(element.lastCommunication?.timeStamp !=null){
              element.lastCommunication?.timeStamp = convertLocalToUtc(element.lastCommunication?.timeStamp!.replaceAll("Z", ""));
              DateTime currentDate = DateTime.now();
              final lastMessageTime = DateTime.parse(element.lastCommunication!.timeStamp!);
              int difference = currentDate.difference(lastMessageTime).inDays;
              if(difference == 1){
                element.lastCommunication?.timeStamp = "Yesterday";
              }
              else if(difference>1){
                element.lastCommunication?.timeStamp = Jiffy(element.lastCommunication?.timeStamp).format(Strings.dateFormatFullYear);
              }
              else{
                element.lastCommunication?.timeStamp = Jiffy(element.lastCommunication?.timeStamp).format(Strings.TimeFormat);
              }
            }


          });



          if (groupIds.length == 0) {

          }
          return groupIds;
        } else {
          return null;
        }
      }
    // }
    // catch(e){
    //   print(e.toString());
    // }

  }

  Future<dynamic> getChatSummaryDataByFacilityId({int? facilityId}) async {
    // try{
      Response response = await _dioService.dio!.get(PatientCommunicationController.getCommunicationSummaryData+"/$facilityId",
      );
      if (response is Response) {
        if (response.statusCode == 200) {
          ChatSummaryDataModel summaryData;
          summaryData = ChatSummaryDataModel.fromJson(response.data);
          return summaryData;
        } else {
          return null;
        }
      }
  }

  Future<dynamic> sendMessage({var body, String? currentUserAppUserId}) async {
    try{
      Response response = await _dioService.dio!.post(PatientCommunicationController.patientCommunication,
        data: body,
      );
      if(response.statusCode == 200){
        ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(response.data);
        chatMessageModel.messageStatus = MessageStatus.not_view;
        if (chatMessageModel.senderUserId == currentUserAppUserId) {
          chatMessageModel.isSender = true;
        } else {
          chatMessageModel.isSender = false;
        }
        if(chatMessageModel.type != null){
          if(chatMessageModel.type == 0) chatMessageModel.messageType = ChatMessageType.text;
          if(chatMessageModel.type == 1) chatMessageModel.messageType = ChatMessageType.sms;
          if(chatMessageModel.type == 2) chatMessageModel.messageType = ChatMessageType.document;
          if(chatMessageModel.type == 3) chatMessageModel.messageType = ChatMessageType.image;
          if(chatMessageModel.type == 4) chatMessageModel.messageType = ChatMessageType.audio;
        }
        return chatMessageModel;
      }else{
        return false;
      }
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }


  Future<dynamic> markChatViewed({required bool inViewed, required int patientCommunicationId}) async {
    try{
      var body ={
        "patientCommunicationId": patientCommunicationId,
        "chatGroupId": inViewed
      };
      Response response = await _dioService.dio!.post(PatientCommunicationController.markCommunicationViewed,
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
