import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/reading_services/bg_reading_service.dart';
import 'package:twochealthcare/services/reading_services/blood_pressure_reading_service.dart';
class BGReadingVM extends ChangeNotifier{
  double bGMaxLimit = 100;
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int timePeriodSelect = 2;
  List<BGDataModel> bPReadings = [];
  bool bGReadingLoading = true;
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
  bool daysOfWeekVisible = true;
  /// Calendar work start from there


  AuthServices? _authService;
  BGReadingService? _bGReadingService;
  ProviderReference? _ref;

  BGReadingVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _bGReadingService = _ref!.read(bGReadingServiceProvider);

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
        dayHeight =1;
        headerDisable = true;
        daysOfWeekVisible = false;
      }
      else if(index == 2){
        calendarFormat = CalendarFormat.month;
        dayHeight =1;
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
      getBGReading();
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
      print(day.toString());
      selectedMonth = time.month;
      selectedYear = time.year;
      // getBGReading();
      print("selectDayPredict call");
    }
    return isSameDay(selectedDay1, day);
  }

  onFormatChanged(format){
    print("onFormat change ${format}");
  }

  getBGReading()async{
    int id  = await _authService!.getCurrentUserId();
    setBGReadingLoading(true);
    var res = await _bGReadingService?.getBGReading(currentUserId: id,
        month: selectedMonth,year: selectedYear);
    if(res is List){
      bPReadings = [];
      res.forEach((element){
        bPReadings.add(element);
      });
      bGMaxLimit = _bGReadingService!.bGMaxLimit;
      // notifyListeners();
      setBGReadingLoading(false);

    }
    setBGReadingLoading(false);

  }

  setBGReadingLoading(bool f){
    bGReadingLoading = f;
    notifyListeners();
  }

}