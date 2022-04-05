import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/models/facility_user_models/FacilityUserListModel.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';

class CcmEncounterVM extends ChangeNotifier{
  AuthServices? _authService;
  RpmService? _rpmService;
  ProviderReference? _ref;
  TextEditingController? durationController;
  TextEditingController? notesController;
  TextEditingController? endTimeController;
  TextEditingController? startTimeController;
  CurrentUser? currentUser;
  FacilityUserListModel? selectedBillingProvider;
  //
  DateTime? dateTime;
  bool isFormValid = false;
  bool addEncounterLoader = false;
  String selecteServiceName = 'Other';
  String selecteMonthlyStatus = 'Not Started';
  List<String> monthlyStatuses = ["Not Started","Call not answered","Completed","Partially Completed"];
  List<String> serviceName = ["Discussion with Provider/Patient/Family",
    "e Prescribe","Lab test result discussed with patients",
    "Lab Radiology Orders","Pre Authorization","Referrals","Other"];

  TimeOfDay startTimeOfDay = TimeOfDay.now();
  TimeOfDay endTimeOfDay = TimeOfDay.now();





  CcmEncounterVM({ProviderReference? ref}){

    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _rpmService = _ref!.read(rpmServiceProvider);

  }
  initialState(){
    durationController = TextEditingController();
    notesController = TextEditingController();
    endTimeController = TextEditingController();
    startTimeController = TextEditingController();
    getCurrentUser();
    resetField();
  }
  resetField(){
    dateTime = DateTime.now();
    durationController?.text = "0";
    notesController?.text = "";
    TimeFormat12 starttime12Format = TimeFormat12(timeOfDay: startTimeOfDay, period: startTimeOfDay.period);
    TimeFormat12 endtime12Format = TimeFormat12(timeOfDay: endTimeOfDay, period: endTimeOfDay.period);

    startTimeController?.text = starttime12Format.timeOfDay.hour.toString().padLeft(2,'0')+":"+starttime12Format.timeOfDay.minute.toString().padLeft(2,'0') +
        " ${starttime12Format.dayperiod}";

    endTimeController?.text = endtime12Format.timeOfDay.hour.toString().padLeft(2,'0')+":"+endtime12Format.timeOfDay.minute.toString().padLeft(2,'0')+
        " ${endtime12Format.dayperiod}";
    selecteServiceName = "Other";
    isFormValid = false;
  }

  onMonthlyStatusChange(String? val){
    print("${val}");
    selecteMonthlyStatus = val??"Not Started";
    formValidation("");
    // notifyListeners();
  }
  onServiceNameChange(String? val){
    print("${val}");
    selecteServiceName = val??"Other";
    notifyListeners();
  }

  getCurrentUser()async{
    currentUser = await _authService?.getCurrentUserFromSharedPref();
    selectedBillingProvider = FacilityUserListModel(id: currentUser?.id??0,fullName: currentUser?.fullName??"",
        facilityId: currentUser?.id??0
    );
    notifyListeners();
  }
  formValidation(String value){
    if(durationController!.text.isNotEmpty && selecteMonthlyStatus != "Not Started"){
      isFormValid = true;
    }else{
      isFormValid = false;
    }
    notifyListeners();

  }

  setLoading(check){
    addEncounterLoader = check;
    notifyListeners();
  }



  addCcmEncounter({required int patientId})async{
    setLoading(true);


    var data = {
      "id": 0,
      "startTime": startTimeController?.text??"",
      "endTime": endTimeController?.text??"",
      "encounterDate": dateTime.toString(),
      "note": notesController?.text??"",
      "ccmServiceTypeId": 0,
      "patientId": patientId,
      "careProviderId": selectedBillingProvider?.id??0,
      "ccmMonthlyStatus": 0,
      "isMonthlyStatusValid": true
    };
    print(data);

    // validateUser
    // var response =  await _rpmService?.addRpmEncounter(data);

    // if(response is Response){
    //   if(response.statusCode == 200){
    //     resetField();
    //   }else{
    //
    //   }
    // }
    // else{
    //
    // }
    setLoading(false);
  }




  Future<dynamic> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);

    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime?.hour??0, minute: dateTime?.minute??0)
          : initialTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime == null) return null;
    startTimeOfDay = newTime;
    dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      newTime.hour,
      newTime.minute,
    );
    TimeFormat12 starttime12format = TimeFormat12(timeOfDay: newTime,period: newTime.period);
    startTimeController?.text = starttime12format.timeOfDay.hour.toString().padLeft(2,'0')+":"+starttime12format.timeOfDay.minute.toString().padLeft(2,'0')+ "${starttime12format.dayperiod}";
    int duration = int.parse((durationController?.text == "" || durationController?.text == null) ? '0' : durationController!.text);
    setEndTime(duration: duration,startHour: newTime.hour,startMint: newTime.minute);

    notifyListeners();
    return null;
  }

  setEndTime({required int duration, required int startHour,required int startMint}){
    int endTimeMints = startMint;
    int endTimeHour = startHour;
    if(duration !=0){
      endTimeMints = endTimeMints + duration;
      if(endTimeMints > 60){
        endTimeHour = endTimeHour + (endTimeMints / 60).toInt();
        endTimeMints = (endTimeMints % 60);
      }
    }

    TimeOfDay endTime = TimeOfDay.fromDateTime(DateTime(dateTime!.year,dateTime!.month,dateTime!.day,endTimeHour,endTimeMints));
    TimeFormat12 endtime12format = TimeFormat12(timeOfDay: endTime,period: endTime.period);
    endTimeController?.text = endtime12format.timeOfDay.hour.toString().padLeft(2,'0')+":"+endtime12format.timeOfDay.minute.toString().padLeft(2,'0')+ " ${endtime12format.dayperiod}";
  }

  onDurationChange(String value){
    if(value == null || value == ""){
      value = "0";
    }
    int duration = int.parse(value);
    setEndTime(duration: duration, startHour: startTimeOfDay.hour, startMint: startTimeOfDay.minute);
    formValidation(value);
    notifyListeners();

  }
}


class TimeFormat12{
  TimeOfDay timeOfDay;
  DayPeriod period;
  String dayperiod = " AM";
  TimeFormat12({required this.timeOfDay,required this.period}){
    if(timeOfDay.hour>12){
      dayperiod = " PM";
      timeOfDay = TimeOfDay(hour: timeOfDay.hour - 12, minute: timeOfDay.minute);
    }else{
      if(period == DayPeriod.pm) dayperiod = " PM";
      dayperiod = " AM";
    }
  }
}