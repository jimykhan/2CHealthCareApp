import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';

class FUHomeService{
  ProviderReference? _ref;
  DioServices? dio;
  FUHomeService({ProviderReference? ref}){
    _ref = ref;
  }
  initService(){
    dio = _ref!.read(dioServicesProvider);
  }

    Future<dynamic>getPatientsForDashboard({int? facilityId,int? filterBy,int? pageNumber,String? patientStatus,String? searchParam,
      String? payerIds,String? sortBy,int? sortOrder})async{

    String querisParam = "?PageNumber=$pageNumber&PageSize=10&FacilityId=$facilityId&SortBy=$sortBy&SortOrder$sortOrder&"
        "SearchParam=$searchParam&PayerIds=$payerIds&FilterBy=$filterBy&PatientStatus=$patientStatus";
    PatientsForDashboard? patientsForDashboard;
    try{
      Response? res = await dio?.dio?.get(PatientsController.getPatientsForDashboard+querisParam);
      if(res?.statusCode == 200){
        patientsForDashboard = PatientsForDashboard.fromJson(res?.data);
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

    }

}