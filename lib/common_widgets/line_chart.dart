import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:twochealthcare/util/application_colors.dart';
enum ChartType{
  bloodPressure,
  bloodGlucose,
  weight
}
class LineChart extends StatelessWidget {
  ChartType chartType;
  var graphData;
   LineChart({Key? key,required this.chartType,this.graphData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return grp();
  }

  // bPChartSeries(){
  //   return <ChartSeries>[
  //     FastLineSeries<BloodPressureData, String>(
  //       name: "Systolic",
  //       enableTooltip: true,
  //       dataSource: rpmDeviceData.bloodPressureData,
  //       xValueMapper: (BloodPressureData bloodPressure, _) =>
  //           bloodPressure.measurementDate.substring(0, 9),
  //       yValueMapper: (BloodPressureData bloodPressure, _) =>
  //       bloodPressure.highPressure,
  //       markerSettings: MarkerSettings(
  //         color: Colors.white,
  //         isVisible: true,
  //       ),
  //       legendIconType: LegendIconType.circle,
  //       isVisibleInLegend: true,
  //       color: AppBarStartColor,
  //     ),
  //     FastLineSeries<BloodPressureData, String>(
  //       name: "Diastolic",
  //       enableTooltip: true,
  //       dataSource: rpmDeviceData.bloodPressureData,
  //       xValueMapper: (BloodPressureData bloodPressure, _) =>
  //           bloodPressure.measurementDate.substring(0, 9),
  //       yValueMapper: (BloodPressureData bloodPressure, _) =>
  //       bloodPressure.lowPressure,
  //       markerSettings: MarkerSettings(
  //         color: Colors.white,
  //         isVisible: true,
  //         // width: 5,
  //         // height: 5
  //         // borderWidth: 1
  //       ),
  //       legendIconType: LegendIconType.circle,
  //       color: appColor,
  //
  //       // dataLabelSettings: DataLabelSettings(
  //       //     isVisible: true,
  //       //     //useSeriesColor: true
  //       // ),
  //       isVisible: true,
  //       // emptyPointSettings: EmptyPointSettings(
  //       //   color: Colors.red,
  //       //   borderWidth: 2,
  //       //   borderColor: Colors.blue,
  //       //   mode: EmptyPointMode.average
  //       // ),
  //       // width: 1
  //     ),
  //   ];
  // }
  grp(){
    String SeriesName;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
      ),
        child: SfCartesianChart(
          // Initialize category axis
          //   primaryXAxis: CategoryAxis(),
          // title: ChartTitle(
          //   text: "CGM",
          //   alignment: ChartAlignment.near,
          // ),
          // legend: Legend(
          //   isVisible: true,
          //   position: LegendPosition.bottom,
          //   alignment: ChartAlignment.near,
          // ),

          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: CategoryAxis(
              labelIntersectAction: AxisLabelIntersectAction.rotate90,
              // placeLabelsNearAxisLine: true,
              // autoScrollingMode: AutoScrollingMode.start,
              // plotOffset: ,
              maximumLabels: 3,
              desiredIntervals: 3,
              visibleMinimum: 0.0,
              // interval: 2,
              // arrangeByIndex: true ,
              //   visibleMaximum: 8,
              // minorTicksPerInterval: 15,
              // autoScrollingDelta: 10,
              // crossesAt: 12,
              majorGridLines: const MajorGridLines(
                  color: Colors.transparent
              )
          ),
          primaryYAxis: NumericAxis(
            maximum: 300,
            minimum: 0,
            interval: 50,
            enableAutoIntervalOnZooming: true,
          ),
          series: <ChartSeries>[
            AreaSeries<SalesData, String>(
              name: "CGM",
              enableTooltip: true,
              dataSource:  <SalesData>[
                SalesData('Jan', 0),
                SalesData('Feb', 28),
                SalesData('Mar', 34),
                SalesData('Apr', 32),
                SalesData('May', 23),
                SalesData('May5', 3),
                SalesData('May4', 43),
                SalesData('May3', 50),
                SalesData('May1', 0),
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              opacity: 0.6,

              markerSettings: MarkerSettings(
                color: appColor,
                isVisible: true,
                // width: 5,
                // height: 5
                // borderWidth: 1
              ),
              legendIconType: LegendIconType.circle,
              // color: appColor.withOpacity(0.3),
              borderWidth: 2,

              // dataLabelSettings: DataLabelSettings(
              //     isVisible: true,
              //     //useSeriesColor: true
              // ),
              isVisible: true,
              borderGradient: LinearGradient(
                  colors: <Color>[AppBarStartColor, AppBarEndColor],
                  stops: <double>[0.2, 0.9],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter),
              gradient: LinearGradient(
                  colors: <Color>[
                    AppBarStartColor.withOpacity(0.4),
                    AppBarEndColor.withOpacity(0.4)
                  ],
                  stops: <double>[
                    0.2,
                    0.9
                  ],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter),
              // emptyPointSettings: EmptyPointSettings(
              //   color: Colors.red,
              //   borderWidth: 2,
              //   borderColor: Colors.blue,
              //   mode: EmptyPointMode.average
              // ),
              // width: 1
            ),
          ],

          // series: <LineSeries<SalesData, String>>[
          //   LineSeries<SalesData, String>(
          //     // Bind data source
          //       dataSource:  <SalesData>[
          //         SalesData('Jan', 35),
          //         SalesData('Feb', 28),
          //         SalesData('Mar', 34),
          //         SalesData('Apr', 32),
          //         SalesData('May', 40)
          //       ],
          //       xValueMapper: (SalesData sales, _) => sales.year,
          //       yValueMapper: (SalesData sales, _) => sales.sales
          //   )
          // ]
        )
    );
  }


}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
class BloodPressureData{

}