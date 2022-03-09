import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_home_service.dart';

class ChronicCareVM extends ChangeNotifier{
  /// all patient of all care providers
  int careProviderId = 0;
  ProviderReference? _ref;
  FUHomeService? fuHomeService;
  int serviceMonth = DateTime.now().month;
  int serviceYear = DateTime.now().year;
  bool isloading = true;
  bool newPageLoading = false;
  int patientListPageNumber = 1;
  PatientsForDashboard? chronicCarePatients;
  ScrollController scrollController = ScrollController();
  Timer? _onSearchDelay;
  ChronicCareVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    fuHomeService = _ref!.read(fuHomeServiceProvider);
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        getPatients2();
      }
    });
  }

  setCareProviderFilter(int Id){
    if(Id != careProviderId){
      Navigator.pop(applicationContext!.currentContext!);
      careProviderId = Id;
      getPatients2();
    }

  }
  setLoading(check){
    isloading = check;
    notifyListeners();
  }
  setNewPageLoading(check){
    newPageLoading = check;
    notifyListeners();
  }

  onSearch(val){
    if (_onSearchDelay?.isActive ?? false) _onSearchDelay?.cancel();
    _onSearchDelay = Timer(const Duration(seconds: 2), () {
      print("call when change finish for 2 seconds${val}");
      patientListPageNumber = 1;
      chronicCarePatients = null;
      getPatients2(searchParam: val);

    });
  }

  getPatients2({int? facilityId,int? filterBy,int? pageNumber,String? patientStatus,
    String? searchParam, String? payerIds,String? sortBy,int? sortOrder}) async{

    if(patientListPageNumber == 1 && !(isloading)) setLoading(true);
    if(patientListPageNumber>1) setNewPageLoading(true);

    var res = await fuHomeService?.getPatients2(pageNumber: patientListPageNumber,
        searchParam: searchParam, serviceMonth: serviceMonth, serviceYear: serviceYear,
    careProviderId: careProviderId);
    if(res!=null){
      PatientsForDashboard newPList = res as PatientsForDashboard;
      if(newPList != null && newPList.patientsList!.isNotEmpty){
        if(patientListPageNumber == 1){
          chronicCarePatients = newPList;
          patientListPageNumber++;
        }else{
          chronicCarePatients!.patientsList!.addAll(newPList.patientsList??[])  ;
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

}