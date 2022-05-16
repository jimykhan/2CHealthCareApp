import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/calendar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/line_chart.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/readings/pb_reading_in_table.dart';
import 'package:twochealthcare/common_widgets/tap_bar.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/rpm_vm/blood_pressure_reading_vm.dart';
import 'package:twochealthcare/views/readings/tab_and_calender.dart';

class BloodPressureReading extends HookWidget {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  BloodPressureReading(
      {Key? key, required this.selectedYear, required this.selectedMonth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BloodPressureReadingVM bloodPressureReadingVM =
        useProvider(bloodPressureReadingVMProvider);
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);

    useEffect(
      () {
        bloodPressureReadingVM.bPReadingLoading = true;
        bloodPressureReadingVM.initialState(
            readingMonth: selectedMonth, readingYear: selectedYear);
        Future.microtask(() async {});

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(70)),
          child: CustomAppBar(
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(70),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Blood Pressure Reading",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
        body: _body(context, bloodPressureReadingVM: bloodPressureReadingVM));
  }

  _body(context, {BloodPressureReadingVM? bloodPressureReadingVM}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                TabAndCalender(),
                bloodPressureReadingVM!.bPReadings.length == 0
                    ? NoData()
                    : Column(
                        children: [
                          LineGraph(
                              bloodPressureReadingVM: bloodPressureReadingVM),
                          bpReadingInTable(
                            bPReadings: bloodPressureReadingVM.bPReadings,
                          ),
                          ApplicationSizing.verticalSpacer(n: 70),
                        ],
                      )
              ],
            ),
            bloodPressureReadingVM.bPReadingLoading
                ? AlertLoader()
                : Container(),
          ],
        ),
      ),
    );
  }

  LineGraph({BloodPressureReadingVM? bloodPressureReadingVM}) {
    List<BloodPressureReadingModel> graphData = [];
    bloodPressureReadingVM?.bPReadings.forEach((element) {
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
            text: "Blood Pressure",
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
            maximum: bloodPressureReadingVM!.bloodPressureMaxLimit + 100,
            minimum: 0,
            interval: 50,
            enableAutoIntervalOnZooming: true,
          ),
          series: <ChartSeries>[
            FastLineSeries<BloodPressureReadingModel, String>(
              name: "Systolic",
              enableTooltip: true,
              dataSource: graphData,
              xValueMapper: (BloodPressureReadingModel bloodPressure, _) =>
                  // bloodPressure.measurementDate.substring(0, 9),
                  bloodPressure.measurementDate,
              yValueMapper: (BloodPressureReadingModel bloodPressure, _) =>
                  bloodPressure.highPressure,
              markerSettings: const MarkerSettings(
                  color: Colors.white, isVisible: true, width: 2, height: 2),
              legendIconType: LegendIconType.circle,
              isVisibleInLegend: true,
              color: appColor,
            ),
            FastLineSeries<BloodPressureReadingModel, String>(
              name: "Diastolic",
              enableTooltip: true,
              dataSource: graphData,
              xValueMapper: (BloodPressureReadingModel bloodPressure, _) =>
                  // bloodPressure.measurementDate.substring(0, 9),
                  bloodPressure.measurementDate,
              yValueMapper: (BloodPressureReadingModel bloodPressure, _) =>
                  bloodPressure.lowPressure,
              markerSettings: const MarkerSettings(
                  color: Colors.white, isVisible: true, width: 2, height: 2),
              legendIconType: LegendIconType.circle,
              isVisibleInLegend: true,
              color: AppBarStartColor,
            ),
          ],
        ));
  }
}
