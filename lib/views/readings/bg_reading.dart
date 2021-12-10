import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/calendar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/line_chart.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/bg_reading_vm.dart';
import 'package:twochealthcare/views/readings/bg_reading_in_table.dart';
import 'package:twochealthcare/views/readings/pb_reading_in_table.dart';
import 'package:twochealthcare/common_widgets/tap_bar.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/blood_pressure_reading_vm.dart';

class BGReading extends HookWidget {
  int selectedMonth;
  int selectedYear;
   BGReading({Key? key,required this.selectedMonth,required this.selectedYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BGReadingVM bgReadingVM = useProvider(bGReadingVMProvider);
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);

    useEffect(
      () {
       bgReadingVM.initialState(readingMonth: selectedMonth, readingYear: selectedYear);
        Future.microtask(() async {});
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    EdgeInsets.only(right: ApplicationSizing.convertWidth(10)),
                child: RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                        "assets/icons/home/right-arrow-icon.svg")),
              ),
            ),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Blood Glucose Reading",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
        body: _body(context, bgReadingVM: bgReadingVM));
  }

  _body(context, {required BGReadingVM bgReadingVM}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // ApplicationSizing.verticalSpacer(),
                // TapBar(
                //   selectedIndx: bgReadingVM.timePeriodSelect,
                //   ontap: (val) {
                //     bgReadingVM.changeTimePeriodSelectIndex(val);
                //   },
                // ),
                CustomCalendar(
                  selectedDayPredict: bgReadingVM.selectDayPredict,
                  onDaySelect: bgReadingVM.onDaySelected,
                  formatChange: bgReadingVM.onFormatChanged,
                  onRangeSelect: bgReadingVM.selectRange,
                  calendarFormat: bgReadingVM.calendarFormat,
                  headerDisable: bgReadingVM.headerDisable,
                  dayHeight: bgReadingVM.dayHeight,
                  daysOfWeekVisible: bgReadingVM.daysOfWeekVisible,
                  onPageChanged: bgReadingVM.onPageChanged,
                  selectedDay1: bgReadingVM.selectedDay1,
                  focusedDay1: bgReadingVM.focusedDay1,
                  rangeEnd: bgReadingVM.rangeEnd,
                  rangeStart: bgReadingVM.rangeStart,
                ),
                bgReadingVM.bPReadings.length == 0
                    ? NoData()
                    : Column(
                        children: [
                          LineGraph(context, bgReadingVM: bgReadingVM),
                          bGReadingInTable(
                            bGReadings: bgReadingVM.bPReadings,
                          ),
                          ApplicationSizing.verticalSpacer(n: 70),
                        ],
                      )
              ],
            ),
            bgReadingVM.bGReadingLoading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }

  LineGraph(context, {BGReadingVM? bgReadingVM}) {
    List<BGDataModel> graphData = [];
    bgReadingVM?.bPReadings.forEach((element) {
      graphData.add(element);
    });
    graphData.sort((a, b) {
      return a.measurementDate!.compareTo(b.measurementDate!);
    });
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: ApplicationSizing.convertWidth(15)),
        child: SfCartesianChart(
          margin: EdgeInsets.all(10),
          title: ChartTitle(
            text: "Blood Glucose",
            alignment: ChartAlignment.near,
            textStyle: Styles.PoppinsRegular(),
          ),
          // legend: Legend(
          //   isVisible: true,
          //   position: LegendPosition.bottom,
          //   alignment: ChartAlignment.near,
          // ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: CategoryAxis(
            labelIntersectAction: AxisLabelIntersectAction.rotate45,
            placeLabelsNearAxisLine: true,
            autoScrollingMode: AutoScrollingMode.start,
            desiredIntervals: 5,
            isVisible: false,
          ),
          primaryYAxis: NumericAxis(
            maximum: bgReadingVM!.bGMaxLimit + 100,
            minimum: 0,
            interval: 50,
            enableAutoIntervalOnZooming: true,
          ),
          series: <ChartSeries>[
            AreaSeries<BGDataModel, String>(
              borderGradient: LinearGradient(
                  colors: <Color>[AppBarStartColor, AppBarEndColor],
                  stops: const <double>[0.2, 0.9],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter),

              gradient: LinearGradient(colors: <Color>[
                AppBarStartColor.withOpacity(0.4),
                AppBarEndColor.withOpacity(0.4)],
                  stops: const <double>[0.2, 0.9],
                  end: Alignment.topCenter, begin: Alignment.bottomCenter),
              name: "Blood Glucose",
              enableTooltip: true,
              dataSource: graphData,
              xValueMapper: (BGDataModel bg, _) =>
              // bg.measurementDate.substring(0, 9),
              bg.measurementDate,
              yValueMapper: (BGDataModel bg, _) => bg.bg,
              markerSettings: const MarkerSettings(
                color: Colors.white,
                isVisible: true,
                  width: 2,
                  height: 2
              ),
              legendIconType: LegendIconType.circle,
              isVisibleInLegend: true,
              color: AppBarStartColor,
            ),
          ],
        ));
  }
}
