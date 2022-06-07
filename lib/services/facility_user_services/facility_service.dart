import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/facility_user_models/FacilityUserListModel.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/dashboard_patient_summary.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/facility_user_models/facilityModel/facility_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'dart:core';

import '../../models/facility_user_models/fu_profile_models/fu_profile_model.dart';

class FacilityService{
  ProviderReference? _ref;
  DioServices? dio;
  SharedPrefServices? _sharedPrefServices;
  LoginVM? _loginVM;
  AuthServices? _authServices;
  FacilityService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    dio = _ref!.read(dioServicesProvider);
    _loginVM = _ref!.read(loginVMProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
    _authServices = _ref!.read(authServiceProvider);
  }

  Future<dynamic>getFuProfileInfo({int? Id})async{
    FUProfileModel? fuProfileModel;
    try{
      int facilityId = await _authServices!.getCurrentUserId();
      Response? res = await dio?.dio?.get(FacilityController.getFacilityUser+"/${Id ?? facilityId}");
      if(res?.statusCode == 200){
        fuProfileModel = FUProfileModel.fromJson(res!.data);
        if(fuProfileModel.countryCallingCode != null || fuProfileModel.countryCallingCode == ""){
          fuProfileModel.phoneNoWithCountryCallingCode = "(${fuProfileModel.countryCallingCode}) ${fuProfileModel.phoneNo}";
        }
        return fuProfileModel;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

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
        patientsForDashboard.patientsList?.forEach((element) {
          if(element.dateOfBirth != null ){
            element.age = findAgeInYears(dateOfBirht: element.dateOfBirth!);
          }
          if(element.lastAppLaunchDate !=null){
            DateTime currentDate = DateTime.now();
            final lastLoginDate = DateTime.parse(element.lastAppLaunchDate!);
            int difference = currentDate.difference(lastLoginDate).inDays;
            if(difference<30){
              element.isActve = true;
            }
          }else{
            element.isActve = false;
          }

        });
        return patientsForDashboard;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

    }
  //api.healthforcehub.link/api/Patients/GetPatients2?PageNumber=1&PageSize=10&
  // CustomListId=0&PatientStatus=1&Assigned=0&RpmStatus=-1&
  // CcmStatus=&CcmMonthlyStatus=&profileStatus=0&FacilityUserId=11&FacilityId=1
  // &CareProviderId=0&BillingProviderId=0&SortBy=&SortOrder=0&SearchParam=&ServiceMonth=4
  // &ConsentDate=0&DiseaseIds=&ModifiedDate=0&ServiceYear=2022&FilterBy=1&ccmTimeRange=3,4,5,6,7
  // &DateAssignedFrom=&DateAssignedTo=

  Future<dynamic>getPatients2({int filterBy = 1,required int pageNumber,int patientStatus = 1,
    int assigned = 0,int rpmStatus = -1,String? ccmStatus,String? ccmMonthlyStatus,int careProviderId = 0,
    int billingProviderId = 0,int careFacilitatorId = 0, String? searchParam,
    required int serviceMonth, required int serviceYear,int consentDate = 0,
    int modefiedDate =0,String? diseaseIds,int customeListId = 0,
    String? dateAssignedFrom,String? dateAssignedTo,String? sortBy,int sortOrder=0,String? ccmTimeRange ="0"})async{

    PatientsForDashboard? patientsForDashboard;
    try{
      int pageSize = 10;
      int facilityId = await _sharedPrefServices!.getFacilityId();
      int facilityUserId = await _sharedPrefServices!.getCurrentUserId();
      int _careProviderId = careProviderId == 0 ? careProviderId : facilityUserId;
      String querisParam = "?PageNumber=$pageNumber&PageSize=$pageSize&PatientStatus=$patientStatus"
          "&Assigned=$assigned&RpmStatus=$rpmStatus"
          "&CcmStatus=${ccmStatus??""}&CcmMonthlyStatus=${ccmMonthlyStatus??""}&SearchParam=${searchParam??''}&FilterBy=$filterBy"
          "&CareProviderId=$_careProviderId"
          "&BillingProviderId=$billingProviderId&CareFacilitatorId=$careFacilitatorId&FacilityUserId=$facilityUserId&FacilityId=$facilityId"
          "&ServiceMonth=$serviceMonth&ServiceYear=$serviceYear&ConsentDate=$consentDate"
          "&ModifiedDate=$modefiedDate&DiseaseIds=${diseaseIds??""}&CustomListId=$customeListId"
          "&DateAssignedFrom=${dateAssignedFrom??""}&DateAssignedTo=${dateAssignedTo??""}&"
          "SortBy=${sortBy??""}&SortOrder=$sortOrder&ccmTimeRange=$ccmTimeRange";
      Response? res = await dio?.dio?.get(PatientsController.getPatients2+querisParam);
      if(res?.statusCode == 200){
        patientsForDashboard = PatientsForDashboard.fromJson(res!.data);
        patientsForDashboard.patientsList?.forEach((element) {
          if(element.dateOfBirth != null ){
            element.age = findAgeInYears(dateOfBirht: element.dateOfBirth!);
          }
          if(element.lastAppLaunchDate !=null){
            DateTime currentDate = DateTime.now();
            final lastLoginDate = DateTime.parse(element.lastAppLaunchDate!);
            int difference = currentDate.difference(lastLoginDate).inDays;
            if(difference<30){
              element.isActve = true;
            }
          }else{
            element.isActve = false;
          }

        });
        return patientsForDashboard;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

  }

    Future<dynamic> patientServicesummary({required int facilityId, int? month, int? year,}) async{
      try{
        int currentUserId = await _sharedPrefServices!.getCurrentUserId();
        // int currentUserId = 0;
        Response? res = await dio?.dio?.get(PatientsController.patientServiceSummary+"/?facilityId=$facilityId&facilityUserId=$currentUserId&Month=$month&Year=$year");
        if(res?.statusCode == 200){
          return DashboardPatientSummary.fromJson(res?.data);
        }else{
          return null;
        }
      }catch(e){
        return null;
      }
    }

    Future<dynamic> getFacilitiesByUserId() async{
      try{
        int currentUserId = await _sharedPrefServices!.getCurrentUserId();
        Response? res = await dio?.dio?.get(FacilityController.getFacilitiesByFacilityUserId+"/$currentUserId");
        if(res?.statusCode == 200){
          List<FacilityModel> facilities = [];
          res?.data.forEach((element) {
            facilities.add(FacilityModel.fromJson(element));
          });
          return facilities;
        }else{
          return null;
        }
      }catch(e){
        return null;
      }
    }

    Future<bool> switchFacility({required int facilityId}) async{
      try{
        int currentUserId = await _sharedPrefServices!.getCurrentUserId();
        var body ={
          "facilityUserId": currentUserId,
          "facilityId": facilityId
      };

        Response? res = await dio?.dio?.post(FacilityController.switchFacility,
        data: body);
        if(res?.statusCode == 200){
          _loginVM?.updateCurrentUser(res?.data);
          return true;
        }else{
          return false;
        }
      }catch(e){
        return false;
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

    Future<dynamic> getBillingProvidersByFacilityId()async{
      try{
        int facilityId = await _sharedPrefServices!.getFacilityId();
        Response? res = await dio?.dio?.get(FacilityController.getBillingProvidersByFacilityId+"/$facilityId");
        if(res?.statusCode == 200){
          List<FacilityUserListModel> facilityUserListModel = [];
          res?.data?.forEach((element) {
            facilityUserListModel.add(FacilityUserListModel.fromJson(element));
          });
          return facilityUserListModel;
        }
        else{
          return null;
        }
      }catch(e){
        return null;
      }
    }

}