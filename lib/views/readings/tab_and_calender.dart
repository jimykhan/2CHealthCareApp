import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/calendar.dart';
import 'package:twochealthcare/common_widgets/tap_bar.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/bg_reading_vm.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/tab_and_calender_vm.dart';

class TabAndCalender extends HookWidget {
  TabAndCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabAndCalenderVM tabAndCalender = useProvider(tabAndCalenderVMProvider);
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);

    useEffect(
          () {

        Future.microtask(() async {});
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Container(
      child: Column(
        children: [
          TapBar(
            selectedIndx: tabAndCalender.timePeriodSelect,
            ontap: (val) {
              tabAndCalender.changeTimePeriodSelectIndex(val);
            },
          ),
          CustomCalendar(
            selectedDayPredict: tabAndCalender.selectDayPredict,
            onDaySelect: tabAndCalender.onDaySelected,
            formatChange: tabAndCalender.onFormatChanged,
            onRangeSelect: tabAndCalender.selectRange,
            calendarFormat: tabAndCalender.calendarFormat,
            headerDisable: tabAndCalender.headerDisable,
            dayHeight: tabAndCalender.dayHeight,
            daysOfWeekVisible: tabAndCalender.daysOfWeekVisible,
            onPageChanged: tabAndCalender.onPageChanged,
            selectedDay1: tabAndCalender.selectedDay1,
            focusedDay1: tabAndCalender.focusedDay1,
            rangeEnd: tabAndCalender.rangeEnd,
            rangeStart: tabAndCalender.rangeStart,
          ),
        ],
      ),
    );
  }

}