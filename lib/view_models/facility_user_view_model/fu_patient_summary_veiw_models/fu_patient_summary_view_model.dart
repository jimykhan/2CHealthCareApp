import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_home_service.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/alliergies_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/medications_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/summary_body.dart';

class FUPatientSummaryVM extends ChangeNotifier{
  List<PatientSummaryMenu> patientSummaryMenuList =  [
    PatientSummaryMenu(isSelected: true,menuText: "Summary", body: SummaryBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Diagnosis",body: Container()),
    PatientSummaryMenu(isSelected: false,menuText: "Medications",body: MedicationsBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Allergies",body: AllergiesBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Immunization",body: Container()),
    PatientSummaryMenu(isSelected: false,menuText: "Care Plan",body: Container()),
    PatientSummaryMenu(isSelected: false,menuText: "Providers",body: Container()),
    PatientSummaryMenu(isSelected: false,menuText: "Family History",body: Container()),
    PatientSummaryMenu(isSelected: false,menuText: "Surgical History",body: Container()),
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
  Widget body;
  PatientSummaryMenu({required this.isSelected,required this.menuText,required this.body});
}