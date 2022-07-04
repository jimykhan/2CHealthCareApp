import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/ccm_services/ccm_services.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';

class CcmPatientsVM extends ChangeNotifier{
  int currentPatienId = 0;
  ProviderReference? _ref;
  bool loading = false;
  CcmService? _ccmService;

  CcmPatientsVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _ccmService = _ref!.read(ccmServiceProvider);
  }
}