import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/facility_user_models/FacilityUserListModel.dart';
import 'package:twochealthcare/models/rpm_models/rpm_logs_model.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/facility_user_services/facility_service.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_log_vm.dart';
import 'package:twochealthcare/views/rpm_view/rpm_logs_view.dart';

class RpmEncounterVM extends ChangeNotifier{
  AuthServices? _authService;
  FacilityService? _facilityService;
  RpmLogsVM? _rpmLogsVM;
  RpmService? _rpmService;
  ProviderReference? _ref;
  TextEditingController? dateController;
  TextEditingController? durationController;
  TextEditingController? notesController;
  TextEditingController? passwordController;
  DateTime? dateTime;
  bool isFormValid = false;
  bool addEncounterLoader = false;
  bool checkProviderLoading = false;
  bool isPasswordFieldValid = true;
  bool obscureText = true;
  bool isProviderRpm = false;
  String selecteServiceType = 'Call';
  List<String> serviceType = ["Call","SMS","Physical Interaction"];
  FacilityUserListModel? selectedBillingProvider;
  FacilityUserListModel? selectedDownDownBillingProvider;
  List<FacilityUserListModel> billingProviders = [];
  CurrentUser? currentUser;



  RpmEncounterVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _rpmService = _ref!.read(rpmServiceProvider);
    _facilityService = _ref!.read(facilityServiceProvider);
    _rpmLogsVM = _ref!.read(rpmLogsVMProvider);

  }
  onChangeBillingProvider(dynamic val){
    print("${val}");
    selectedDownDownBillingProvider = val??"";
    notifyListeners();
  }

  initialState({RpmLogModel? rpmEncounter}){
    dateController = TextEditingController();
    durationController = TextEditingController();
    notesController = TextEditingController();
    passwordController = TextEditingController();
    rpmEncounter != null ? null : resetField();
    getCurrentUser(rpmEncounter: rpmEncounter);
    if(rpmEncounter != null){
      dateTime = rpmEncounter.dateTime;
      dateController?.text = rpmEncounter.encounterDate??"";
      durationController?.text = rpmEncounter.durationInMints.toString();
      notesController?.text = rpmEncounter.note??"";
      selecteServiceType = rpmEncounter.rpmServiceTypeString ?? "Call";
      billingProviders.forEach((element) {
        if(rpmEncounter.billingProviderId == element.id){
          selectedBillingProvider = element;
        }
      });
      Future.delayed(Duration(seconds: 1),(){
        notifyListeners();
      });

    }
  }

  onChangePassword(String val){
    if(val.length>1){
      isPasswordFieldValid = true;
    }else{
      isPasswordFieldValid = false;
    }
    notifyListeners();
  }
  fieldValidation(String val){

  }
  resetField(){
    dateController?.text = "";
    durationController?.text = "";
    notesController?.text = "";
    selecteServiceType = "Call";
    isFormValid = false;
  }
  onProviderChange(String? val){

  }
  getCurrentUser({RpmLogModel? rpmEncounter})async{
     currentUser = await _authService?.getCurrentUserFromSharedPref();
    // if(rpmEncounter != null){
      // currentUser = CurrentUser(id: rpmEncounter.facilityUserId??0, fullName: rpmEncounter.facilityUserName??"");
    // }
    selectedBillingProvider = FacilityUserListModel(id: currentUser?.id??0,fullName: currentUser?.fullName??"",
      facilityId: currentUser?.id??0
    );
    selectedDownDownBillingProvider = FacilityUserListModel(id: currentUser?.id??0,fullName: currentUser?.fullName??"",
        facilityId: currentUser?.id??0
    );

    var billingProvidersByFacilityId = await _facilityService?.getBillingProvidersByFacilityId();
    if(billingProvidersByFacilityId != null){
      billingProviders = billingProvidersByFacilityId;
      billingProviders.forEach((provider) {
        if(provider.id == currentUser!.id){
          selectedBillingProvider = provider;
          selectedDownDownBillingProvider = provider;
        }
      });
    }
    notifyListeners();
  }




  setIsProviderRpm(){
    isProviderRpm = !isProviderRpm;
    notifyListeners();
  }

  formValidation(String value){
    if(dateController!.text.isNotEmpty && durationController!.text.isNotEmpty && notesController!.text.isNotEmpty){
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
  setCheckProviderLoading(check){
    checkProviderLoading = check;
    notifyListeners();
  }

  isValidUser()async{
    setCheckProviderLoading(true);
    // FacilityUserListModel? checkBillingProvider;
    // billingProviders.forEach((provider) {
    //   if(provider.lastName == selectedProviderName.split(" ")[1] && provider.lastName == selectedProviderName.split(" ")[1]){
    //     checkBillingProvider = provider;
    //   }
    // });
    var data = {"appUserId": selectedDownDownBillingProvider?.userId??"", "password": passwordController?.text??""};
    print(data);
    bool response =  await _rpmService?.isValidUser(data)??false;
    if(response){
      selectedBillingProvider = selectedDownDownBillingProvider;
      // selectedBillingProvider?.fullName = "${selectedBillingProvider?.firstName} ${selectedBillingProvider?.lastName}";
      Navigator.pop(applicationContext!.currentContext!);
    }
    setCheckProviderLoading(false);
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
      "startTime": "${dateTime?.hour.toString().padLeft(2,'0')}:${dateTime?.minute.toString().padLeft(2,'0')}",
      "endTime": "${endTimeHour.toString().padLeft(2,'0')}:${endTimeMints.toString().padLeft(2,'0')}",
      "duration": "${durationHour.toString().padLeft(2,'0')}:${durationMints.toString().padLeft(2,'0')}",
      "encounterDate": dateController?.text??"",
      "note": notesController?.text??"",
      "patientId": patientId,
      "facilityUserId": currentUser?.id??0,
      "billingProviderId": selectedBillingProvider?.id??0,
      "rpmServiceType": serviceType[0] == selecteServiceType ? 0 : serviceType[1] == selecteServiceType ? 1 : 2,
      "isProviderRpm": isProviderRpm
    };
    print(data);

    // validateUser
    var response =  await _rpmService?.addRpmEncounter(data);

    if(response is Response){
        if(response.statusCode == 200){
          Navigator.pop(applicationContext!.currentContext!);
          _rpmLogsVM?.getRpmLogsByPatientId(patientid: patientId);
        }else{

        }
    }
    else{

    }
    setLoading(false);
  }

  editRpmEncounter({required int patientId, required int rpmEncounterId})async{
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
      "id": rpmEncounterId,
      "startTime": "${dateTime?.hour.toString().padLeft(2,'0')}:${dateTime?.minute.toString().padLeft(2,'0')}",
      "endTime": "${endTimeHour.toString().padLeft(2,'0')}:${endTimeMints.toString().padLeft(2,'0')}",
      "duration": "${durationHour.toString().padLeft(2,'0')}:${durationMints.toString().padLeft(2,'0')}",
      "encounterDate": dateController?.text??"",
      "note": notesController?.text??"",
      "patientId": patientId,
      "facilityUserId": currentUser?.id??0,
      "rpmServiceType": serviceType[0] == selecteServiceType ?  0 : serviceType[1] == selecteServiceType ? 1 : 2,
      "isProviderRpm": isProviderRpm
    };
    print(data);

    // validateUser
    var response =  await _rpmService?.editRpmEncounter(data);

    if(response is Response){
      if(response.statusCode == 200){
        Navigator.pop(applicationContext!.currentContext!);
        _rpmLogsVM?.getRpmLogsByPatientId(patientid: patientId);

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