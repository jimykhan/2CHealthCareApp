import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/facility_user_models/fu_profile_models/fu_profile_model.dart';
import 'package:twochealthcare/models/patient_summary/allergy_model.dart';
import 'package:twochealthcare/models/patient_summary/diagnose_model.dart';
import 'package:twochealthcare/models/patient_summary/family_history_model.dart';
import 'package:twochealthcare/models/patient_summary/immunization_model.dart';
import 'package:twochealthcare/models/patient_summary/madication_model.dart';
import 'package:twochealthcare/models/patient_summary/surgical_history_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class PatientSummaryService{
  ProviderReference? _ref;
  DioServices? dio;
  AuthServices? _authServices;
  SharedPrefServices? _sharedPrefServices;
  PatientSummaryService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    dio = _ref!.read(dioServicesProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
    _authServices = _ref!.read(authServiceProvider);
  }

  Future<dynamic>getDiagnosisByPatientId({required int Id})async{
    List<DiagnoseModel> diagnoseList = [];
    try{
      Response? res = await dio?.dio?.get(DiagnoseController.getDiagnosesByPatientId+"/$Id");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          diagnoseList.add(DiagnoseModel.fromJson(element));
        });
        diagnoseList.forEach((element) {
          element.diagnosisDate = Jiffy(element.diagnosisDate).format(Strings.dateFormatFullYear);
          element.resolvedDate = Jiffy(element.resolvedDate).format(Strings.dateFormatFullYear);
        });
        return diagnoseList;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

  Future<dynamic>getMedicationByPatientId({required int Id})async{
    List<MedicationModel> medicationList = [];
    try{
      Response? res = await dio?.dio?.get(MedicationsController.getMedicationsByPatientId+"/$Id");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          medicationList.add(MedicationModel.fromJson(element));
        });
        medicationList.forEach((element) {
          element.startDate = Jiffy(element.startDate).format(Strings.dateFormatFullYear);
          element.stopDate = Jiffy(element.stopDate).format(Strings.dateFormatFullYear);
        });
        return medicationList;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }
  Future<dynamic>getAllergyByPatientId({required int Id})async{
    List<AllergyModel> allergyList = [];
    try{
      Response? res = await dio?.dio?.get(AllergyController.getPatientAllergy+"/$Id");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          allergyList.add(AllergyModel.fromJson(element));
        });
        allergyList.forEach((element) {
          element.createdOn = Jiffy(element.createdOn).format(Strings.dateFormatFullYear);
          element.updatedOn = Jiffy(element.updatedOn).format(Strings.dateFormatFullYear);
        });
        return allergyList;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

  Future<dynamic>getImmunizationByPatientId({required int Id})async{
    List<ImmunizationModel> immunizationList = [];
    try{
      Response? res = await dio?.dio?.get(ImmunizationsController.getImmunizationsOfPatient+"/$Id");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          immunizationList.add(ImmunizationModel.fromJson(element));
        });
        immunizationList.forEach((element) {
          element.date = Jiffy(element.date).format(Strings.dateFormatFullYear);
        });
        return immunizationList;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

  Future<dynamic>getFamilyHistoryByPatientId({required int Id})async{
    List<FamilyHistoryModel> familyHistoryList = [];
    try{
      Response? res = await dio?.dio?.get(FamilyHistoryController.getFamilyHistory+"/$Id");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          familyHistoryList.add(FamilyHistoryModel.fromJson(element));
        });
        familyHistoryList.forEach((element) {
          element.updatedOn = Jiffy(element.updatedOn).format(Strings.dateFormatFullYear);
        });
        return familyHistoryList;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

  Future<dynamic>getSurgicalHistoryByPatientId({required int Id})async{
    List<SurgicalHistoryModel> surgicalHistoryList = [];
    try{
      Response? res = await dio?.dio?.get(SurgicalController.getSurgicalHistoriesByPatientId+"/$Id");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          surgicalHistoryList.add(SurgicalHistoryModel.fromJson(element));
        });
        surgicalHistoryList.forEach((element) {

          element.createdOn = Jiffy(element.createdOn).format(Strings.dateFormatFullYear);
        });
        return surgicalHistoryList;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

}