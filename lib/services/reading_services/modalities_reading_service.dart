
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';

class ModalitiesReadingService{
  ProviderReference? _ref;
  ModalitiesReadingService({ProviderReference? ref}){
    _ref = ref;
  }

  Future<dynamic> getModalitiesByUserId({int? currentUserId}) async {
    // SharedPrefServices sharePrf = _ref!.read(sharedPrefServiceProvider);

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(ApiStrings.GET_PHDEVICE_DATA_BY_ID+"/"+"$currentUserId",
      );
      if(response.statusCode == 200){
        // sharePrf.setCurrentUser(response.data);
        List<ModalitiesModel> modalities = [];
         response.data.forEach((element) {
           modalities.add(ModalitiesModel.fromJson(element));
         });

        return modalities;

      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }

  }

}