import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/dashboard_patient_summary.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_home_service.dart';

class FUHomeViewModel extends ChangeNotifier{
  DashboardPatientSummary? dashboardPatientSummary;
  ProviderReference? _ref;
  FUHomeService? fuHomeService;
  int dashboardSummaryMonth = DateTime.now().month;
  int dashboardSummaryYear = DateTime.now().year;
  PatientsForDashboard? patientsForDashboard;
  bool isloading = true;
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
  setLoading(check){
    isloading = check;
    notifyListeners();
  }
  setNewPageLoading(check){
    newPageLoading = check;
    notifyListeners();
  }

  getPatientsForDashboard({int? facilityId,int? filterBy,int? pageNumber,String? patientStatus,
    String? searchParam, String? payerIds,String? sortBy,int? sortOrder}) async{
    if(patientListPageNumber == 1 && !(isloading)) setLoading(true);
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

        setLoading(false);
      setNewPageLoading(false);
    }else{
      setLoading(false);
      setNewPageLoading(false);
    }
  }

  patientServicesummary({int? facilityId,int? month,int? year}) async{
    var res = await fuHomeService?.patientServicesummary(month: dashboardSummaryMonth,year: dashboardSummaryYear);
    if(res!=null && res is DashboardPatientSummary){
      dashboardPatientSummary = res;
      setLoading(false);
    }else{
      setLoading(false);
    }
  }

  // Hangfire() async {
  //   var res = await fuHomeService?.getHangfireToken();
  // }
}