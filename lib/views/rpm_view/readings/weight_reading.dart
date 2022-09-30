import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/rpm_models/weight_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/rpm_vm/weight_reading_vm.dart';
import 'package:twochealthcare/views/rpm_view/readings/bg_reading_in_table.dart';
import 'package:twochealthcare/views/rpm_view/readings/compnents/reading_tile.dart';
import 'package:twochealthcare/views/rpm_view/readings/tab_and_calender.dart';

class WeightReading extends HookWidget {
  int selectedMonth;
  int selectedYear;
   WeightReading({Key? key,required this.selectedMonth,required this.selectedYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeightReadingVM weightReadingVM = useProvider(weightReadingVMProvider);
    ApplicationRouteService applicationRouteService =
    useProvider(applicationRouteServiceProvider);

    useEffect(
          () {
            weightReadingVM.initialState(
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
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
          child: CustomAppBar(
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(70),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Weight Reading",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
        body: _body(context, weightReadingVM: weightReadingVM));
  }

  _body(context, {required WeightReadingVM weightReadingVM}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ApplicationSizing.verticalSpacer(),
                TabAndCalender(),
                weightReadingVM.weightReadings.length == 0
                    ? NoData()
                    : Column(
                  children: [
                    LineGraph(context, weightReadingVM: weightReadingVM),
                    weightReadingTable(weightReadingVM.weightReadings),
                    ApplicationSizing.verticalSpacer(n: 70),
                  ],
                )
              ],
            ),
            weightReadingVM.weightReadingLoading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }

  LineGraph(context, {WeightReadingVM? weightReadingVM}) {
    List<WeightReadingModel> graphData = [];
    weightReadingVM?.weightReadings.forEach((element) {
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
            text: "Weight",
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
            maximum: weightReadingVM!.weightMaxLimit + 100,
            minimum: 0,
            interval: 50,
            enableAutoIntervalOnZooming: true,
          ),
          series: <ChartSeries>[
            AreaSeries<WeightReadingModel, String>(
              borderGradient: LinearGradient(
                  colors: <Color>[AppBarStartColor, AppBarEndColor],
                  stops: const <double>[0.2, 0.9],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter),
              gradient: LinearGradient(colors: <Color>[
                AppBarStartColor.withOpacity(0.4),
                AppBarEndColor.withOpacity(0.4)
              ], stops: const <double>[
                0.2,
                0.9
              ], end: Alignment.topCenter, begin: Alignment.bottomCenter),
              name: "Blood Glucose",
              enableTooltip: true,
              dataSource: graphData,
              xValueMapper: (WeightReadingModel w, _) =>
              // bg.measurementDate.substring(0, 9),
              w.measurementDate,
              yValueMapper: (WeightReadingModel w, _) => w.weightValue,
              markerSettings: const MarkerSettings(
                  color: Colors.white, isVisible: true, width: 2, height: 2),
              legendIconType: LegendIconType.circle,
              isVisibleInLegend: true,
              color: AppBarStartColor,
            ),
          ],
        ));
  }

  weightReadingTable(List<WeightReadingModel> weightReadings){
    String measureDate = "00 000 00";
    weightReadings.sort((a, b) {
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
            if(measureDate != weightReadings[index].measurementDate!.substring(0, 9)){
              measureDate = weightReadings[index].measurementDate!.substring(0, 9);
              showDate = true;
            }
            return ReadingTile(
              time: weightReadings[index].measurementDate!,
              reading1: weightReadings[index].weightValue?.toStringAsFixed(1)??"",
              unit1: weightReadings[index].weightUnit??"",
              date: showDate ? measureDate : null,
            );
          },
          separatorBuilder: (context, index) {
            return ApplicationSizing.verticalSpacer();
          },
          itemCount: weightReadings.length),
    );
  }
}
