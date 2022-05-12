import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/care_plan/CarePlanModel.dart';
import 'package:twochealthcare/models/patient_summary/chronic_condition.dart';
import 'package:twochealthcare/models/patient_summary/diagnose_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';

class DiagnosisService{
  ProviderReference? _ref;
  DioServices? _dioServices;
  AuthServices? _authServices;
  DiagnosisService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _dioServices = _ref!.read(dioServicesProvider);
  }


  Future<dynamic>getDiagnosisByPatientId({int? Id})async{
    List<DiagnoseModel> diagnoseList = [];
    try{
      Response? res = await _dioServices?.dio?.get(DiagnoseController.getDiagnosesByPatientId+"/$Id");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          diagnoseList.add(DiagnoseModel.fromJson(element));
        });
        diagnoseList.forEach((element) {
          element.medlineUrl = "https://connect.medlineplus.gov/application?mainSearchCriteria.v.c=${element.icdCode}&mainSearchCriteria.v.cs=2.16.840.1.113883.6.90&mainSearchCriteria.v.dn=&informationRecipient.languageCode.c=en";
          if(element.diagnosisDate != null){
            element.diagnosisDate = Jiffy(element.diagnosisDate).format(Strings.dateFormatFullYear);
          }
          if(element.resolvedDate !=null){
            element.resolvedDate = Jiffy(element.resolvedDate).format(Strings.dateFormatFullYear);
          }


        });
        return diagnoseList;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

  Future<dynamic>getChronicConditionsByPatientId({int? Id})async{
    int patientId = await _authServices!.getCurrentUserId();
    List<ChronicConditionModel> chronicConditions = [];
    try{
      Response? res = await _dioServices?.dio?.get(DiagnoseController.getChronicConditionsByPatientId+"/${Id??patientId}");
      if(res?.statusCode == 200){
        res?.data?.forEach((element) {
          chronicConditions.add(ChronicConditionModel.fromJson(element));
        });

        return chronicConditions;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }
}