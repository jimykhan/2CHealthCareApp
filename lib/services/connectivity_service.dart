import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService{
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ProviderReference? _ref;
  ConnectivityService({ProviderReference? ref}){
    _ref = ref;
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
      connectionStatus = result;
  }

  checkInternetConnection() async {
    try {
      connectionStatus = await _connectivity.checkConnectivity();
    }  catch (e) {
      print(e.toString());
      return;
    }
  }
}