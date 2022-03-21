import 'package:flutter/cupertino.dart';
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
  ProviderReference? _ref;
  bool loading = false;

  RpmEncounterVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){

  }
  setLoading(check){
    loading = check;
    notifyListeners();
  }

}