import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:rxdart/rxdart.dart';
class CalenderDate{
   DateTime? startDate;
   DateTime?  endDate;
   CalenderDate({this.startDate,this.endDate});
}
class TabAndCalenderVM extends ChangeNotifier{
  PublishSubject<CalenderDate> newDateRange = PublishSubject<CalenderDate>(sync: true);

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int timePeriodSelect = 2;
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
  // dayHeight =1;
  // headerDisable = true;
  // daysOfWeekVisible = false;
  /// Calendar work start from there

  ProviderReference? _ref;

  TabAndCalenderVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){

  }
  initialState({required int readingMonth, required int readingYear}){
    startDate = DateTime(readingYear,readingMonth,1);
    endDate = DateTime(readingYear,readingMonth,countMonthDays(year: readingYear,month: readingMonth));
    timePeriodSelect = 2;
    focusedDay1 = DateTime(readingYear ,readingMonth);
    selectedDay1 = DateTime(readingYear,readingMonth);
    // bGReadingLoading = true;
    // getBGReading();
  }
  changeTimePeriodSelectIndex(int? index){
    if(index != timePeriodSelect){
      timePeriodSelect = index??0;
      if(index == 0){
        CalendarFormatCustomRange();
      }
      else if(index == 1){
        CalendarFormatWeek();

      }
      else if(index == 2){
        CalendarFormatMonth();
      }

    }

  }
  CalendarFormatMonth({bool isDateSet = true}){
    calendarFormat = CalendarFormat.month;
    dayHeight = 0;
    headerDisable = true;
    daysOfWeekVisible = false;
    if(isDateSet){
      startDate = DateTime.now().subtract(Duration(days: 30));
      endDate = DateTime.now();
    }
    newDateRange.add(CalenderDate(startDate: startDate,endDate: endDate));
  }
  CalendarFormatWeek(){
    calendarFormat = CalendarFormat.week;
    dayHeight = 0;
    headerDisable = true;
    daysOfWeekVisible = false;

    startDate = DateTime.now().subtract(Duration(days: 7));
    endDate = DateTime.now();
    selectedDay1 = DateTime.now();
    focusedDay1 = DateTime.now();
    newDateRange.add(CalenderDate(startDate: startDate,endDate: endDate));
    // getBGReading();
  }
  CalendarFormatCustomRange(){
    calendarFormat = CalendarFormat.week;
    dayHeight = 40;
    headerDisable = false;
    daysOfWeekVisible = true;
    notifyListeners();
  }

  onDaySelected(selectedDay, focusedDay){
    print("onDaySelected call ${selectedDay} ${focusedDay}");
    if (!isSameDay(selectedDay1, selectedDay)) {
      selectedDay1 = selectedDay;
      focusedDay1 = focusedDay;
    }
    notifyListeners();
  }

  onPageChanged(focusedDay) {
    print("onPageChanged call ${focusedDay}");
    selectedDay1 = focusedDay;
    focusedDay1 = focusedDay;
    if(timePeriodSelect == 2){
      startDate = selectedDay1!;
      endDate = DateTime(selectedDay1!.year,selectedDay1!.month,countMonthDays(year: selectedDay1!.year, month: selectedDay1!.month));
      newDateRange.add(CalenderDate(startDate: startDate,endDate: endDate));
      // getBGReading();
    }
    if(timePeriodSelect == 1){
      endDate = focusedDay;
      startDate = focusedDay?.subtract(const Duration(days: 7));
      newDateRange.add(CalenderDate(startDate: startDate,endDate: endDate));
    }



    // notifyListeners();
  }

  selectRange(start, end, focusedDay) {
    print("selected Range call");
    print("start date = ${start}");
    print("start end = ${end}");
    print("focus date = ${focusedDay}");
    if(start != null && end == null){
      selectedDay1 = null;
      focusedDay1 = start;
      rangeStart = start;
      rangeEnd = start;
      notifyListeners();
    }
    if(start != null && end != null){
      selectedDay1 = null;
      focusedDay1 = start;
      rangeStart = start;
      rangeEnd = end;
      startDate = start;
      endDate = end;
      newDateRange.add(CalenderDate(startDate: start,endDate: end));
    }

    // rangeSelectionMode = RangeSelectionMode.toggledOn;

  }

  bool selectDayPredict(day){
    DateTime time = DateTime.parse(day.toString());
    // if(time.month != selectedMonth){
    //
    // }
    return isSameDay(selectedDay1, day);
  }

  onFormatChanged(format){
    print("onFormat change ${format}");
  }


}