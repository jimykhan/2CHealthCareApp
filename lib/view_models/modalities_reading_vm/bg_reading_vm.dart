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
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int timePeriodSelect = 0;
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
    selectedDay1 = selectedDay;
    focusedDay1 = focusedDay;
    notifyListeners();
  }

  onPageChanged(focusedDay) {
    // No need to call `setState()` here
    focusedDay1 = focusedDay;
    notifyListeners();
  }

  selectRange(start, end, focusedDay) {
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
      selectedMonth = time.month;
      selectedYear = time.year;
      // getBGReading();
    }
    return true;
  }
  onFormatChanged(format){}

  getBGReading()async{
    int id  = await _authService!.getCurrentUserId();
    var res = await _bGReadingService?.getBGReading(currentUserId: id,
        month: selectedMonth,year: selectedYear);
    if(res is List){
      bPReadings = [];
      res.forEach((element){
        bPReadings.add(element);
      });
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