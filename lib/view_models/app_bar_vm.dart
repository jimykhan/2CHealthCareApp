import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/signal_r_services.dart';

class AppBarVM extends ChangeNotifier{
  ProviderReference? _ref;
  SignalRServices? signalRServices;
  Color connectionColor = Colors.red;
  bool tryToConnect = true;
  HubConnectionState connectState = HubConnectionState.connecting;

  AppBarVM({ProviderReference? ref}){
    _ref = ref;
    initServices();
    setTryToConnectFlag();

  }
  initServices(){
    signalRServices = _ref?.read(signalRServiceProvider);
    checkSignalRConnectionState();
  }

   checkSignalRConnectionState(){
    Future.delayed(Duration(seconds: 2),()=>checkSignalRConnectionState());
    // print("Connect state before = ${connectState},Connect state = ${signalRServices?.connection?.state??""}");
    if(signalRServices?.connection !=null){
      if(connectState != signalRServices?.connection?.state){
        connectState = signalRServices?.connection?.state ?? HubConnectionState.disconnected;
        if(connectState == HubConnectionState.connected) {
          tryToConnect = false;
          connectionColor = Colors.green;
        }
        if(connectState == HubConnectionState.disconnected) {
          connectionColor = Colors.red;
          }
        if(connectState == HubConnectionState.connecting) connectionColor = Colors.amber;
        if(connectState == HubConnectionState.disconnecting) connectionColor = Colors.lightGreenAccent;
        if(connectState == HubConnectionState.reconnecting) connectionColor = Colors.lightGreenAccent;
        notifyListeners();
      }
      if(connectState == HubConnectionState.disconnected) {
        if(!tryToConnect) {
          tryToConnect = true;
          signalRServices?.initSignalR();
          setTryToConnectFlag();
        }
      }

    }


  }
  setTryToConnectFlag(){
    Future.delayed(Duration(seconds: 15),()=>
    tryToConnect = false
    );
  }

}