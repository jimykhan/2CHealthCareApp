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
  TextEditingController? dateController;
  TextEditingController? durationController;
  TextEditingController? notesController;
  TextEditingController? endTimeController;
  TextEditingController? startTimeController;
  DateTime? dateTime;
  bool isFormValid = false;
  bool addEncounterLoader = false;
  String selecteServiceType = 'Call';
  List<String> serviceType = ["Call","Interactive Communication"];
  FacilityUserListModel? selectedBillingProvider;
  List<FacilityUserListModel> billingProviders = [];
  CurrentUser? currentUser;


  CcmEncounterVM({ProviderReference? ref}){
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
    endTimeController = TextEditingController();
    startTimeController = TextEditingController();
    resetField();
    getCurrentUser();
  }
  resetField(){
    dateController?.text = "";
    durationController?.text = "";
    notesController?.text = "";
    endTimeController?.text = "";
    startTimeController?.text = "";
    selecteServiceType = "Call";
    isFormValid = false;
  }
  getCurrentUser()async{
    currentUser = await _authService?.getCurrentUserFromSharedPref();
    selectedBillingProvider = FacilityUserListModel(id: currentUser?.id??0,fullName: currentUser?.fullName??"",
        facilityId: currentUser?.id??0
    );
    // currentUser?.claims?.forEach((element) {
    //   if(element.claimType?.toUpperCase() == "FacilityId".toUpperCase()){
    //     selectedBillingProvider?.facilityId = int.parse("${element.claimValue?? 0}");
    //   }
    // });

    notifyListeners();
  }



  formValidation(String value){
    if(dateController!.text.isNotEmpty && durationController!.text.isNotEmpty && notesController!.text.isNotEmpty){
      isFormValid = true;
    }else{
      isFormValid = false;
    }

  }

  setLoading(check){
    addEncounterLoader = check;
    notifyListeners();
  }



  addRpmEncounter({required int patientId})async{
    setLoading(true);
    int endTimeMints = 0;
    int endTimeHour = 0;
    int durationMints = 0;
    int durationHour = 0;
    int duration = int.parse(durationController?.text??"0");
    String endTime = "";
    if(duration > 60){
      durationHour = (duration / 60).toInt();
      durationMints = duration % 60;
      endTimeMints = durationMints + dateTime!.minute;
      endTimeHour = durationHour + dateTime!.hour;
    }else{
      durationMints = duration;
      endTimeMints = durationMints + dateTime!.minute;
      endTimeHour = durationHour + dateTime!.hour;
    }
    if(endTimeMints > 60){
      endTimeHour = endTimeHour + (endTimeMints / 60).toInt();
      endTimeMints = endTimeMints + (endTimeMints % 60);
    }


    var data = {
      "id": 0,
      "startTime": "string",
      "endTime": "string",
      "encounterDate": "2022-04-04T11:51:55.018Z",
      "note": "string",
      "ccmServiceTypeId": 0,
      "patientId": 0,
      "careProviderId": 0,
      "ccmMonthlyStatus": 0,
      "isMonthlyStatusValid": true
    };
    print(data);

    // validateUser
    var response =  await _rpmService?.addRpmEncounter(data);

    if(response is Response){
      if(response.statusCode == 200){
        resetField();
      }else{

      }
    }
    else{

    }
    setLoading(false);
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;
    dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.timeOfDay.hour,
      time.timeOfDay.minute,
    );
    dateController?.text = dateTime.toString().split(".")[0]+ time.dayperiod;
    notifyListeners();
  }

  Future<dynamic> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return null;
    return newDate;
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
    return TimeFormat12(timeOfDay: newTime,period: newTime.period);
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