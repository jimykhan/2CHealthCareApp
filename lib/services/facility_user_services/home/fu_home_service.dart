import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/dashboard_patient_summary.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class FUHomeService{
  ProviderReference? _ref;
  DioServices? dio;
  SharedPrefServices? _sharedPrefServices;
  FUHomeService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    dio = _ref!.read(dioServicesProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
  }

    Future<dynamic>getPatientsForDashboard({int filterBy = 1,required int pageNumber,String? patientStatus,String? searchParam,
      String? payerIds,String? sortBy,int sortOrder=0})async{

    PatientsForDashboard? patientsForDashboard;
    try{
      int facilityId = await _sharedPrefServices!.getFacilityId();
      String querisParam = "?PageNumber=${pageNumber}&PageSize=${10}&FacilityId=$facilityId&SortBy=$sortBy&SortOrder=$sortOrder&"
          "SearchParam=${searchParam??''}&PayerIds=${payerIds??''}&FilterBy=$filterBy&PatientStatus=${patientStatus??''}";
      Response? res = await dio?.dio?.get(PatientsController.getPatientsForDashboard+querisParam);
      if(res?.statusCode == 200){
        patientsForDashboard = PatientsForDashboard.fromJson(res!.data);
        return patientsForDashboard;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

    }

    Future<dynamic>patientServicesummary({int? month, int? year,}) async{
      try{
        int facilityId = await _sharedPrefServices!.getFacilityId();
        int currentUserId = await _sharedPrefServices!.getCurrentUserId();
        Response? res = await dio?.dio?.get(PatientsController.patientServiceSummary+"/?facilityUserId=$facilityId&facilityUserId=$currentUserId&Month=$month&Year=$year");
        if(res?.statusCode == 200){
          return DashboardPatientSummary.fromJson(res?.data);
        }else{
          return null;
        }
      }catch(e){
        return null;
      }
    }

  getHangfireToken()async{
      String? token = await _sharedPrefServices!.getShortToken();
      if(token == null){
        Response? res = await dio?.dio?.post(AccountApi.hangfireToken,data: {});
        if(res?.statusCode == 200){
          _sharedPrefServices!.setShortToken(res?.data["bearerToken"]??null);
        }
      }
    }

}