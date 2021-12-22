import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/health_guide_models/health_guide_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/health_guides_service/health_guides_service.dart';

class HealthGuidesVM extends ChangeNotifier{
  List<HealthGuideModel> listOfHealthGuide = [];
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

  getAllHealthGuides()async{
    List<HealthGuideModel> data = [];
    data = await _healthGuidesService!.getAllHealthGuides();
    if(data is List<HealthGuideModel>){
      data.forEach((element) {
        listOfHealthGuide.add(element);
      });
    }
    setLoadingHealthGuide(false);
  }


}