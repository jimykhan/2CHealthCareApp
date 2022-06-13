import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CcmLogsVM extends ChangeNotifier{
  ProviderReference? _ref;
  CcmLogsVM({ProviderReference? ref}){

    _ref = ref;
    initService();
  }
  initService(){

  }
}