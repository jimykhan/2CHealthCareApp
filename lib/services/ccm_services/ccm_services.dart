
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/conversion.dart';

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



}