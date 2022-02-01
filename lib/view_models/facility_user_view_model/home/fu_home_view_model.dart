import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_home_service.dart';

class FUHomeViewModel extends ChangeNotifier{
  ProviderReference? _ref;
  FUHomeService? fuHomeService;
  PatientsForDashboard? patientsForDashboard;
  FUHomeViewModel({ProviderReference? ref}){
    _ref = ref;
  }
  initService(){
    fuHomeService = _ref!.read(fuHomeServiceProvider);
  }
  getPatientsForDashboard({int? facilityId,int? filterBy,int? pageNumber,String? patientStatus,
    String? searchParam, String? payerIds,String? sortBy,int? sortOrder}){
    var res = fuHomeService?.getPatientsForDashboard();
    if(res!=null){
        patientsForDashboard = res as PatientsForDashboard?;

    }else{

    }
  }
}