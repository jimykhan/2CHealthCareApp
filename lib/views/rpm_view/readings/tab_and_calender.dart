import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jiffy/jiffy.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/common_widgets/calendar.dart';
import 'package:twochealthcare/common_widgets/tap_bar.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/rpm_vm/bg_reading_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/tab_and_calender_vm.dart';

class TabAndCalender extends HookWidget {
  TabAndCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabAndCalenderVM tabAndCalender = useProvider(tabAndCalenderVMProvider);
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);

    useEffect(
          () {
        tabAndCalender.CalendarFormatMonth(isDateSet: false);
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
          Container(
            // color: Colors.red,
            child: Stack(
              alignment: Alignment.center,
              children: [
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
                tabAndCalender.dayHeight == 0 ?
                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 5),
                  margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 70)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Jiffy(tabAndCalender.startDate).format(Strings.dateFormat).toString(),
                        style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.fontScale(12),
                          fontWeight: FontWeight.w700
                        ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Text("-",style: Styles.PoppinsRegular(
                                fontSize: ApplicationSizing.fontScale(12),
                                fontWeight: FontWeight.w700
                            ))),
                        Text(Jiffy(tabAndCalender.endDate).format(Strings.dateFormat).toString(),style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.fontScale(12),
                            fontWeight: FontWeight.w700
                        )),
                      ],
                    ),
                  ),
                ) : Container(),
              ],
            ),
          ),
          tabAndCalender.dayHeight != 0 ?
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            padding: EdgeInsets.only(top: 5),
            margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
            child: Container(
              child: Row(
                children: [
                  Text(Jiffy(tabAndCalender.startDate).format(Strings.dateFormat).toString(),
                    style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.fontScale(12),
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Text("-",style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.fontScale(12),
                          fontWeight: FontWeight.w700
                      ))),
                  Text(Jiffy(tabAndCalender.endDate).format(Strings.dateFormat).toString(),style: Styles.PoppinsRegular(
                      fontSize: ApplicationSizing.fontScale(12),
                      fontWeight: FontWeight.w700
                  )),
                ],
              ),
            ),
          ) : Container(),

        ],
      ),
    );
  }

}