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



  Future<dynamic>getMedicationByPatientId({required int Id})async{
    List<MedicationModel> medicationList = [];
    try{
      Response? res = await dio?.dio?.get(MedicationsController.getMedicationsByPatientId+"/$Id");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          medicationList.add(MedicationModel.fromJson(element));
        });
        medicationList.forEach((element) {
          element.medlineUrl = "https://connect.medlineplus.gov/application?mainSearchCriteria.v.c=${element.rxCui}&mainSearchCriteria.v.cs=2.16.840.1.113883.6.88&mainSearchCriteria.v.dn=&informationRecipient.languageCode.c=en";
          if(element.startDate != null) {
            element.startDate =
                Jiffy(element.startDate).format(Strings.dateFormatFullYear);
          }
          if(element.stopDate != null){
            element.stopDate = Jiffy(element.stopDate).format(Strings.dateFormatFullYear);
          }

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
          if(element.createdOn !=null) {
            element.createdOn =
                Jiffy(element.createdOn).format(Strings.dateFormatFullYear);
          }
          if(element.updatedOn !=null) {
            element.updatedOn =
                Jiffy(element.updatedOn).format(Strings.dateFormatFullYear);
          }
          element.categoryString = element.category == -1 ? "All" : element.category == 1 ? "Food" :
          element.category == 2 ? "Medication" : element.category == 3 ? "Environment" : element.category == 4 ? "Biologic" : ""  ;

          element.clinicStatusString = element.clinicalStatus == -1 ? "NA" : element.clinicalStatus == 1 ? "Active" :
          element.clinicalStatus == 2 ? "InActive" : element.clinicalStatus == 3 ? "Resolved" : ""  ;

          element.typeString = element.type == -1 ? "NA" : element.type == 1 ? "Allergy" :
          element.type == 2 ? "Intolerance" : "";

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
          if(element.date !=null) {
            element.date =
                Jiffy(element.date).format(Strings.dateFormatFullYear);
          }
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
          if(element.updatedOn !=null) {
            element.updatedOn =
                Jiffy(element.updatedOn).format(Strings.dateFormatFullYear);
          }
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
          if(element.createdOn !=null) {
            element.createdOn =
                Jiffy(element.createdOn).format(Strings.dateFormatFullYear);
          }
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