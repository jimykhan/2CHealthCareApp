
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/ccm_model/ccm_logs_model.dart';
import 'package:twochealthcare/models/ccm_model/ccm_service_type.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/data_format.dart';

class CcmService{
  ProviderReference? _ref;
  CcmService({ProviderReference? ref}){
    _ref = ref;
  }
  Future<dynamic> addCcmEncounter(var body) async {

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(CcmController.addCCMEncounter,data: body);
      return response;

    }catch(e){
      SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }
  Future<dynamic> EditCcmEncounter(var body) async {

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.put(CcmController.editCcmEncounter,data: body);
      return response;

    }catch(e){
      SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }

  Future<dynamic> getCcmServiceName({required bool isFav}) async {
    try{
      List<CcmServiceType> ccmServiceType = [];
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(CcmController.getCcmServiceTypes+"?isFav=$isFav");
      if(response.statusCode == 200){
        response.data.forEach((element) {
          ccmServiceType.add(CcmServiceType.fromJson(element));
        });
        ccmServiceType.add(CcmServiceType(id: 0,name: "Other"));
        return ccmServiceType;
      }
      return null;

    }catch(e){
      // SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }

  Future<dynamic> getCcmLogsByPatientId({int? patientId,int month = 0, int? year = 0}) async {
    try{
      CcmLogs? ccmlogs;
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.get(CcmController.getCcmEncountersByPatientId+"/${patientId}?monthId=${month}&yearId=${year}");
      if(response.statusCode == 200){
        ccmlogs = CcmLogs.fromJson(response.data);
        ccmlogs.ccmEncountersList?.forEach((element) {
          List duration = element.duration?.split(":")??[];
          int index = 0;
          duration.forEach((element1) {
            if(index == 0){
              int totalHour = int.parse(element1);
              totalHour = totalHour * 60;
              element.durationInMints = element.durationInMints + totalHour;
            }
            if(index == 1){
              int totalMints = int.parse(element1);
              element.durationInMints = element.durationInMints + totalMints;
            }
            index = index+1;
          });



        });
        return ccmlogs;
      }
      return null;

    }catch(e){
      // SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }




}