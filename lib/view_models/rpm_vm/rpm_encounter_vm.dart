import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/rpm_services/bg_reading_service.dart';
import 'package:twochealthcare/services/rpm_services/blood_pressure_reading_service.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/util/conversion.dart';
import 'package:twochealthcare/view_models/rpm_vm/tab_and_calender_vm.dart';
class RpmEncounterVM extends ChangeNotifier{
  AuthServices? _authService;
  RpmService? _rpmService;
  ProviderReference? _ref;
  TextEditingController? dateController;
  TextEditingController? durationController;
  TextEditingController? notesController;


  RpmEncounterVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _rpmService = _ref!.read(rpmServiceProvider);

  }
  initialState(){
    dateController = TextEditingController();
    durationController = TextEditingController();
    notesController = TextEditingController();
  }



  addRpmEncounter()async{
    var data = {
      "id": 0,
      "startTime": "string",
      "endTime": "string",
      "duration": "string",
      "encounterDate": "2022-03-28T08:47:42.887Z",
      "note": "string",
      "patientId": 0,
      "facilityUserId": 0,
      "billingProviderId": 0,
      "rpmServiceType": 0,
      "isProviderRpm": true
    };
    var response =  await _rpmService?.addRpmEncounter(data);
    if(response == null){

    }
    else{

    }

  }


}