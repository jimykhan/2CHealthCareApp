import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/constants/validator.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
import 'package:twochealthcare/models/profile_models/paitent_care_providers_model.dart';
import 'package:twochealthcare/models/profile_models/state_model.dart';
import 'package:twochealthcare/providers/providers.dart';

class PatientProfileService{
  ProviderReference? _ref;
  PatientProfileService({ProviderReference? ref}){
    _ref = ref;
  }

  Future<dynamic> getUserInfo({int? currentUserId}) async {
    // SharedPrefServices sharePrf = _ref!.read(sharedPrefServiceProvider);

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getPatientById+"/"+"$currentUserId",
      );
      if(response.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        PatientInfo patientInfo = PatientInfo.fromJson(response.data);
        if(patientInfo.countryCallingCode != null && patientInfo.countryCallingCode != ""){
          patientInfo.homePhoneCountryCallingCode = "(${patientInfo.countryCallingCode}) ${patientInfo.homePhone}";
        }else{
          patientInfo.homePhoneCountryCallingCode = "${patientInfo.homePhone}";
        }
        patientInfo.emergencyContactSecondaryPhoneNo = mask.getMaskedString(patientInfo.emergencyContactSecondaryPhoneNo??"");
        patientInfo.emergencyContactSecondaryPhoneNo = mask.getMaskedString(patientInfo.emergencyContactSecondaryPhoneNo??"");
        patientInfo.emergencyContactPrimaryPhoneNo = mask.getMaskedString(patientInfo.emergencyContactPrimaryPhoneNo??"");
        patientInfo.emergencyContactRelationship = mask.getMaskedString(patientInfo.emergencyContactRelationship??"");
        patientInfo.personNumber = mask.getMaskedString(patientInfo.personNumber??"");
        if(patientInfo.dateOfBirth != null){
          patientInfo.dateOfBirth = Jiffy(patientInfo.dateOfBirth).format(Strings.dateFormatFullYear);
        }
        if(patientInfo.lastCCMDate != null && patientInfo.lastCCMDate != ""){
          patientInfo.lastCCMDate = Jiffy(patientInfo.lastCCMDate).format(Strings.dateFormatFullYear);
        }
        if(patientInfo.recentPCPAppointment != null && patientInfo.recentPCPAppointment != ""){
          patientInfo.recentPCPAppointment = Jiffy(patientInfo.recentPCPAppointment).format(Strings.dateFormatFullYear);
        }
        if(patientInfo.hospitalizationDate != null && patientInfo.homePhone != ""){
          patientInfo.hospitalizationDate = Jiffy(patientInfo.hospitalizationDate).format(Strings.dateFormatFullYear);
        }
        if(patientInfo.specialists != null ){
          patientInfo.specialists?.forEach((element) {
            if(element.prevAppointment != null && element.prevAppointment != ""){
              element.prevAppointment = Jiffy(element.prevAppointment).format(Strings.dateFormatFullYear);
            }
            if(element.prevAppointment != null && element.prevAppointment != ""){
              element.nextAppointment = Jiffy(element.nextAppointment).format(Strings.dateFormatFullYear);
            }


          });
        }

        return patientInfo;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }

  Future<dynamic> getCareProvider({int? currentUserId}) async {
    // SharedPrefServices sharePrf = _ref!.read(sharedPrefServiceProvider);

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getCareProvidersByPatientId+"/"+"$currentUserId",
      );
      if(response.statusCode == 200){
        List<PatientCareProvider> careProviders = [];
        if(response.data is List){
          response.data.forEach((item){
            careProviders.add(PatientCareProvider.fromJson(item));
          });
          careProviders.forEach((element) {
            if(element.countryCallingCode != null && element.countryCallingCode != ""){
              element.phoneNoWithCountryCallingCode = "(${element.countryCallingCode}) ${element.contactNo}";
            }else{
              element.phoneNoWithCountryCallingCode = "${element.contactNo}";
            }
          });
        }
        return careProviders;

      }
      else if(response.statusCode == 204){
        List<PatientCareProvider> careProviders = [];
        return careProviders;
      }
      else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }

  Future<dynamic> editPatientContactInfo({int? currentUserId, var data}) async {

    // SharedPrefServices sharePrf = _ref!.read(sharedPrefServiceProvider);

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.put(ApiStrings.editPatientProfile,
        data: data
      );
      if(response.statusCode == 200){
        SnackBarMessage(message: response.data??"",error: false);
        return true;
      }else{
        SnackBarMessage(message: response.data??"");
        return false;
      }
    }
    catch(e){
      print(e.toString());
      return false;
    }

  }

  Future<dynamic> getStatesList() async {
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.getStatesList
      );
      if(response.statusCode == 200){
        List<StateModel> stateList = [];
        response.data.forEach((elemet){
          stateList.add(StateModel.fromJson(elemet));
        });
        return stateList;
      }else{
        return false;
      }
    }
    catch(e){
      print(e.toString());
    }

  }

}