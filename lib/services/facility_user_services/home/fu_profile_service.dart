import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/facility_user_models/fu_profile_models/fu_profile_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class FUProfileService{
  ProviderReference? _ref;
  DioServices? dio;
  AuthServices? _authServices;
  SharedPrefServices? _sharedPrefServices;
  FUProfileService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    dio = _ref!.read(dioServicesProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
    _authServices = _ref!.read(authServiceProvider);
  }

  Future<dynamic>getFuProfileInfo()async{

    FUProfileModel? fuProfileModel;
    try{
      int facilityId = await _authServices!.getCurrentUserId();
      Response? res = await dio?.dio?.get(FacilityController.getFacilityUser+"/$facilityId");
      if(res?.statusCode == 200){
        fuProfileModel = FUProfileModel.fromJson(res!.data);
        return fuProfileModel;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

  }

}