
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/rpm_models/dex_com_models/DexcomAvgs.dart';
import 'package:twochealthcare/models/rpm_models/dex_com_models/GetDexcomDevices.dart';
import 'package:twochealthcare/models/rpm_models/dex_com_models/GetStatisticsDataModel.dart';
import 'package:twochealthcare/models/rpm_models/dexcom_v3_models/dexcom_v3_calibrations.dart';
import 'package:twochealthcare/models/rpm_models/dexcom_v3_models/dexcom_v3_devices.dart';
import 'package:twochealthcare/models/rpm_models/dexcom_v3_models/dexcom_v3_evgs.dart';
import 'package:twochealthcare/models/rpm_models/dexcom_v3_models/statistics_and_evgs.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/views/health_guides/in_app_browser.dart';

class CGMService {
  DioServices? dioServices;
  SharedPrefServices? _sharedPrefServices;
  DioServices? _dioServices;

  ProviderReference? _ref;

  GetStatisticsDataModel statisticsData = GetStatisticsDataModel();
  StatisticsAndEvgs statisticsAndEvgs = StatisticsAndEvgs();

  CGMService({ProviderReference? ref}) {
    _ref = ref;
    initServices();
  }
  initServices() {
    dioServices = _ref?.read(dioServicesProvider);
    _sharedPrefServices = _ref?.read(sharedPrefServiceProvider);
    _dioServices = _ref?.read(dioServicesProvider);
  }

  Future<bool> checkDexComAuthByPatientId() async {
    bool isConnect = false;
    int UserId = await _sharedPrefServices!.getCurrentUserId();
    try {
      Response? response = await _dioServices?.dio
          ?.get(DexComController.Check_Auth_Given + "?patientId=${UserId}");
      if (response?.statusCode == 200) {
        print("//////////////////dexcom//////////////////");
        print("${response?.data}");
        print("//////////////////dexcom//////////////////");
        isConnect = response?.data ?? false;
      } else {
        isConnect = false;
      }
      return isConnect;
    } catch (e) {
      return isConnect;
    }
  }

