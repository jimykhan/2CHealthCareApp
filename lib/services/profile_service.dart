import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
import 'package:twochealthcare/models/profile_models/paitent_care_providers_model.dart';
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
      Response response = await dio.dio!.get(ApiStrings.GET_PATIENT_BY_ID+"/"+"$currentUserId",
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
      Response response = await dio.dio!.get(ApiStrings.GET_CAREPROVIDERS_BY_PATIENT_ID+"/"+"$currentUserId",
      );
      if(response.statusCode == 200){
        List<PatientCareProvider> careProviders = [];
        if(response.data is List){
          response.data.forEach((item){
            careProviders.add(PatientCareProvider.fromJson(item));
          });
        }
        return careProviders;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }

}