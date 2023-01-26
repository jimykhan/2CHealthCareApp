
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
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/views/health_guides/in_app_browser.dart';

class CGMService{
  DioServices? dioServices;
  SharedPrefServices? _sharedPrefServices;
  DioServices? _dioServices;

  ProviderReference? _ref;
  CGMService({ ProviderReference? ref}){
    _ref = ref;
    initServices();
  }
  initServices(){
    dioServices = _ref?.read(dioServicesProvider);
    _sharedPrefServices = _ref?.read(sharedPrefServiceProvider);
    _dioServices = _ref?.read(dioServicesProvider);
  }

  Future<bool> checkDexComAuthByPatientId()async{
    bool isConnect = false;
    int UserId = await _sharedPrefServices!.getCurrentUserId();
    try{
      Response? response  = await _dioServices?.dio?.get(DexComController.Check_Auth_Given+"?patientId=${UserId}");
      if(response?.statusCode == 200){
        print("//////////////////dexcom//////////////////");
        print("${response?.data}");
        print("//////////////////dexcom//////////////////");
        isConnect = response?.data??false;
      }else{
        isConnect = false;
      }
      return isConnect;
    }
    catch(e){
      return isConnect;
    }
  }

  Future<dynamic> dexcomAutherizations() async {
    print("lounchDexcom url call");
    try {
      int patientId = await _sharedPrefServices?.getCurrentUserId()??-1;
      var response = await dioServices?.dio?.get(DexComController.GET_DEXCOM_CODE+"/$patientId");

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

  Future<Devices?> GetDexcomDevices({
        required int patientId,
        required DateTime startDate,
        required DateTime endDate,
      }) async {
    try {
      Devices? dexcomDeivices;
      Response? res = await dioServices?.dio?.get(DexComController.DEXCOM_GET_DEVICES+
          "/${patientId}?startDate=${startDate.toString().substring(0, 10)}&endDate=${endDate.toString().substring(0, 10)}");


      if (res is Response) {
        if (res.statusCode == 200) {
          GetDexcomDeivice deivices = GetDexcomDeivice.fromJson(res.data);
          if (!(deivices.devices?.isEmpty??true)) {
            dexcomDeivices = deivices.devices![0];
            // dexcomDeivices.lastUploadDate = Jiffy((DateFormat("yyyy-MM-dd HH:mm:ss")
            //     .parse(
            //     DateTime.parse(dexcomDeivices.lastUploadDate).toString(),
            //     true))
            //     .toLocal()
            //     .toString())
            //     .format("dd MMM yy, h:mm a");
            if(dexcomDeivices.lastUploadDate != null){
              dexcomDeivices.lastUploadDate = Jiffy(dexcomDeivices.lastUploadDate).format(Strings.dateAndTimeFormat);
            }
          }
        }
        return dexcomDeivices;
      }
    } catch (e) {
      return null;
    }
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
      Response? response = await dioServices?.dio?.post(DexComController.DEXCOM_GET_STATISTICS+
          "/${patientId}?startDate=${startDate.toString().substring(0, 10)}&endDate=${endDate.toString().substring(0, 10)}",data: body);
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

  Future<GetDexcomAvgsResponse?> GetDexcomAvgs( {
        required int patientId,
        required DateTime startDate,
        required DateTime endDate,
      }) async {
    try {
      DexcomAvgs? dexcomAvgs;
      GetDexcomAvgsResponse responseType = GetDexcomAvgsResponse(listOfAvgsData: [],dexcomAvgs: dexcomAvgs);

      Response? response = await dioServices?.dio?.get(DexComController.DEXCOM_GET_EGVS+
          "/${patientId}?startDate=${startDate.toString().substring(0, 10)}&endDate=${endDate.toString().substring(0, 10)}");


      if (response is Response) {
        print("THIS IS STATUS CODE ${response.statusCode}");
        if (response.statusCode == 200) {
          dexcomAvgs = DexcomAvgs.fromJson(response.data);
          responseType.dexcomAvgs = dexcomAvgs;
          responseType.listOfAvgsData = ArrangeCCMAvgsData(dexcomAvgs);
        }
      }
      return responseType;
    } catch (e) {
      return null;
    }
  }

  List<AvgsData> ArrangeCCMAvgsData(DexcomAvgs dexcomAvgs) {
    List<AvgsData> listOfAvgsData = [];
    if (dexcomAvgs != null) {
      dexcomAvgs.egvs?.sort((a, b) {
        return a.displayTime == null ? 1.compareTo(2) : double.parse(a.displayTime
            !.trim()
            .replaceAll("-", "")
            .replaceAll("T", "")
            .replaceAll(":", ""))
            .compareTo(double.parse(b.displayTime
            !.trim()
            .replaceAll("-", "")
            .replaceAll("T", "")
            .replaceAll(":", "")));
      });

      String hourFormat = "";
      String mintesFormat = "";
      for (int hour = 0; hour <= 23; hour++) {
        for (int mintes = 1; mintes <= 4; mintes++) {
          List<int> totalVaule = [];
          List<String> dateTime = [];
          double totalSum = 0;
          dexcomAvgs.egvs?.forEach((reading) {
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
        print("time = ${element.time}");
        print("value = ${element.value}");
      });
    }
    return listOfAvgsData;
  }
}

class GetDexcomAvgsResponse{
  List<AvgsData> listOfAvgsData = [];
  DexcomAvgs? dexcomAvgs;
  GetDexcomAvgsResponse({required this.listOfAvgsData,this.dexcomAvgs});
}

class AvgsData {
  String? time;
  double? value;
  String? date;
  String? timeStump;
  AvgsData({this.value, this.time,this.date,this.timeStump});
}
class PieGraphData {
  String? title;
  double? value;
  Color? color;
  PieGraphData({this.value, this.title, this.color});
}