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
import 'package:twochealthcare/models/rpm_models/pulse_ox_reading_model.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/common_widgets/tap_bar.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/rpm_vm/blood_pressure_reading_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/pulse_ox_reading_vm.dart';
import 'package:twochealthcare/views/rpm_view/readings/compnents/reading_tile.dart';
import 'package:twochealthcare/views/rpm_view/readings/pb_reading_in_table.dart';
import 'package:twochealthcare/views/rpm_view/readings/tab_and_calender.dart';

class PulseOxReading extends HookWidget {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  PulseOxReading(
      {Key? key, required this.selectedYear, required this.selectedMonth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    PulseOxReadingVM bloodOxReadingVM = useProvider(pulseOxReadingVMProvider);
    ApplicationRouteService applicationRouteService =
    useProvider(applicationRouteServiceProvider);

    useEffect(
          () {
        bloodOxReadingVM.bOReadingLoading = true;
        bloodOxReadingVM.initialState(
            readingMonth: selectedMonth, readingYear: selectedYear);
        Future.microtask(() async {});

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        primary: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
          child: CustomAppBar(
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(70),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Pulse Oximetry Reading",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
        body: _body(context, bloodOxReadingVM: bloodOxReadingVM));
  }

  _body(context, {PulseOxReadingVM? bloodOxReadingVM}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                TabAndCalender(),
                bloodOxReadingVM!.pulseOxreadings.length == 0
                    ? NoData()
                    : Column(
                  children: [
                    LineGraph(
                        bloodOxReadingVM: bloodOxReadingVM),
                    pulseOxReadingTable(bloodOxReadingVM.pulseOxreadings,
                    ),
                    ApplicationSizing.verticalSpacer(n: 70),
                  ],
                )
              ],
            ),
            bloodOxReadingVM.bOReadingLoading
                ? AlertLoader()
                : Container(),
          ],
        ),
      ),
    );
  }

  LineGraph({PulseOxReadingVM? bloodOxReadingVM}) {
    List<PulseOxReadingModel> graphData = [];
    bloodOxReadingVM?.pulseOxreadings.forEach((element) {
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
            text: "Pulse Oximetry",
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
            maximum: bloodOxReadingVM!.bloodOxygenMaxLimit + 100,
            minimum: 0,
            interval: 50,
            enableAutoIntervalOnZooming: true,
          ),
          series: <ChartSeries>[
            FastLineSeries<PulseOxReadingModel, String>(
              name: "Systolic",
              enableTooltip: true,
              dataSource: graphData,
              xValueMapper: (PulseOxReadingModel bloodOx, _) =>
              // bloodPressure.measurementDate.substring(0, 9),
              bloodOx.measurementDate,
              yValueMapper: (PulseOxReadingModel bloodOx, _) =>
              bloodOx.bloodOxygen,
              markerSettings: const MarkerSettings(
                  color: Colors.white, isVisible: true, width: 2, height: 2),
              legendIconType: LegendIconType.circle,
              isVisibleInLegend: true,
              color: appColor,
            ),
            FastLineSeries<PulseOxReadingModel, String>(
              name: "Diastolic",
              enableTooltip: true,
              dataSource: graphData,
              xValueMapper: (PulseOxReadingModel bloodOx, _) =>
              // bloodPressure.measurementDate.substring(0, 9),
              bloodOx.measurementDate,
              yValueMapper: (PulseOxReadingModel bloodOx, _) =>
              bloodOx.heartRate,
              markerSettings: const MarkerSettings(
                  color: Colors.white, isVisible: true, width: 2, height: 2),
              legendIconType: LegendIconType.circle,
              isVisibleInLegend: true,
              color: AppBarStartColor,
            ),
          ],
        ));
  }

  pulseOxReadingTable(List<PulseOxReadingModel> pulseOxReading){
    String measureDate = "00 000 00";
    pulseOxReading.sort((a, b) {
      return b.measurementDate!.compareTo(a.measurementDate!);
      // return b.measurementDate.compareTo(a.measurementDate);
    });
    return Container(
      color: Colors.white,
      child: ListView.separated(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            bool showDate = false;
            if(measureDate != pulseOxReading[index].measurementDate!.substring(0, 9)){
              measureDate = pulseOxReading[index].measurementDate!.substring(0, 9);
              showDate = true;
            }
            return ReadingTile(
              time: pulseOxReading[index].measurementDate!,
              reading1: pulseOxReading[index].bloodOxygen?.toStringAsFixed(0)??"",
              reading3: pulseOxReading[index].heartRate?.toStringAsFixed(0)??"",
              unit1: "",
              unit3: "HR",
              date: showDate ? measureDate : null,
            );
          },
          separatorBuilder: (context, index) {
            return ApplicationSizing.verticalSpacer();
          },
          itemCount: pulseOxReading.length),
    );
  }
}