  Future<dynamic> dexcomAutherizations() async {
    print("lounchDexcom url call");
    try {
      int patientId = await _sharedPrefServices?.getCurrentUserId() ?? -1;
      var response = await dioServices?.dio
          ?.get(DexComController.GET_DEXCOM_CODE + "/$patientId");

      if (response is Response) {
        if (response.statusCode == 200) {
          print(response.data);
          // Navigator.push(
          //     applicationContext!.currentContext!,
          //     PageTransition(
          //         child: InAppBrowser(
          //           url: response.data ?? "",
          //           title: "DexCom Authorization",
          //         ),
          //         type: PageTransitionType.fade));
          return response.data;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<DexcomV3DevicesAndSatistic?> GetDexcomDevices({
    required int patientId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      DexcomV3DevicesAndSatistic dexcomV3DevicesAndSatistic =
          DexcomV3DevicesAndSatistic();
      // Devices? dexcomDeivices;
      DexcomV3Devices? devices;
      Response? res = await dioServices?.dio?.get(DexComController
              .DEXCOM_GET_V3_DEVICES +
          "/${patientId}?startDate=${startDate.toString().substring(0, 10)}&endDate=${endDate.toString().substring(0, 10)}");

      if (res is Response) {
        if (res.statusCode == 200) {
          devices = DexcomV3Devices.fromJson(res.data);
          if (!(devices.records?.isEmpty ?? true)) {
            // dexcomDeivices = deivices.records![0];
            // dexcomDeivices.lastUploadDate = Jiffy((DateFormat("yyyy-MM-dd HH:mm:ss")
            //     .parse(
            //     DateTime.parse(dexcomDeivices.lastUploadDate).toString(),
            //     true))
            //     .toLocal()
            //     .toString())
            //     .format("dd MMM yy, h:mm a");
            devices.records!.forEach((dexcomDeivices) {
              if (dexcomDeivices.lastUploadDate != null) {
                dexcomDeivices.lastUploadDate =
                    Jiffy(dexcomDeivices.lastUploadDate)
                        .format(Strings.dateAndTimeFormat);
              }
            });
            _calculateAlertSettingsPercentage(
                devices.records![0].alertSchedules![0].alertSettings!);
          }
          dexcomV3DevicesAndSatistic.dexcomV3Devices = devices;
          dexcomV3DevicesAndSatistic.statistic = statisticsData;
          await GetDexcomCalibrations(
              patientId: patientId, startDate: startDate, endDate: endDate);
        }
        return dexcomV3DevicesAndSatistic;
      }
    } catch (e) {
      return null;
    }
  }

  GetDexcomCalibrations({
    required int patientId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      Response? res = await dioServices?.dio?.get(DexComController
              .DEXCOM_GET_V3_CALIBRAIONS +
          "/${patientId}?startDate=${startDate.toString().substring(0, 10)}&endDate=${endDate.toString().substring(0, 10)}");

      if (res is Response) {
        if (res.statusCode == 200) {
          DexcomV3Calibrations dexcomV3Calibrations =
              DexcomV3Calibrations.fromJson(res.data);
          int days = endDate.difference(startDate).inDays;
          if (dexcomV3Calibrations.records?.isNotEmpty ?? false) {
            dexcomV3Calibrations.records = dexcomV3Calibrations.records!
                .sublist(
                    0, (dexcomV3Calibrations.records!.length / days).floor());
            _calculateMeandailyCalibrations(dexcomV3Calibrations);
          }
        }
      }
    } catch (e) {
      return null;
    }
  }

  _calculateMeandailyCalibrations(DexcomV3Calibrations dexcomV3Calibrations) {
    List<int> value = dexcomV3Calibrations.records!.map((e) => e.value!).toList();
    statisticsData.meanDailyCalibrations = value.reduce((sum, next) => sum + next) / value.length;
  }

  _calculateAlertSettingsPercentage(List<AlertSettings> alertSettings) {
    double rise = 0.0;
    double outOfRange = 0.0;
    double high = 0.0;
    double fall = 0.0;
    double urgentLow = 0.0;
    double low = 0.0;
    alertSettings.forEach((element) {
      if (element.alertName?.toLowerCase().replaceAll(" ", "") == "rise".toLowerCase()) {
        rise = element.value!;
      }

      if (element.alertName?.toLowerCase().replaceAll(" ", "") == "outOfrange".toLowerCase()) {
        outOfRange = element.value!;
      }

      if (element.alertName?.toLowerCase().replaceAll(" ", "") == "high".toLowerCase()) {
        high = element.value!;
      }

      if (element.alertName?.toLowerCase().replaceAll(" ", "") == "fall".toLowerCase()) {
        fall = element.value!;
      }

      if (element.alertName?.toLowerCase().replaceAll(" ", "") == "urgentlow".toLowerCase()) {
        urgentLow = element.value!;
      }

      if (element.alertName?.toLowerCase().replaceAll(" ", "") == "low".toLowerCase()) {
        low = element.value!;
      }
    });
    if (statisticsAndEvgs.dexcomAvgsResponse?.dexcomAvgs != null) {
      List<int> values = statisticsAndEvgs
          .dexcomAvgsResponse!.dexcomAvgs!.records!
          .map((e) => e.value!)
          .toList();

      List<int> highList = values.where((element) => element >= high).toList();

      List<int> lowList = values.where((element) => element <= low && element > urgentLow).toList();

      List<int> urgentLowList = values.where((element) => element <= urgentLow).toList();

      List<int> inRangeList = values.where((element) => element > low && element < high).toList();

      statisticsData.nAboveRange = highList.length;
      statisticsData.nBelowRange = lowList.length;
      statisticsData.nUrgentLow = urgentLowList.length;
      statisticsData.nWithinRange = inRangeList.length;
      statisticsData.nValues = values.length;
      statisticsData.percentAboveRange =
          _percentage(highList.length, values.length);
      statisticsData.percentBelowRange =
          _percentage(lowList.length, values.length);
      statisticsData.percentWithinRange =
          _percentage(inRangeList.length, values.length);
      statisticsData.percentUrgentLow =
          _percentage(urgentLowList.length, values.length);
    }
  }

  double _percentage(int a, int b) {
    return (a / b) * 100;
  }

  Future<GetStatisticsDataModel?> GetStatisticsData({
    required int patientId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    var body = {
      "targetRanges": [
        {
          "name": "day",
          "startTime": "07:00:00",
          "endTime": "20:00:00",
          "egvRanges": [
            {
              "name": "urgentLow",
              "bound": 55,
            },
            {
              "name": "low",
              "bound": 80,
            },
            {
              "name": "high",
              "bound": 250,
            },
          ],
        },
        {
          "name": "night",
          "startTime": "20:00:00",
          "endTime": "07:00:00",
          "egvRanges": [
            {
              "name": "urgentLow",
              "bound": 55,
            },
            {
              "name": "low",
              "bound": 80,
            },
            {
              "name": "high",
              "bound": 250,
            },
          ],
        },
      ],
    };
    GetStatisticsDataModel? statisticsData;
    try {
      Response? response = await dioServices?.dio?.post(
          DexComController.DEXCOM_GET_STATISTICS +
              "/${patientId}?startDate=${startDate.toString().substring(0, 10)}&endDate=${endDate.toString().substring(0, 10)}",
          data: body);
      if (response is Response) {
        if (response.statusCode == 200) {
          statisticsData = GetStatisticsDataModel.fromJson(response.data);
        }
        return statisticsData;
      }
    } catch (e) {
      return null;
    }
  }

  Future<StatisticsAndEvgs?> GetDexcomAvgs({
    required int patientId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      DexcomV3Evgs? dexcomAvgs;
      GetDexcomAvgsResponse responseType =
          GetDexcomAvgsResponse(listOfAvgsData: [], dexcomAvgs: dexcomAvgs);

      Response? response = await dioServices?.dio?.get(DexComController
              .DEXCOM_GET_V3_EGVS +
          "/${patientId}?startDate=${startDate.toString().substring(0, 10)}&endDate=${endDate.toString().substring(0, 10)}");

      if (response is Response) {
        print("THIS IS STATUS CODE ${response.statusCode}");
        if (response.statusCode == 200) {
          dexcomAvgs = DexcomV3Evgs.fromJson(response.data);
          responseType.dexcomAvgs = dexcomAvgs;
          responseType.listOfAvgsData = ArrangeCCMAvgsData(dexcomAvgs);
          statisticsAndEvgs.dexcomAvgsResponse = responseType;
          statisticsAndEvgs.statisticsDataModel =
              createDexcomStatisticsData(dexcomAvgs);
        }
      }
      return statisticsAndEvgs;
    } catch (e) {
      return null;
    }
  }

  GetStatisticsDataModel createDexcomStatisticsData(DexcomV3Evgs dexcomAvgs) {
    double totalSum = 0;
    int totalLength = dexcomAvgs.records?.length ?? 1;
    if (dexcomAvgs.records?.isNotEmpty ?? false) {
      List<int> values = dexcomAvgs.records!.map((e) => e.value!).toList();

      statisticsData.min =
          values.reduce((current, next) => current > next ? next : current);
      statisticsData.max =
          values.reduce((current, next) => current > next ? current : next);
      statisticsData.mean =
          ((values.reduce((a, b) => a + b))) / totalLength as double;
      statisticsData.sum = ((values.reduce((a, b) => a + b))).toDouble();
      statisticsData.median = _calculateMedian(values);

      // if ((totalLength / 2).remainder(2) == 1) {
      //   statisticsData.median = (values[(totalLength / 2).floor()]).toDouble();
      // } else {
      //   int a = values[(totalLength / 2).toInt()];
      //   int b = values[(totalLength / 2).toInt() + 1];
      //   statisticsData.median = (a + b) / 2;
      // }

      // Calculate the variance
      double variance = values
              .map((x) => pow(x - statisticsData.mean!, 2))
              .reduce((a, b) => a + b) /
          (values.length - 1);

      // Calculate the standard deviation
      double standardDeviation = sqrt(variance);

      statisticsData.variance = variance;
      statisticsData.stdDev = standardDeviation;
      statisticsData.q1 = _caculateQ1(values);
      statisticsData.q2 = _caculateQ2(values);
      statisticsData.q3 = _caculateQ3(values);
    }
    return statisticsData;
  }

  double _calculateMedian(List<int> data) {
    final int length = data.length;
    final int middle = length ~/ 2;
    if (length % 2 == 0) {
      return (data[middle - 1] + data[middle]) / 2;
    } else {
      return data[middle].toDouble();
    }
  }

  double _caculateQ1(List<int> egvData) {
    egvData.sort();
    // Calculate the median of the EGV data
    final double median = _calculateMedian(egvData);
    // Divide the EGV data into two halves
    final List<int> lowerHalf =
        egvData.sublist(0, egvData.indexOf(median.toInt()));
    final List<int> upperHalf =
        egvData.sublist(egvData.indexOf(median.toInt()) + 1);
    // Calculate the median of the lower half
    final double firstQuartile = _calculateMedian(lowerHalf);
    return firstQuartile;
  }

  double _caculateQ2(List<int> egvData) {
    egvData.sort();
    // Calculate the median of the EGV data
    final double median = _calculateMedian(egvData);

    return median;
  }

  double _caculateQ3(List<int> egvData) {
    egvData.sort();
    // Divide the EGV data into two halves
    final List<int> lowerHalf = egvData.sublist(0, egvData.length ~/ 2);
    final List<int> upperHalf = egvData.sublist(egvData.length ~/ 2);

    // Calculate the median of the upper half
    final double thirdQuartile = _calculateMedian(upperHalf);

    return thirdQuartile;
  }

  List<AvgsData> ArrangeCCMAvgsData(DexcomV3Evgs dexcomAvgs) {
    List<AvgsData> listOfAvgsData = [];
    if (dexcomAvgs != null) {
      dexcomAvgs.records?.sort((a, b) {
        return a.displayTime == null
            ? 1.compareTo(2)
            : double.parse(a.displayTime!
                    .trim()
                    .replaceAll("-", "")
                    .replaceAll("T", "")
                    .replaceAll(":", "")
                    .replaceAll("+", ""))
                .compareTo(double.parse(b.displayTime!
                    .trim()
                    .replaceAll("-", "")
                    .replaceAll("T", "")
                    .replaceAll(":", "")
                    .replaceAll("+", "")));
      });

      String hourFormat = "";
      String mintesFormat = "";
      for (int hour = 0; hour <= 23; hour++) {
        for (int mintes = 1; mintes <= 4; mintes++) {
          List<int> totalVaule = [];
          List<String> dateTime = [];
          double totalSum = 0;
          dexcomAvgs.records?.forEach((reading) {
            if (DateTime.parse(reading.displayTime!).hour == hour &&
                (DateTime.parse(reading.displayTime!).minute >=
                        (mintes - 1) * 15 &&
                    DateTime.parse(reading.displayTime!).minute <=
                        mintes * 15)) {
              totalVaule.add(reading.value!);
              hourFormat = DateTime.parse(reading.displayTime!).hour < 9
                  ? "0${DateTime.parse(reading.displayTime!).hour}"
                  : DateTime.parse(reading.displayTime!).hour.toString();
              mintesFormat = DateTime.parse(reading.displayTime!).minute < 9
                  ? "0${DateTime.parse(reading.displayTime!).minute}"
                  : DateTime.parse(reading.displayTime!).minute.toString();
            }
          });
          totalVaule.forEach((val) {
            totalSum = totalSum + val;
          });

          listOfAvgsData.add(
            AvgsData(
              value: totalSum / totalVaule.length,
              time: hourFormat + ":" + mintesFormat,
              // date: reading
            ),
          );
        }
      }
      print("this is the length of Avgs data = ${listOfAvgsData.length}");
      listOfAvgsData.forEach((element) {
        element.value = element.value?.roundToDouble();
        print("time = ${element.time}");
        print("value = ${element.value}");
      });
    }
    return listOfAvgsData;
  }
}

class GetDexcomAvgsResponse {
  List<AvgsData> listOfAvgsData = [];
  DexcomV3Evgs? dexcomAvgs;
  GetDexcomAvgsResponse({required this.listOfAvgsData, this.dexcomAvgs});
}

class AvgsData {
  String? time;
  double? value;
  String? date;
  String? timeStump;
  AvgsData({this.value, this.time, this.date, this.timeStump});
}

class PieGraphData {
  String? title;
  double? value;
  Color? color;
  PieGraphData({this.value, this.title, this.color});
}
