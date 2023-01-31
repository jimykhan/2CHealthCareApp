import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/rpm_models/dex_com_models/DexcomAvgs.dart';
import 'package:twochealthcare/models/rpm_models/dex_com_models/GetDexcomDevices.dart';
import 'package:twochealthcare/models/rpm_models/dex_com_models/GetStatisticsDataModel.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/rpm_services/cgm_services.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/views/CustomCalendar/custom_date_range_picker.dart';

class DexComVM extends ChangeNotifier{

  /// Service
  CGMService? cgmService;
  SharedPrefServices? sharedPrefServices;
  /// Service
  int DexcomCGMSelectedRangeType = 0;
  int DexcomCGMSelectedGraphType = 0;
  Devices? dexcomDeivices;
  GetStatisticsDataModel? statisticsData;
  DexcomAvgs? dexcomAvgs;
  List<AvgsData> listOfAvgsData = [];
  /// Loader flag
  bool LoadingDexcomGetStatistics = false;
  bool LoadingDexcomGetDevices = false;
  bool LoadingDexcomGetEgvs = false;
  /// Loader flag
  double maximumBGRange = 100;

  List<DateTime> DexcomCGMDataSelectedDate = [
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 7,
    ),
    DateTime.now()
  ];
  ProviderReference? _ref;

  DexComVM({ ProviderReference? ref}){
    _ref = ref;
    initService();
  }

  initService(){
    cgmService = _ref?.read(cgmServiceProvider);
    sharedPrefServices = _ref?.read(sharedPrefServiceProvider);
  }


  SetDexcomCGMSelectedGraphType(int index) {
    DexcomCGMSelectedGraphType = index;
    notifyListeners();
  }

  SetDexcomCGMSelectedRangeType(
      int index, {
        String? modality,
        required int patientId,
      }) async {
    int currentPatientId = patientId;
    if (index == 1) {
      DexcomCGMDataSelectedDate = [
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 7,
        ),
        DateTime.now()
      ];
    }
    if (index == 2) {
      DexcomCGMDataSelectedDate = [
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 15,
        ),
        DateTime.now()
      ];
    }
    if (index == 0) {

    }
    if(currentPatientId == 0){
      currentPatientId = await sharedPrefServices?.getCurrentUserId()?? 0;
    }
    if(index == 0){
      MultiDatePicker(index,currentPatientId);
    }else{
      getDexComData(index,currentPatientId);
    }

  }

  getDexComData(int index,int currentPatientId) async{
    DexcomCGMSelectedRangeType = index;
    LoadingDexcomGetStatistics = true;
    LoadingDexcomGetDevices = true;
    LoadingDexcomGetEgvs = true;
    notifyListeners();
    try{
      dexcomDeivices = await cgmService?.GetDexcomDevices(patientId: currentPatientId,startDate: DexcomCGMDataSelectedDate[0], endDate: DexcomCGMDataSelectedDate[1]);
      SetLoadingDexcomGetDevices(false);
      statisticsData = await cgmService?.GetStatisticsData(patientId: currentPatientId,startDate: DexcomCGMDataSelectedDate[0], endDate: DexcomCGMDataSelectedDate[1]);
      SetLoadingDexcomGetStatistics(false);
      GetDexcomAvgsResponse? res = await cgmService?.GetDexcomAvgs(patientId: currentPatientId,startDate: DexcomCGMDataSelectedDate[0], endDate: DexcomCGMDataSelectedDate[1]);
      if(res != null){
        dexcomAvgs = res.dexcomAvgs;
        listOfAvgsData = res.listOfAvgsData;
      }
      listOfAvgsData.forEach((element) {
        if(element.value! > maximumBGRange){
          maximumBGRange = element.value!;
        }
      });
      SetLoadingDexcomGetEgvs(false);
    }catch(ex){
      SetLoadingDexcomGetDevices(true);
      SetLoadingDexcomGetStatistics(true);
      SetLoadingDexcomGetEgvs(true);
    }
  }

   MultiDatePicker(int index, int currentUserId)  {
     showCustomDateRangePicker(
      applicationContext!.currentContext!,
      dismissible: true,
      minimumDate: DateTime(2010),
      maximumDate: DateTime(2030),
      // endDate: DexcomCGMDataSelectedDate[0],
      // startDate: DexcomCGMDataSelectedDate[1],
      onApplyClick: (start, end) {
        DexcomCGMDataSelectedDate[0] = start;
        DexcomCGMDataSelectedDate[1] = end;
        getDexComData(index,currentUserId);
      }, onCancelClick: () {  },
       primaryColor: appColor,
       backgroundColor: appColor
      // onCancelClick: () {
      //   setState(() {
      //     endDate = null;
      //     startDate = null;
      //   });
      // },
    );
  }


/// Loaders
  SetLoadingDexcomGetDevices(bool loading) {
    LoadingDexcomGetDevices = loading;
    notifyListeners();
  }

  SetLoadingDexcomGetStatistics(bool loading) {
    LoadingDexcomGetStatistics = loading;
    notifyListeners();
  }


  SetLoadingDexcomGetEgvs(bool loading) {
    LoadingDexcomGetEgvs = loading;
    notifyListeners();
  }
/// Loaders

}