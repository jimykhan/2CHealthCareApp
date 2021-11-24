import 'dart:io';
import 'package:http/io_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:rxdart/rxdart.dart';
class SignalRServices{
  PublishSubject<ChatMessage> newMessage = PublishSubject<ChatMessage>(sync: true);
  HubConnection? connection;
  ProviderReference? _ref;
  AuthServices? _authServices;
  SignalRServices({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);

  }
  initSignalR() async{
    String appId  = await _authServices!.getCurrentAppUserId();
    String token  = await _authServices!.getBearerToken();
    // print("this is token to signalR = $token}");
    // print("2cch this is AppId to signalR = ${appId}");
    connection = HubConnectionBuilder()
        .withUrl(
            ApiStrings.baseUrl + "/chatHub",
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
    connection?.onreconnected((connectionId) {
      print('2cCHat Reconnected');
      SubscribeGroupsByUserId(appId: appId);
    });
    connection?.onclose((connectionId) async {
      print('2cCHat Dismissed');
      await _startConnection();
      SubscribeGroupsByUserId();
    });
  }

  Future<void> disConnectSignalR() async {
    if (connection?.state == HubConnectionState.connected) {
      await connection?.stop();
    }
  }

  Future<void> _startConnection() async {
    if (connection?.state == HubConnectionState.disconnected) {
      await connection?.start();
      subscribeSignalrMessages();
    }
  }

  Future<void> restartConnection() async {
    await _startConnection();
  }

  SubscribeGroupsByUserId({String? appId}) async {
    var result1 = await this.connection?.invoke(
      'SubscribeGroupsByUserId',
      args: [appId],
    ).onError((error, stackTrace) {
      print(
          "2cCHat error during inwoke SubscribeGroupsByUserId ${error.toString()}");
    }).then(
            (value) => {print('2cCHat Connection successful' + value.toString())});
    print("2cCHat this is the result1 var val = ${result1.toString()}");
  }

  subscribeSignalrMessages() {
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
      if (data != null) {
        data.forEach((element) {
          newMessage.add(ChatMessage.fromJson(element));
        });
      }
    });
    // connection?.on('OnChatMessageReceived', (data) => newMessage.add() );
    connection?.on('OnChatRequest', (data) {
      print("onChatRequest call $data}");
    });
    connection?.on('OnChatViewed', (data) {
      print("OnChatViewed call $data}");
    });
  }

  Future<String> accessToken(String token) async {
    return token;
  }


}