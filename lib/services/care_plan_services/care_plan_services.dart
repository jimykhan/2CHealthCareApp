import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
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
        carePlanModel.satisfactionWithMedicalCare = ((carePlanModel.satisfactionWithMedicalCare ?? 0) /2).round();
        carePlanModel.updatedOn = Jiffy(carePlanModel.updatedOn).format(Strings.dateFormatFullYear);
        carePlanModel.ccmStartedDate = Jiffy(carePlanModel.ccmStartedDate).format(Strings.dateFormatFullYear);
        carePlanModel.currentApprovalUpdatedOn = Jiffy(carePlanModel.currentApprovalUpdatedOn).format(Strings.dateFormatFullYear);
        carePlanModel.lastApprovedDate = Jiffy(carePlanModel.lastApprovedDate).format(Strings.dateFormatFullYear);

        carePlanModel.careCoordinatorNameAbbreviation = [];

        carePlanModel.careCoordinatorName?.forEach((element) {
          int i = 0;
          List name = element.split(" ");
          String abbreviation = "";
          name.forEach((e) {
            if(i==0) abbreviation = "${e.toString().substring(0,1)}";
            if(i==1) abbreviation = "${abbreviation}${e.toString().substring(0,1)}";
            i = i+1;
          });
          carePlanModel.careCoordinatorNameAbbreviation?.add(abbreviation);
        });
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