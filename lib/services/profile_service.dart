import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
import 'package:twochealthcare/models/profile_models/paitent_care_providers_model.dart';
import 'package:twochealthcare/models/profile_models/state_model.dart';
import 'package:twochealthcare/providers/providers.dart';

class ProfileService{
  ProviderReference? _ref;
  ProfileService({ProviderReference? ref}){
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
        CurrentUserInfo currentUserInfo = CurrentUserInfo.fromJson(response.data);
        return currentUserInfo;

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
        return true;
      }else{
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