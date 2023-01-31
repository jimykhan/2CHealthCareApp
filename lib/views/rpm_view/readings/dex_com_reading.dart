import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/common_widgets/tap_bar.dart';
import 'package:twochealthcare/models/rpm_models/dex_com_models/AlertSettings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/rpm_services/cgm_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/rpm_vm/components/pie_chart_widget.dart';
import 'package:twochealthcare/view_models/rpm_vm/dexCom_vm.dart';

class DexcomCGM extends HookWidget {
  String? modality;
  String? title;
  int patientId;

  DexcomCGM({this.modality, this.title,this.patientId = -1});
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final DexComVM dexComVM = useProvider(dexComVMProvider);
    useEffect(() {
      Future.microtask(() async {
        await dexComVM.SetDexcomCGMSelectedRangeType(1,patientId: patientId,modality: modality);
      });
      return () {
        // Dispose Objects here
      };
    }, []);
    return Scaffold(
      primary: false,
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          centerWigets: AppBarTextStyle(
            text: "CGM Reading",
          ),
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
      body: _body(context,dexComVM),
      bottomNavigationBar: BottomSlider(context,dexComVM),
    );
  }

  _body(context, DexComVM dexComVM) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TapBar(ontap: (int? val) {
              if(val == 0){
                dexComVM.SetDexcomCGMSelectedRangeType(0,patientId: patientId, modality: modality);
              }
              else if(val == 1){
                dexComVM.SetDexcomCGMSelectedRangeType(1, modality: modality, patientId: patientId);
              }
              else if(val == 2){
                dexComVM.SetDexcomCGMSelectedRangeType(2,modality: modality,patientId: patientId);
              }
            },selectedIndx: dexComVM.DexcomCGMSelectedRangeType,
                isMonth : false),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   margin: EdgeInsets.symmetric(
            //       horizontal: ApplicationSizing.constSize( 24)),
            //   height: ApplicationSizing.constSize( 30),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(ApplicationSizing.constSize( 5)),
            //     border: Border.all(
            //       color: appColor,
            //       width: 2,
            //     ),
            //   ),
            //   child:
              // child: Row(
              //   children: [
              //     Expanded(
              //       flex: 1,
              //       child: InkWell(
              //         onTap: () {
              //           dexComVM.SetDexcomCGMSelectedRangeType(0,patientId: patientId, modality: modality);
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: dexComVM.DexcomCGMSelectedRangeType == 0
              //                 ? appColor
              //                 : Colors.white,
              //           ),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "WEEKLY",
              //             style: Styles.RobotoMedium(
              //               color:
              //               dexComVM.DexcomCGMSelectedRangeType == 0
              //                   ? Colors.white
              //                   : appColor,
              //               fontSize: ApplicationSizing.constSize( 12),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 1,
              //       child: InkWell(
              //         onTap: () {
              //           dexComVM.SetDexcomCGMSelectedRangeType(
              //             1,
              //             modality: modality,
              //             patientId: patientId
              //           );
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //               color:
              //               dexComVM.DexcomCGMSelectedRangeType == 1
              //                   ? appColor
              //                   : Colors.white,
              //               border: Border(
              //                 right: BorderSide(color: appColor, width: 2),
              //                 left: BorderSide(color: appColor, width: 2),
              //               )),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "14 days".toUpperCase(),
              //             style: Styles.RobotoMedium(
              //               color:
              //               dexComVM.DexcomCGMSelectedRangeType == 1
              //                   ? Colors.white
              //                   : appColor,
              //               fontSize: ApplicationSizing.constSize( 12),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 1,
              //       child: InkWell(
              //         onTap: () {
              //           dexComVM.SetDexcomCGMSelectedRangeType(
              //             2,
              //             modality: modality,
              //             patientId: patientId
              //           );
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: dexComVM.DexcomCGMSelectedRangeType == 2
              //                 ? appColor
              //                 : Colors.white,
              //           ),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "Custom Range".toUpperCase(),
              //             style: Styles.RobotoMedium(
              //               color:
              //               dexComVM.DexcomCGMSelectedRangeType == 2
              //                   ? Colors.white
              //                   : appColor,
              //               fontSize: ApplicationSizing.constSize( 12),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            // ),
            InkWell(
              onTap: () {
                // rpmDeviceData.MultiDatePicker(context,modality: modality,
                //   token: deviceService.currentUser.bearerToken,
                //   patientId: deviceService.currentUser.id,
                // );
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                margin:
                EdgeInsets.symmetric(vertical: ApplicationSizing.constSize( 20)),
                child: Text(
                  "${Jiffy(dexComVM.DexcomCGMDataSelectedDate[0]).yMMMMd} - ${Jiffy(dexComVM.DexcomCGMDataSelectedDate[1]).yMMMMd}",
                  style: Styles.RobotoMedium(
                    fontSize: 13
                  ),

                ),
              ),
            ),
            dexComVM.DexcomCGMSelectedGraphType == 0
                ? DeviceAlertSetting(context, dexComVM: dexComVM)
                : dexComVM.DexcomCGMSelectedGraphType == 1
                ? PieChart(context,
                dexComVM: dexComVM)
                : LineGraph(context,
                dexComVM: dexComVM),
          ],
        ),
      ),
    );
  }

  PieChart(context,
      {required DexComVM dexComVM}) {
    return dexComVM.LoadingDexcomGetStatistics
        ? AlertLoader()
        : Container(
      padding:
      EdgeInsets.symmetric(vertical: ApplicationSizing.constSize( 10)),
      margin: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.constSize( 24)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ApplicationSizing.constSize( 10)),
          boxShadow: [
            BoxShadow(
              color: backGroundColor.withOpacity(0.9),
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ]),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ApplicationSizing.constSize( 15)),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                            "Glucose Overview",
                            style: Styles.RobotoMedium(
                              color: Colors.black,
                              fontSize: ApplicationSizing.constSize(16),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ApplicationSizing.constSize( 5),
                  ),
                  child: Divider(
                    color: disableColor,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                            "Avarage Glucose",
                            style: Styles.RobotoMedium(
                              color: Colors.black,
                              fontSize: ApplicationSizing.constSize(16),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: ApplicationSizing.constSize( 10),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                        "${dexComVM.statisticsData?.mean?.toStringAsFixed(1) ?? 0}",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            32,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " mg/dL",
                        style: Styles.RobotoThin(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            12,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: ApplicationSizing.constSize( 10),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                            "Standard Deviation",
                            style: Styles.RobotoThin(
                              color: Colors.black,
                              fontSize: ApplicationSizing.constSize(12),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: ApplicationSizing.constSize( 10),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                        "${dexComVM.statisticsData?.stdDev?.toStringAsFixed(1) ?? 0}",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            20,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " mg/dL",
                        style: Styles.RobotoThin(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            8,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: ApplicationSizing.constSize( 10),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Time in Range",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            16,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),

          /// Pie chart
          Container(
            // color: Colors.red,
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width,
            height: ApplicationSizing.constSize( 200),
            padding: EdgeInsets.symmetric(
                horizontal: ApplicationSizing.constSize( 10)),
            child: PieChartWiget(
              pieGraphData: [
                PieGraphData(
                    value: dexComVM
                        .statisticsData?.percentAboveRange ==
                        0 ||
                        dexComVM
                            .statisticsData?.percentAboveRange ==
                            0.0
                        ? 0.00001
                        : dexComVM
                        .statisticsData?.percentAboveRange,
                    title: "High",
                    color: Color(0xffff3547)),
                PieGraphData(
                    value: dexComVM.statisticsData
                        ?.percentWithinRange ==
                        0 ||
                        dexComVM.statisticsData
                            ?.percentWithinRange ==
                            0.0
                        ? 0.00001
                        : dexComVM
                        .statisticsData?.percentWithinRange,
                    title: "In Range",
                    color: Color(0xff4eb048)),
                PieGraphData(
                    value: dexComVM
                        .statisticsData?.percentBelowRange ==
                        0 ||
                        dexComVM
                            .statisticsData?.percentBelowRange ==
                            0.0
                        ? 0.00001
                        : dexComVM
                        .statisticsData?.percentBelowRange,
                    title: "Low",
                    color: Color(0xffffbb35)),
                PieGraphData(
                    value: dexComVM
                        .statisticsData?.percentUrgentLow ==
                        0 ||
                        dexComVM
                            .statisticsData?.percentUrgentLow ==
                            0.0
                        ? 0.00001
                        : dexComVM
                        .statisticsData?.percentUrgentLow,
                    title: "Very Low",
                    color: Color(0xff33b5e5)),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ApplicationSizing.constSize( 15)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Sensor Usage",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            16,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: ApplicationSizing.constSize( 10),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                            "Day with CGM data",
                            style: Styles.RobotoThin(
                              color: Colors.black,
                              fontSize: ApplicationSizing.constSize(12),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: ApplicationSizing.constSize( 5),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                        "${dexComVM.statisticsData?.utilizationPercent?.toStringAsFixed(1) ?? 0}",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            20,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " %",
                        style: Styles.RobotoThin(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            12,
                          ),
                        ),
                      ),

                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: ApplicationSizing.constSize( 10)),
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                            "${dexComVM.statisticsData?.nDays ?? 0}/ ${dexComVM.DexcomCGMDataSelectedDate[1].difference(dexComVM.DexcomCGMDataSelectedDate[0]).inDays} days",
                            style: Styles.RobotoThin(
                              color: Colors.black,
                              fontSize:ApplicationSizing.constSize(12),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                            "Avg. calibrations per day",
                            style: Styles.RobotoThin(
                              color: Colors.black,
                              fontSize: ApplicationSizing.constSize(12),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: ApplicationSizing.constSize( 5),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                        "${dexComVM.statisticsData?.meanDailyCalibrations?.toStringAsFixed(1)}",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            20,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LineGraph(context,
      {required DexComVM dexComVM}) {
    return dexComVM.LoadingDexcomGetDevices
        ? AlertLoader()
        : Column(
          children: [
            Container(
            margin: EdgeInsets.symmetric(
                horizontal: ApplicationSizing.convertWidth(15)),
            child: SfCartesianChart(
              margin: EdgeInsets.all(10),
              title: ChartTitle(
                text: "CGM",
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
                maximum: dexComVM.maximumBGRange + 100,
                minimum: 0,
                interval: 50,
                enableAutoIntervalOnZooming: true,
              ),
              series: <ChartSeries>[
                AreaSeries<AvgsData, String>(
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
                  dataSource: dexComVM.listOfAvgsData,
                  xValueMapper: (AvgsData bg, _) =>
                  // bg.measurementDate.substring(0, 9),
                  bg.time,
                  yValueMapper: (AvgsData bg, _) => bg.value,
                  markerSettings: const MarkerSettings(
                      color: Colors.white, isVisible: true, width: 2, height: 2),
                  legendIconType: LegendIconType.circle,
                  isVisibleInLegend: true,
                  color: AppBarStartColor,
                ),
              ],
            )),
            // SizedBox(height: 20,),
            // Container(
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //       physics: ScrollPhysics(),
            //       itemBuilder: (context,index){
            //     return BloodGlocusTile(
            //       reading: dexComVM.listOfAvgsData[index].value!.toInt(),
            //       date: dexComVM.listOfAvgsData[index].time!,
            //       time: "",
            //     );
            //   }, separatorBuilder: (context, index){
            //     return SizedBox(height: 8,);
            //   }, itemCount: dexComVM.listOfAvgsData.length
            //   ),
            // ),
          ],
        );
  }




  DeviceAlertSetting(context, {required DexComVM dexComVM}) {
    return dexComVM.LoadingDexcomGetDevices
        ? AlertLoader()
        : Container(
      margin: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.constSize( 24)),
      padding: EdgeInsets.symmetric(
          vertical: ApplicationSizing.constSize( 10),
          horizontal: ApplicationSizing.constSize( 15)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ApplicationSizing.constSize( 10)),
          boxShadow: [
            BoxShadow(
              color: backGroundColor.withOpacity(0.1),
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ]),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    child: Text(
                      "Dexcom ${dexComVM.dexcomDeivices?.transmitterGeneration ?? "" } Mobile App",
                      style: Styles.RobotoMedium(
                        color: Colors.black,
                        fontSize: ApplicationSizing.constSize(
                          16,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: ApplicationSizing.constSize( 5),
            ),
            child: Divider(
              color: disableColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                    child: Text(
                      "CGMID",
                      style: Styles.RobotoMedium(
                        color: Colors.black,
                        fontSize: ApplicationSizing.constSize(
                          16,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: ApplicationSizing.constSize( 10),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Text(
                        "Serial Number",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            12,
                          ),
                        ),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Text(
                        dexComVM
                            .dexcomDeivices?.displayDevice ??
                            "",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            12,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ApplicationSizing.constSize( 5),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Text(
                        "Uploaded on",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            12,
                          ),
                        ),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Text(
                        dexComVM.dexcomDeivices?.lastUploadDate ??
                            "",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            12,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ApplicationSizing.constSize( 5),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Text(
                        "Model",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            12,
                          ),
                        ),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Text(
                        dexComVM.dexcomDeivices?.transmitterGeneration ??
                            "",
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            12,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),

          ///Alert Setting For Device
          Container(
            margin:
            EdgeInsets.symmetric(vertical: ApplicationSizing.constSize( 10)),
            child: Row(
              children: [
                Container(
                    child: Text(
                      "Alert Setting For Device",
                      style: Styles.RobotoMedium(
                        color: Colors.black,
                        fontSize: ApplicationSizing.constSize(
                          16,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Text(
                        "General",
                        // style: Styles.RobotoMedium(),
                        style: Styles.RobotoMedium(
                          color: Colors.black,
                          fontSize: ApplicationSizing.constSize(
                            16,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ApplicationSizing.constSize( 10),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                AlertSettings alertSetting = dexComVM
                    .dexcomDeivices
                    !.alertScheduleList![0]
                    .alertSettings![index];
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            child: Text(
                              alertSetting.alertName ?? "non",
                              style: Styles.RobotoMedium(
                                color: Colors.black,
                                fontSize: ApplicationSizing.constSize(
                                  12,
                                ),
                              ),
                            )),
                      ),
                      Container(
                          child: Container(
                            alignment: Alignment.center,
                            width: ApplicationSizing.constSize( 35),
                            height: ApplicationSizing.constSize( 20),
                            padding: EdgeInsets.symmetric(
                              // vertical: ApplicationSizing.constSize( 3),
                              // horizontal: ApplicationSizing.constSize( 5)
                            ),
                            decoration: BoxDecoration(
                              color: alertSetting.enabled?? false
                                  ? appColor
                                  : Color(0xffffc107),
                              borderRadius: BorderRadius.circular(
                                  ApplicationSizing.constSize( 10)),
                            ),
                            child: Text(
                              alertSetting.enabled?? false ? "On" : "Off",
                              style: Styles.RobotoMedium(
                                color: Colors.white,
                                fontSize: ApplicationSizing.constSize(
                                  12,
                                ),
                              ),
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "${alertSetting.value ?? ""}",
                                style: Styles.RobotoMedium(
                                  color: Colors.black,
                                  fontSize: ApplicationSizing.constSize(
                                    12,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: " ${alertSetting.unit ?? ""}",
                                style: Styles.RobotoThin(
                                  color: Colors.black,
                                  fontSize: ApplicationSizing.constSize(
                                    8,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          // child: Text("CGMID",
                          //   style: Styles.RobotoMedium(
                          //     color: Colors.black,
                          //     fontSize: ApplicationSizing.constSize( 12,
                          //     ),),),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: ApplicationSizing.constSize(5),
                  // height: ApplicationSizing.constSize( 5),
                );
              },
              itemCount: dexComVM.dexcomDeivices == null ? 0 : dexComVM.dexcomDeivices
                  ?.alertScheduleList?[0].alertSettings?.length ??
                  0
          )
        ],
      ),
    );
  }

  BottomSlider(context,DexComVM dexComVM) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 1))),
      width: MediaQuery.of(context).size.width,
      height: ApplicationSizing.constSize( 60),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
            horizontal: ApplicationSizing.constSize( 24),
            vertical: ApplicationSizing.constSize( 10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ApplicationSizing.constSize( 20)),
          border: Border.all(
            color: appColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  dexComVM.SetDexcomCGMSelectedGraphType(0);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: dexComVM.DexcomCGMSelectedGraphType == 0
                            ? appColor
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(ApplicationSizing.constSize( 20)),
                          bottomLeft:
                          Radius.circular(ApplicationSizing.constSize( 20)),
                        )),
                    alignment: Alignment.center,
                    child:
                    Icon(FluentSystemIcons.ic_fluent_navigation_regular)),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  dexComVM.SetDexcomCGMSelectedGraphType(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: dexComVM.DexcomCGMSelectedGraphType == 1
                          ? appColor
                          : Colors.white,
                      border: Border(
                        right: BorderSide(color: appColor, width: 2),
                        left: BorderSide(color: appColor, width: 2),
                      )),
                  alignment: Alignment.center,
                  child: Icon(
                    FluentSystemIcons.ic_fluent_data_pie_regular,
                    size: ApplicationSizing.constSize( 30),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  dexComVM.SetDexcomCGMSelectedGraphType(2);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: dexComVM.DexcomCGMSelectedGraphType == 2
                          ? appColor
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(ApplicationSizing.constSize( 20)),
                        bottomRight: Radius.circular(ApplicationSizing.constSize( 20)),
                      )),
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: 60,
                    origin: Offset(0, 0),
                    child: Icon(
                      FluentSystemIcons.ic_fluent_data_line_regular,
                      size: ApplicationSizing.constSize( 30),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
