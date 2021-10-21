import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
class BloodPressureReadingVM extends ChangeNotifier{
  int timePeriodSelect = 0;
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

  ProviderReference? _ref;
  BloodPressureReadingVM({ProviderReference? ref}){
    _ref = ref;
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
    return false;
  }
  onFormatChanged(format){

  }

}