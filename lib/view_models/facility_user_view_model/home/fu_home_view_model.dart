import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_home_service.dart';

class FUHomeViewModel extends ChangeNotifier{
  ProviderReference? _ref;
  FUHomeService? fuHomeService;
  PatientsForDashboard? patientsForDashboard;
  bool loadingPatientList = true;
  bool newPageLoading = false;
  int patientListPageNumber = 1;
  ScrollController scrollController = ScrollController();
  FUHomeViewModel({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    fuHomeService = _ref!.read(fuHomeServiceProvider);
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
       getPatientsForDashboard();
      }
    });
  }
  setLoadingPatientList(check){
    loadingPatientList = check;
    notifyListeners();
  }
  setNewPageLoading(check){
    newPageLoading = check;
    notifyListeners();
  }
  getPatientsForDashboard({int? facilityId,int? filterBy,int? pageNumber,String? patientStatus,
    String? searchParam, String? payerIds,String? sortBy,int? sortOrder}) async{
    if(patientListPageNumber == 1 && !(loadingPatientList)) setLoadingPatientList(true);
    if(patientListPageNumber>1) setNewPageLoading(true);
    var res = await fuHomeService?.getPatientsForDashboard(pageNumber: patientListPageNumber);
    if(res!=null){
      PatientsForDashboard newPList = res as PatientsForDashboard;
      if(newPList != null && newPList.patientsList!.isNotEmpty){
        if(patientListPageNumber == 1){
          patientsForDashboard = newPList;
          patientListPageNumber++;
        }else{
          patientsForDashboard!.patientsList!.addAll(newPList.patientsList??[])  ;
          patientListPageNumber++;
        }

      }

        setLoadingPatientList(false);
      setNewPageLoading(false);
    }else{
      setLoadingPatientList(false);
      setNewPageLoading(false);
    }
  }
}