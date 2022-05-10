import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/care_plan/CarePlanModel.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';

class CarePlanServices{
  ProviderReference? _ref;
  DioServices? _dioServices;
  AuthServices? _authServices;
  CarePlanServices({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _dioServices = _ref!.read(dioServicesProvider);
  }


  Future<dynamic> getCarePlanByPatientId({int? Id}) async{
    try{
      int patientId = await _authServices!.getCurrentUserId();
      Response response = await _dioServices!.dio!.get(ApiStrings.getCarePlanMasterByPatientId+"/${Id??patientId}");
      if(response.statusCode == 200){
        CarePlanModel carePlanModel = CarePlanModel.fromJson(response.data);
        return carePlanModel;
      }else{
        return null;
      }
    }
    catch(e){
      return null;
    }

  }
}