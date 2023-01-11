import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/rpm_services/bg_reading_service.dart';
import 'package:twochealthcare/services/rpm_services/blood_pressure_reading_service.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/view_models/rpm_vm/tab_and_calender_vm.dart';
class BGReadingVM extends ChangeNotifier{
  double bGMaxLimit = 100;
  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now();
  // int timePeriodSelect = 2;
  List<BGDataModel> bPReadings = [];
  bool bGReadingLoading = true;
  // /// Calendar work start from there
  // CalendarFormat? calendarFormat = CalendarFormat.month;
  // // DateTime? focusedDay1 = DateTime.now();
  // DateTime? focusedDay1 ;
  // DateTime? selectedDay1;
  // RangeSelectionMode? rangeSelectionMode;
  // DateTime? rangeStart;
  // DateTime? rangeEnd;
  // bool headerDisable = true;
  // double dayHeight = 0;
  // bool daysOfWeekVisible = false;
  // // dayHeight =1;
  // // headerDisable = true;
  // // daysOfWeekVisible = false;
  // /// Calendar work start from there


  AuthServices? _authService;
  // BGReadingService? _bGReadingService;
  RpmService? _rpmService;
  TabAndCalenderVM? _tabAndCalenderVM;
  ProviderReference? _ref;

  BGReadingVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _rpmService = _ref!.read(rpmServiceProvider);
    _tabAndCalenderVM = _ref!.read(tabAndCalenderVMProvider);
    _tabAndCalenderVM!.newDateRange.listen((value) {
      if(value.modality == "BG"){
        getBGReading(startDate: value.startDate, endDate: value.endDate);
      }
    });

  }
  initialState({required int readingMonth, required int readingYear}){
    _tabAndCalenderVM!.initialState(readingMonth: readingMonth, readingYear: readingYear,modality: "BG");
    DateTime startDate = DateTime(readingYear,readingMonth,1);
    DateTime endDate = DateTime(readingYear,readingMonth,countMonthDays(year: readingYear,month: readingMonth));
    // timePeriodSelect = 2;
    // focusedDay1 = DateTime(readingYear ,readingMonth);
    // selectedDay1 = DateTime(readingYear,readingMonth);
    // bGReadingLoading = true;

    getBGReading(startDate: startDate,endDate: endDate);
  }


  // changeTimePeriodSelectIndex(int? index){
  //   if(index != timePeriodSelect){
  //     timePeriodSelect = index??0;
  //     if(index == 0){
  //       calendarFormat = CalendarFormat.week;
  //       dayHeight = 40;
  //       headerDisable = false;
  //       daysOfWeekVisible = true;
  //     }
  //     else if(index == 1){
  //       calendarFormat = CalendarFormat.week;
  //       dayHeight = 0;
  //       headerDisable = true;
  //       daysOfWeekVisible = false;
  //       startDate = DateTime(startDate.year,startDate.month,1);
  //       endDate = DateTime(startDate.year,startDate.month,7);
  //       getBGReading();
  //
  //     }
  //     else if(index == 2){
  //       calendarFormat = CalendarFormat.month;
  //       dayHeight =0;
  //       headerDisable = true;
  //       daysOfWeekVisible = false;
  //     }
  //     notifyListeners();
  //   }
  //
  // }
  //
  // onDaySelected(selectedDay, focusedDay){
  //   print("onDaySelected call ${selectedDay} ${focusedDay}");
  //   if (!isSameDay(selectedDay1, selectedDay)) {
  //     selectedDay1 = selectedDay;
  //     focusedDay1 = focusedDay;
  //   }
  //   notifyListeners();
  // }
  //
  // onPageChanged(focusedDay) {
  //   print("onPageChanged call ${focusedDay}");
  //   selectedDay1 = focusedDay;
  //   focusedDay1 = focusedDay;
  //   if(timePeriodSelect == 2){
  //     startDate = selectedDay1!;
  //     endDate = DateTime(selectedDay1!.year,selectedDay1!.month,countMonthDays(year: selectedDay1!.year, month: selectedDay1!.month));
  //     getBGReading();
  //   }
  //
  //
  //
  //   // notifyListeners();
  // }
  //
  // selectRange(start, end, focusedDay) {
  //   print("selected Range call");
  //   print("start date = ${start}");
  //   print("start end = ${end}");
  //   print("focus date = ${focusedDay}");
  //   if(start != null && end == null){
  //     selectedDay1 = null;
  //     focusedDay1 = start;
  //     rangeStart = start;
  //     rangeEnd = start;
  //   }
  //   if(start != null && end != null){
  //     selectedDay1 = null;
  //     focusedDay1 = start;
  //     rangeStart = start;
  //     rangeEnd = end;
  //   }
  //
  //   // rangeSelectionMode = RangeSelectionMode.toggledOn;
  //   notifyListeners();
  // }
  //
  // bool selectDayPredict(day){
  //   DateTime time = DateTime.parse(day.toString());
  //   // if(time.month != selectedMonth){
  //   //
  //   // }
  //   return isSameDay(selectedDay1, day);
  // }
  //
  // onFormatChanged(format){
  //   print("onFormat change ${format}");
  // }

  getBGReading({DateTime? startDate, DateTime? endDate})async{
    int id  = await _authService!.getCurrentUserId();
    setBGReadingLoading(true);
    var res = await _rpmService?.getBGReading(currentUserId: id,
        startDate: startDate,endDate: endDate);
    if(res is List){
      bPReadings = [];
      res.forEach((element){
        bPReadings.add(element);
      });
      bGMaxLimit = _rpmService!.bGMaxLimit;
      // notifyListeners();
      setBGReadingLoading(false);
    }
    else{
      bPReadings = [];
      setBGReadingLoading(false);
    }
    setBGReadingLoading(false);
  }

  setBGReadingLoading(bool f){
    bGReadingLoading = f;
    notifyListeners();
  }

}