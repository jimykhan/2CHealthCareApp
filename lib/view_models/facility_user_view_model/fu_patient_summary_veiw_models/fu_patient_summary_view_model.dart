import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_home_service.dart';

class FUPatientSummaryVM extends ChangeNotifier{
  List<PatientSummaryMenu> patientSummaryMenuList =  [
    PatientSummaryMenu(isSelected: true,menuText: "Summary"),
    PatientSummaryMenu(isSelected: false,menuText: "Diagnosis"),
    PatientSummaryMenu(isSelected: false,menuText: "Medications"),
    PatientSummaryMenu(isSelected: false,menuText: "Allergies"),
    PatientSummaryMenu(isSelected: false,menuText: "Immunization"),
    PatientSummaryMenu(isSelected: false,menuText: "Care Plan"),
    PatientSummaryMenu(isSelected: false,menuText: "Providers"),
    PatientSummaryMenu(isSelected: false,menuText: "Family History"),
    PatientSummaryMenu(isSelected: false,menuText: "Surgical History"),
  ];
  ProviderReference? _ref;
  FUPatientSummaryVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    // fuHomeService = _ref!.read(fuHomeServiceProvider);
  }
  onMenuChange(index){
    int i = 0;
    patientSummaryMenuList.forEach((element) {
      if(index == i){
        element.isSelected = true;
      }else{
        element.isSelected = false;
      }
      i++;
    });
    notifyListeners();
  }
}
class PatientSummaryMenu{
  bool isSelected;
  String menuText;
  PatientSummaryMenu({required this.isSelected,required this.menuText});
}