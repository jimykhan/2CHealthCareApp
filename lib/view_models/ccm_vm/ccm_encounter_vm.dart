import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/models/ccm_model/ccm_logs_model.dart';
import 'package:twochealthcare/models/ccm_model/ccm_service_type.dart';
import 'package:twochealthcare/models/facility_user_models/FacilityUserListModel.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/ccm_services/ccm_services.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';

class CcmEncounterVM extends ChangeNotifier{
  AuthServices? _authService;
  CcmService? _ccmService;
  ProviderReference? _ref;
  TextEditingController? dateController;
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
  int ccmmonthlyStatus = 0;
  List<String> monthlyStatuses = ["Not Started","Call not answered","Completed","Partially Completed"];
  List<String> ccmserviceName = ['Other'];
  List<CcmServiceType> ccmServiceType = [];

  TimeOfDay startTimeOfDay = TimeOfDay.now();
  TimeOfDay endTimeOfDay = TimeOfDay.now();

  CcmEncounterVM({ProviderReference? ref}){

    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _ccmService = _ref!.read(ccmServiceProvider);

  }
  initialState({CcmEncountersList? ccmEncounters}) async {
    getCcmServiceType(isEdit : ccmEncounters != null ? true : false );
    dateController = TextEditingController();
    durationController = TextEditingController();
    notesController = TextEditingController();
    endTimeController = TextEditingController();
    startTimeController = TextEditingController();
    ccmEncounters != null ? null : getCurrentUser();
    resetField();
    selecteMonthlyStatus = monthlyStatuses[ccmmonthlyStatus];
    if(ccmEncounters != null){

      // List datePortion = ccmEncounters.encounterDate?.split("/")??[];
      dateTime = ccmEncounters.dateTime;
      dateController?.text = ccmEncounters.encounterDate??"";
      durationController?.text = ccmEncounters.durationInMints.toString();
      notesController?.text = ccmEncounters.note??"";
      endTimeController?.text = ccmEncounters.endTime??"";
      startTimeController?.text = ccmEncounters.startTime??"";
      selecteServiceName = ccmEncounters.ccmServiceType??"";
      selectedBillingProvider = FacilityUserListModel(id: ccmEncounters.careProviderId, fullName: ccmEncounters.careProviderName, facilityId: ccmEncounters.careProviderId);
      currentUser = CurrentUser();
      currentUser?.fullName = selectedBillingProvider?.fullName??"";
      currentUser?.id = selectedBillingProvider?.id??0;
      notifyListeners();

      }
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
    if(val == monthlyStatuses[0]){
      ccmmonthlyStatus = 0;
    }
    if(val == monthlyStatuses[1]){
      ccmmonthlyStatus = 1;
    }
    if(val == monthlyStatuses[2]){
      ccmmonthlyStatus = 2;
    }
    if(val == monthlyStatuses[3]){
      ccmmonthlyStatus = 3;
    }
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
    int ccmServiceTypeId = 0;
    ccmServiceType.forEach((element) {
      if(element.name! == selecteServiceName){
        ccmServiceTypeId = element.id!;
      }
    });

    var data = {
      "id": 0,
      "startTime": startTimeController?.text??"",
      "endTime": endTimeController?.text??"",
      "encounterDate": dateTime.toString(),
      "note": notesController?.text??"",
      "ccmServiceTypeId": ccmServiceTypeId,
      "patientId": patientId,
      "careProviderId": selectedBillingProvider?.id??0,
      "ccmMonthlyStatus": ccmmonthlyStatus,
      "isMonthlyStatusValid": true
    };
    print(data);

    // validateUser
    var response =  await _ccmService?.addCcmEncounter(data);

    if(response is Response){
      if(response.statusCode == 200){
        resetField();
      }
    }
    setLoading(false);
  }

  EditCcmEncounter({required int patientId, required int ccmEncounterId})async{
    setLoading(true);
    int ccmServiceTypeId = 0;
    ccmServiceType.forEach((element) {
      if(element.name! == selecteServiceName){
        ccmServiceTypeId = element.id!;
      }
    });

    var data = {
      "id": ccmEncounterId,
      "startTime": startTimeController?.text??"",
      "endTime": endTimeController?.text??"",
      "encounterDate": dateTime.toString(),
      "note": notesController?.text??"",
      "ccmServiceTypeId": ccmServiceTypeId,
      "patientId": patientId,
      "careProviderId": selectedBillingProvider?.id??0,
      "isMonthlyStatusValid": true
    };
    print(data);

    // validateUser
    var response =  await _ccmService?.EditCcmEncounter(data);

    if(response is Response){
      if(response.statusCode == 200){
        resetField();
      }
    }
    setLoading(false);
  }

  getCcmServiceType({bool isEdit = false})async{
    ccmServiceType = [];
    var response =  await _ccmService?.getCcmServiceName(isFav: false);
    if(response != null && response is List<CcmServiceType>){
      ccmserviceName = [];
      isEdit ? null : selecteServiceName = response[0].name??"Other";
      response.forEach((element) {
        ccmServiceType.add(element);
        if(element.name != null && element.name != ""){
          ccmserviceName.add(element.name!);
          print(element.name);
        }
      });
      notifyListeners();
    }
  }



  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    dateTime = DateTime(
      date.year,
      date.month,
      date.day,
    );
    dateController?.text = dateTime.toString().split(" ")[0];
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