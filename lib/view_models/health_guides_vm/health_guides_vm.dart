import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/health_guides_service/health_guides_service.dart';

class HealthGuidesVM extends ChangeNotifier{
  bool loadingHealthGuides = true;
  ProviderReference? _ref;
  HealthGuidesService? _healthGuidesService;

  HealthGuidesVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _healthGuidesService = _ref!.read(healthGuidesServiceProvider);
  }

  setLoadingHealthGuide(check){
    loadingHealthGuides = check;
    notifyListeners();
  }


}