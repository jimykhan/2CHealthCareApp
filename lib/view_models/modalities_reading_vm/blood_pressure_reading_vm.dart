import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/reading_services/blood_pressure_reading_service.dart';
class BloodPressureReadingVM extends ChangeNotifier{
  int timePeriodSelect = 0;
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  List<BloodPressureReadingModel> bPReadings = [];
  bool bPReadingLoading = true;
  /// Calendar work start from there
  CalendarFormat? calendarFormat ;
  // DateTime? focusedDay1 = DateTime.now();
  DateTime? focusedDay1 ;
  DateTime? selectedDay1;
  RangeSelectionMode? rangeSelectionMode;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  bool headerDisable = false;
  double dayHeight = 1;
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
        calendarFormat = CalendarFormat.month;
        dayHeight =52;
        headerDisable = false;
      }
      else if(index == 1){
        calendarFormat = CalendarFormat.week;
        dayHeight =1;
        headerDisable = true;
      }
      else if(index == 2){
        calendarFormat = CalendarFormat.month;
        dayHeight =1;
        headerDisable = true;
      }

      notifyListeners();
    }

  }

  onDaySelected(selectedDay, focusedDay){
    print("onDaySelected call");
    selectedDay1 = selectedDay;
    focusedDay1 = focusedDay;
    notifyListeners();
  }

  onPageChanged(focusedDay) {
    print("onPageChanged call");
  // No need to call `setState()` here
  focusedDay1 = focusedDay;
  notifyListeners();
  }

  selectRange(start, end, focusedDay) {
    print("selectRange call");
      selectedDay1 = null;
      focusedDay = focusedDay;
      rangeStart = start;
      rangeEnd = end;
      rangeSelectionMode = RangeSelectionMode.toggledOn;
      notifyListeners();
  }

  bool selectDayPredict(dar){
    DateTime time = DateTime.parse(dar.toString());
    if(time.month != selectedMonth){
      print("month change");
      selectedMonth = time.month;
      selectedYear = time.year;
      // getBloodPressureReading();
    }
    return true;
  }
  onFormatChanged(format){
    print("onFormatChanged call");
  }

  getBloodPressureReading()async{
    int id  = await _authService!.getCurrentUserId();
    var res = await _bloodPressureReadingService?.getBloodPressureReading(currentUserId: id,
    month: selectedMonth,year: selectedYear);
    if(res is List){
      bPReadings = [];
      res.forEach((element){
        bPReadings.add(element);
      });
      // notifyListeners();
      setBPReadingLoading(false);

    }
    setBPReadingLoading(false);

  }

  setBPReadingLoading(bool f){
    bPReadingLoading = f;
    notifyListeners();
  }

}