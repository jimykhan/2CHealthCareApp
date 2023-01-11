
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/constants/validator.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/models/rpm_models/pulse_ox_reading_model.dart';
import 'package:twochealthcare/models/rpm_models/rpm_inventory_device_model.dart';
import 'package:twochealthcare/models/rpm_models/rpm_logs_model.dart';
import 'package:twochealthcare/models/rpm_models/weight_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/data_format.dart';

class PhDeviceService{
  DioServices? dio;
  SharedPrefServices? _sharedPrefServices;
  PublishSubject<String> scanBarcode = PublishSubject<String>(sync: true);

  ProviderReference? _ref;

  PhDeviceService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    dio = _ref?.read(dioServicesProvider);
    _sharedPrefServices = _ref?.read(sharedPrefServiceProvider);
  }


  Future<dynamic> getPhInventoryDevicesByFacilityId({bool inhand = true, bool issued = false}) async {
    try{
      int facilityId = await _sharedPrefServices?.getFacilityId()??-1;
      List<RpmInventoryDeviceModel> rpmInventoryDevice = [];
      Response? response = await dio?.dio?.get(PhdDeviceController.GetRpmInventoryDevices+"?facilityId=$facilityId&inHand=$inhand&issued=$issued");
      if(response?.statusCode == 200){
        response?.data.forEach((element) {
          rpmInventoryDevice.add(RpmInventoryDeviceModel.fromJson(element));
        });
        return rpmInventoryDevice;
      }
      return null;

    }catch(e){
      // SnackBarMessage(message: e.toString(),error: true);
      return null;
    }

  }

  Future<String> checkUnbilledDeviceConfigClaimByPatientId() async {
    try{
      int patientId = await _sharedPrefServices?.getCurrentViewPatientId()??-1;
      Response? response = await dio?.dio?.get(PhdDeviceController.CheckUnbilledDeviceConfigClaim+"/$patientId");
      if(response?.statusCode == 200){
        return response?.data['message'];
      }
      return "";

    }catch(e){
      // SnackBarMessage(message: e.toString(),error: true);
      return "";
    }

  }

  Future<dynamic> assignDeviceToPatient(bool cpt99453,int phDeviceId) async {
    try{

      int patientId = await _sharedPrefServices?.getCurrentViewPatientId()??-1;
      var body ={
        "patientId": patientId,
        "phDeviceId": phDeviceId,
        "cpT99453": cpt99453,
      };
      Response? response = await dio?.dio?.put(PhdDeviceController.AssignDeviceToPatient,data: body);
      if(response?.statusCode == 200){
        Navigator.pop(applicationContext!.currentContext!);
        return null;
      }
      return "";

    }catch(e){
      // SnackBarMessage(message: e.toString(),error: true);
      return "";
    }

  }



}