import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_message_model.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twochealthcare/util/application_colors.dart';
class SignalRServices{
  PublishSubject<ChatMessageModel> newMessage = PublishSubject<ChatMessageModel>(sync: true);
  PublishSubject<dynamic> onChatViewed = PublishSubject<dynamic>(sync: true);
  HubConnection? connection;
  CurrentUser? currentUser;

  ProviderReference? _ref;
  AuthServices? _authServices;
  ApplicationRouteService? _applicationRouteService;
  SignalRServices({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _applicationRouteService = _ref!.read(applicationRouteServiceProvider);

  }
  initSignalR() async{
    // _startConnection();
    String appId  = await _authServices!.getCurrentAppUserId();
    String token  = await _authServices!.getBearerToken();
    print("this is token to signalR = $token}");
    print("2cch this is AppId to signalR = ${appId}");
    connection = HubConnectionBuilder()
        .withUrl(baseUrl + "/chatHub",
            HttpConnectionOptions(
                client: IOClient(
                    HttpClient()..badCertificateCallback = (x, y, z) => true),
                logging: (level, message) => print(message),
                accessTokenFactory: () => accessToken(token)))
        .withAutomaticReconnect()
        .build();
    // await _startConnection();
    // if (connection.state == HubConnectionState.connected) {
    //   // _connectionStarted.sink.add(HubConnectionState.connected);
    // }

    connection?.start()?.then((value) {
      print("2cCHat than call");
      SubscribeGroupsByUserId(appId: appId);
      subscribeSignalrMessages();
    });
    connection?.onreconnected((connectionId) async {
      print('2cCHat Reconnected');
      SubscribeGroupsByUserId(appId: appId);
    });
    connection?.onclose((connectionId) async {
      print('2cCHat Dismissed');
      // await _startConnection();
      unSubscribeSignalrMessages();
    });
  }


  Future<void> disConnectSignalR() async {
    if (connection?.state == HubConnectionState.connected) {
      await connection?.stop();
      unSubscribeSignalrMessages();
      connection = null;

    }
  }


  Future<void> _startConnection() async {
    if (connection?.state == HubConnectionState.disconnected) {
      print("try to connect..");
      await connection?.start();
    }else{
      print("connection status ${connection?.state}");
    }
  }



  Future<void> restartConnection() async {
    await _startConnection();
  }

  SubscribeGroupsByUserId({String? appId}) async {
    currentUser = await _authServices?.getCurrentUserFromSharedPref();
    int? facilityId = await _authServices?.getFacilityId();

    var result1 = await connection?.invoke(
      'SubscribeGroupsByUserId',
      args: [appId],
    ).onError((error, stackTrace) {
      print(
          "2cCHat error during inwoke SubscribeGroupsByUserId ${error.toString()}");
    }).then(
            (value) => {print('2cCHat Connection successful' + value.toString())});
    print("2cCHat this is the result1 var val = ${result1.toString()}");


    if(currentUser != null){
      var invokeUserName = await connection?.invoke(
        'AddToGroup',
        args: [currentUser?.userName],
      ).onError((error, stackTrace) {
        print(
            "2cCHat error during inwoke AddToGroup [${currentUser?.userName}] ${error.toString()}");
      }).then(
              (value) => {print('2cCHat Connection successful AddToGroup [${currentUser?.userName}]' + value.toString())});
      print("2cCHat this is the result1 var val = ${result1.toString()}");
    }

    if(currentUser!.userType == 5){
      var invokeFacilityId = await connection?.invoke(
        'AddToGroup',
        args: ["${facilityId}-oncommunication"],
      ).onError((error, stackTrace) {
        print(
            "2cCHat error during inwoke AddToGroup [${facilityId}] ${error.toString()}");
      }).then(
              (value) => {print('2cCHat Connection successful AddToGroup [${facilityId}-oncommunication]' + value.toString())});
      print("2cCHat this is the result1 var val = ${result1.toString()}");
    }

    }




  subscribeSignalrMessages() {
    unSubscribeSignalrMessages();
    connection?.on("OnChatViewed", (data) {
      print("On Chat Viewed");
      var makeJson = [
        {
          "participients": [],
          "chatGroupId":"",
          "chatGroupId" :"",
        }
      ];
      data!.forEach((element) {
        var newData = jsonDecode(element);
        onChatViewed.add(newData);
        print("OnChatViewed call ${jsonDecode(element)}");
      });

      // chatGroupId
      //channelName
    });
    connection?.on('OnDataReceived', (data) {

    });
    connection?.on('ReceiveMessage', (data) {
      print("ReceiveMessage New message from signal R = ${data.toString()}");
    });
    connection?.on('OnAppNotifications', (data) {
      print("OnAppNotifications call ${data}}");
    });
    connection?.on('OnStopConnectionRequest', (data) {
      print("OnStopConnectionRequest call ${data}}");
    });
    connection?.on('OnConfirmation', (data) {
      print("OnConfirmation call ${data}}");
    });
    connection?.on('OnHistoryViewedConfirmation', (data) {
      print("OnHistoryViewedConfirmation call ${data}}");
    });
    connection?.on('OnRpmAlertDataChanged', (data) {
      print("OnRpmAlertDataChanged call ${data}}");
    });
    connection?.on('OnTmPatientOnlineStatusChanged', (data) {
      print("OnTmPatientOnlineStatusChanged call ${data}}");
    });
    connection?.on('OnTmEncounterStatusChanged', (data) {
      print("OnTmEncounterStatusChanged call ${data}}");
    });
    connection?.on('OnVideoChat', (data) {
      print("OnVideoChat call ${data}}");
    });
    connection?.on('OnChatMessageReceived', (data) {
      // if (data != null) {
      //   data.forEach((element) {
      //     newMessage.add(ChatMessage.fromJson(element));
      //   });
      // }
    });
    // connection?.on('OnChatMessageReceived', (data) => newMessage.add() );
    connection?.on('OnChatRequest', (data) {
      print("onChatRequest call $data}");
    });
    connection?.on('OnChatViewed', (data) {
      print("OnChatViewed call $data}");
    });

    ///OnPatientCommunicationReceived

    /// Single R chat
    connection?.on("OnPatientCommunicationReceived", (data) {
      // +18326319363
      if (data != null) {
        data.forEach((element) {

          ChatMessageModel message = ChatMessageModel.fromJson(element);
          // if(currentUser?.appUserId != message.senderUserId){
            if(message.type != null){
              if(message.type == 0) message.messageType = ChatMessageType.text;
              if(message.type == 1) message.messageType = ChatMessageType.sms;
              if(message.type == 2) message.messageType = ChatMessageType.document;
              if(message.type == 3) message.messageType = ChatMessageType.image;
              if(message.type == 4) message.messageType = ChatMessageType.audio;
            }
            newMessage.add(message);
          // }
        });
      }
    });
  }


  unSubscribeSignalrMessages() {
    connection?.off("OnChatViewed");
    connection?.off('OnDataReceived');
    connection?.off('ReceiveMessage');
    connection?.off('OnAppNotifications');
    connection?.off('OnStopConnectionRequest');
    connection?.off('OnConfirmation');
    connection?.off('OnHistoryViewedConfirmation');
    connection?.off('OnRpmAlertDataChanged');
    connection?.off('OnTmPatientOnlineStatusChanged');
    connection?.off('OnTmEncounterStatusChanged');
    connection?.off('OnVideoChat');
    connection?.off('OnChatMessageReceived');
    // connection?.off('OnChatMessageReceived', (data) => newMessage.add() );
    connection?.off('OnChatRequest');
    connection?.off('OnChatViewed');
  }

  MarkChatGroupViewed({required int chatGroupId, required String userId}) async {
    print("MarkChatGroupViewed call");
    await connection?.invoke("MarkChatGroupViewed",args: [chatGroupId,userId.trim()])
        .onError((error, stackTrace) => print("error ${error.toString()}"))
        .then((value) => print("than ${value.toString()}"));
  }

  SendBarcode({required String barcode}) async {
    print("MarkChatGroupViewed call");
    String userId  = await _authServices!.getCurrentAppUserId();
    await connection?.invoke("SendBarcode",args: [barcode,userId])
        .onError((error, stackTrace) {
      print("error ${error.toString()}");
    })
        .then((value) {
      print("than ${value.toString()}");
    });
  }


  Future<String> accessToken(String token) async {
    return token;
  }


}