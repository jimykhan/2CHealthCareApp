import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_model.dart';
import 'package:twochealthcare/models/facility_user_models/fu_profile_models/fu_profile_model.dart';
import 'package:twochealthcare/models/patient_summary/allergy_model.dart';
import 'package:twochealthcare/models/patient_summary/diagnose_model.dart';
import 'package:twochealthcare/models/patient_summary/family_history_model.dart';
import 'package:twochealthcare/models/patient_summary/immunization_model.dart';
import 'package:twochealthcare/models/patient_summary/madication_model.dart';
import 'package:twochealthcare/models/patient_summary/surgical_history_model.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
import 'package:twochealthcare/models/profile_models/specialists_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/diagnosis_service.dart';
import 'package:twochealthcare/services/facility_user_services/facility_service.dart';
import 'package:twochealthcare/services/facility_user_services/patient_summary_service.dart';
import 'package:twochealthcare/services/patient_profile_service.dart';
import 'package:twochealthcare/views/care_plan/care_plan.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/alliergies_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/diagnosis_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/family_history_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/immunization_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/medications_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/provider_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/summary_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/surgical_history_body.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FUPatientSummaryVM extends ChangeNotifier{
  FUProfileModel? billingProvider;
  PatientsModel? summaryPatientsModel;
  bool isLoading = false;
  PatientSummaryService? _patientSummaryService;
  FacilityService? _facilityService;
  DiagnosisService? _diagnosisService;
  PatientProfileService? _patientProfileService;
  ItemScrollController? categoryScrollController;

  PatientInfo? patientInfo;
  List<DiagnoseModel> diagnoseList = [];
  List<MedicationModel> medicationList = [];
  List<AllergyModel> allergyList = [];
  List<ImmunizationModel> immunizationList = [];
  List<FamilyHistoryModel> familyHistoryList = [];
  List<SurgicalHistoryModel> surgicalHistoryList = [];
  List<Specialists> providerList = [];
  List<PatientSummaryMenu> patientSummaryMenuList =  [
    PatientSummaryMenu(isSelected: true,menuText: "Summary", body: SummaryBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Diagnosis",body: DiagnosisBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Medications",body: MedicationsBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Allergies",body: AllergiesBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Immunization",body: ImmunizationBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Care Plan",body: CarePlan(isPatientSummary: true,)),
    PatientSummaryMenu(isSelected: false,menuText: "Providers",body: ProviderBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Family History",body: FamilyHistoryBody()),
    PatientSummaryMenu(isSelected: false,menuText: "Surgical History",body: SurgicalHistoryBody()),
  ];
  ProviderReference? _ref;
  FUPatientSummaryVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
   int? _patientId(){
    return patientInfo?.id;
  }
  initService(){
     _patientSummaryService = _ref!.read(patientSummaryServiceProvider);
     _patientProfileService = _ref!.read(PatientProfileServiceProvider);
     _facilityService = _ref!.read(facilityServiceProvider);
     _diagnosisService = _ref!.read(diagnosisServiceProvider);
     categoryScrollController = ItemScrollController();
  }

  setIsLoading(check){
    isLoading = check;
    notifyListeners();
  }
  onMenuChange(index){
    int i = 0;
    patientSummaryMenuList.forEach((element) {
      if(index == i){
        element.isSelected = true;
        changeCategoryScrollPosition(index);
      }else{
        element.isSelected = false;
      }
      i++;
    });
    notifyListeners();
  }

  getDiagnosisByPatientId()async{
    try{
      setIsLoading(true);
      var res = await _diagnosisService?.getDiagnosisByPatientId(Id: summaryPatientsModel?.id??-1);
      if(res !=null && res is List<DiagnoseModel>){
        diagnoseList = [];
        diagnoseList.addAll(res);
        setIsLoading(false);
      }else{
        setIsLoading(false);
      }
    }catch(e){
      setIsLoading(false);
      return null;
    }
  }

  getMedicationByPatientId()async{
    try{
      setIsLoading(true);
      var res = await _patientSummaryService?.getMedicationByPatientId(Id: summaryPatientsModel?.id??-1);
      if(res !=null && res is List<MedicationModel>){
        medicationList = [];
        medicationList.addAll(res);
        setIsLoading(false);
      }else{
        setIsLoading(false);
      }
    }catch(e){
      setIsLoading(false);
      return null;
    }
  }

  getAllergyByPatientId()async{
    try{
      setIsLoading(true);
      var res = await _patientSummaryService?.getAllergyByPatientId(Id: summaryPatientsModel?.id??-1);
      if(res !=null && res is List<AllergyModel>){
        allergyList = [];
        allergyList.addAll(res);

        setIsLoading(false);
      }else{
        setIsLoading(false);
      }
    }catch(e){
      setIsLoading(false);
      return null;
    }
  }

  getImmunizationByPatientId()async{
    try{
      setIsLoading(true);
      var res = await _patientSummaryService?.getImmunizationByPatientId(Id: summaryPatientsModel?.id??-1);
      if(res !=null && res is List<ImmunizationModel>){
        immunizationList = [];
        immunizationList.addAll(res);
        setIsLoading(false);
      }else{
        setIsLoading(false);
      }
    }catch(e){
      setIsLoading(false);
      return null;
    }
  }

  getFamilyHistoryByPatientId()async{
    try{
      setIsLoading(true);
      var res = await _patientSummaryService?.getFamilyHistoryByPatientId(Id: summaryPatientsModel?.id??-1);
      if(res !=null && res is List<FamilyHistoryModel>){
        familyHistoryList = [];
        familyHistoryList.addAll(res);
        setIsLoading(false);
      }else{
        setIsLoading(false);
      }
    }catch(e){
      setIsLoading(false);
      return null;
    }
  }

  getSurgicalHistoryByPatientId()async{
    try{
      setIsLoading(true);
      var res = await _patientSummaryService?.getSurgicalHistoryByPatientId(Id: summaryPatientsModel?.id??-1);
      if(res !=null && res is List<SurgicalHistoryModel>){
        surgicalHistoryList = [];
        surgicalHistoryList.addAll(res);
        setIsLoading(false);
      }else{
        setIsLoading(false);
      }
    }catch(e){
      setIsLoading(false);
      return null;
    }
  }

  getPatientInfoById()async{
    try{
      setIsLoading(true);
      patientInfo = null;
      var res = await _patientProfileService?.getUserInfo(currentUserId : summaryPatientsModel?.id??-1);
      if(res !=null && res is PatientInfo){
        patientInfo = res;
        setIsLoading(false);
        if(patientInfo?.billingProviderId != null)
        billingProvider = await _facilityService?.getFuProfileInfo(Id: patientInfo!.billingProviderId!);
      }else{
        setIsLoading(false);
      }
    }catch(e){
      setIsLoading(false);
      return null;
    }

  }

  getProviderByPatientId(){
    providerList = [];
    patientInfo?.specialists?.forEach((element) {
      providerList.add(element);
    });
    setIsLoading(false);
  }
  changeCategoryScrollPosition(index)async{
    if(categoryScrollController!.isAttached){
      await categoryScrollController?.scrollTo(index: index, duration: Duration(seconds: 1),alignment: 0.3);
    }
  }


}

class PatientSummaryMenu{
  bool isSelected;
  String menuText;
  Widget body;
  PatientSummaryMenu({required this.isSelected,required this.menuText,required this.body});
}