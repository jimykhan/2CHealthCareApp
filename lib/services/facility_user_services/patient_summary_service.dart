import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/facility_user_models/fu_profile_models/fu_profile_model.dart';
import 'package:twochealthcare/models/patient_summary/allergy_model.dart';
import 'package:twochealthcare/models/patient_summary/madication_model.dart';
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

}