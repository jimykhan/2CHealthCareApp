import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/reading_services/blood_pressure_reading_service.dart';
class BloodPressureReadingVM extends ChangeNotifier{
  double bloodPressureMaxLimit = 100;
  int timePeriodSelect = 2;
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  List<BloodPressureReadingModel> bPReadings = [];
  bool bPReadingLoading = true;
  /// Calendar work start from there
  CalendarFormat? calendarFormat = CalendarFormat.month;
  // DateTime? focusedDay1 = DateTime.now();
  DateTime? focusedDay1 ;
  DateTime? selectedDay1;
  RangeSelectionMode? rangeSelectionMode;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  bool headerDisable = true;
  double dayHeight = 0;
  bool daysOfWeekVisible = false;
  /// Calendar work start from there

  AuthServices? _authService;
  BloodPressureReadingService? _bloodPressureReadingService;
  ProviderReference? _ref;

  BloodPressureReadingVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _bloodPressureReadingService = _ref!.read(bloodPressureServiceProvider);

  }
  changeTimePeriodSelectIndex(int? index){
    if(index != timePeriodSelect){
      timePeriodSelect = index??0;
      if(index == 0){
        calendarFormat = CalendarFormat.week;
        dayHeight =40;
        headerDisable = false;
        daysOfWeekVisible = true;
      }
      else if(index == 1){
        calendarFormat = CalendarFormat.week;
        dayHeight =0;
        headerDisable = true;
        daysOfWeekVisible = false;
      }
      else if(index == 2){
        calendarFormat = CalendarFormat.month;
        dayHeight =0;
        headerDisable = true;
        daysOfWeekVisible = false;
      }

      notifyListeners();
    }

  }


  onDaySelected(selectedDay, focusedDay){
    print("onDaySelected call ${selectedDay} ${focusedDay}");
    if (!isSameDay(selectedDay1, selectedDay)) {
      // Call `setState()` when updating the selected day
      selectedDay1 = selectedDay;
      focusedDay1 = focusedDay;
    }

    notifyListeners();
  }

  onPageChanged(focusedDay) {
    print("onPageChanged call ${focusedDay}");
    // No need to call `setState()` here
    // if(!isSameDay(focusedDay1,focusedDay)){
    //   print("day not same");
    // }
    selectedDay1 = focusedDay;
    focusedDay1 = focusedDay;
    if(timePeriodSelect == 2){
      selectedMonth = selectedDay1!.month;
      selectedYear = selectedDay1!.year;
      getBloodPressureReading();
    }



    // notifyListeners();
  }

  selectRange(start, end, focusedDay) {
    print("selected Range call");
    selectedDay1 = null;
    focusedDay1 = focusedDay;
    rangeStart = start;
    rangeEnd = end;
    rangeSelectionMode = RangeSelectionMode.toggledOn;
    notifyListeners();
  }

  bool selectDayPredict(day){
    DateTime time = DateTime.parse(day.toString());

    if(time.month != selectedMonth){

    }
    return isSameDay(selectedDay1, day);
  }

  onFormatChanged(format){
    print("onFormat change ${format}");
  }

  getBloodPressureReading()async{
    int id  = await _authService!.getCurrentUserId();
    setBPReadingLoading(true);
    var res = await _bloodPressureReadingService?.getBloodPressureReading(currentUserId: id,
    month: selectedMonth,year: selectedYear);
    if(res is List){
      print("a list");
      bPReadings = [];
      res.forEach((element){
        bPReadings.add(element);
      });
      bloodPressureMaxLimit = _bloodPressureReadingService!.bloodPressureMaxLimit;
      // notifyListeners();
      setBPReadingLoading(false);
    }else{
      bPReadings = [];
      setBPReadingLoading(false);
    }
    setBPReadingLoading(false);

  }

  setBPReadingLoading(bool f){
    bPReadingLoading = f;
    notifyListeners();
  }

}