import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/permission_service.dart';
import 'package:twochealthcare/services/phdevice_service/phdevice_service.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/application_colors.dart';

class BleVM extends ChangeNotifier {
  String glucoseServiceUuid = _uuidFromShortString("1808");
  String glucoseDeviceInfoServiceUuid = _uuidFromShortString("180A");
  String glucoseMeasureCharUuid = _uuidFromShortString("2a18");
  String glucoseMeasureContextCharUuid = _uuidFromShortString("2a34");
  String glucoseRacpUuid = _uuidFromShortString("2a52");
  String continuousGlucoseMonitoringUuid = _uuidFromShortString("181F");
  String glucoseSerialNumberUuid = _uuidFromShortString("2a25");
  String glucoseModelNumberUuid = _uuidFromShortString("2a24");
  String glucoseManufacturerUuid = _uuidFromShortString("2a29");
  bool deviceConnect = false;
  PermissionService? _permissionService;
  PhDeviceService? _phDeviceService;
  SharedPrefServices? _sharedPrefServices;
  RpmService? _rpmService;
  ProviderReference? _ref;
  List<int> glucoseReading = <int>[];
  List<int> glucoseContext = <int>[];
  List<ModalitiesModel> modalitiesList = [];

  bool isbloodGlucoseCharSubscripe = false;
  bool isScanning = false;
  bool IsPatientBleEnabled = false;

  BleVM({ProviderReference? ref}) {
    _ref = ref;
    initService();
  }

  initService() {
    FlutterBluePlus.scanResults.listen((results) async {
      // do something with scan results
      for (ScanResult element in results) {
        if (deviceConnect) return;
        await connectDevice(element.device);
      }
    });
      FlutterBluePlus.isScanning.listen((event) {
        isScanning = event;
        print("Scaning status ${event}");
        notifyListeners();
      });

    _permissionService = _ref?.read(permissionServiceProvider);
    _phDeviceService = _ref?.read(phDeviceServiceProvider);
    _sharedPrefServices = _ref?.read(sharedPrefServiceProvider);
    _rpmService = _ref?.read(rpmServiceProvider);
    // BluetoothCharacteristic? glucoseMeasureChar = BluetoothCharacteristic().;
  }

  initialState(int currentPatienId) async {
    isScanning = false;
    IsPatientBleEnabled = false;
    if (currentPatienId != -1) {
      _permissionService?.turnOnBlue();
      deviceConnect = false;
      startScan();
      _phDeviceService?.syncLogsData();
    }
  }


  startScan() async {
     IsPatientBleEnabled = await _rpmService?.isBleEnabled() ?? false;
    if(IsPatientBleEnabled) {
      bool isLocationAccess = await _permissionService!
          .locationPermissionRequest();
      // bool isBleAccess = await _permissionService!.bluetoothPermissionRequest();
      if (IsPatientBleEnabled) {
        getModalitiesByUserId();
        // if (isLocationAccess && isBleAccess) {
        if (isLocationAccess) {
          await FlutterBluePlus.startScan(
              withServices: [Guid(glucoseServiceUuid)]).
          onError((error, stackTrace) {
            print("$error $stackTrace");
          });
        }
      }
    }
  }



  stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  bluetoothIcon(){
    return !IsPatientBleEnabled ?  Container()
    : InkWell(
        onTap:  ()  {},
        child: Container(
          child: isScanning ? Container(
              height: 40, width: 40,
              child: Icon(Icons.bluetooth_rounded,color: appColor,size: 35,))
              : InkWell(onTap:() async {
            await FlutterBluePlus.startScan(
                withServices: [Guid(glucoseServiceUuid)]).
            onError((error, stackTrace) {
              print("$error $stackTrace");
            });
          },child: Icon(Icons.bluetooth_disabled_rounded,color: fontGrayColor,size: 35,)),));
  }

  connectDevice(BluetoothDevice device) async {
    if (deviceConnect) return;
    deviceConnect = true;
    try {
      await device.connect();
      await discoverService(device);
    } catch (ex) {
      deviceConnect = false;
      await device.disconnect();
    }
  }

  discoverService(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      BluetoothService? glucoseService = services.firstWhere((
          service) => service.uuid.toString() == glucoseServiceUuid,
          orElse: null);
      // BluetoothService? deviceInfo = services.firstWhere((
      //     service) => service.uuid.toString() == glucoseDeviceInfoServiceUuid,
      //     orElse: null);

      if (glucoseService != null) {
        await getBGData(device, glucoseService);
      } else {
        device.disconnect();
        deviceConnect = false;
      }
    } catch (ex) {
      deviceConnect = false;
      await device.disconnect();
    }
  }

  // getBGDeviceInfo(BluetoothService deviceInfo) async {
  //   try{
  //     BluetoothCharacteristic serialNumberChar = (await deviceInfo.characteristics)
  //         .firstWhere((chr) => chr.uuid.toString() == glucoseSerialNumberUuid,
  //         orElse: null);
  //
  //     BluetoothCharacteristic manufacturerChar = (await deviceInfo.characteristics)
  //         .firstWhere((chr) =>
  //     chr.uuid.toString() == glucoseManufacturerUuid, orElse: null);
  //
  //     BluetoothCharacteristic modelNumberChar = (await deviceInfo.characteristics)
  //         .firstWhere((chr) => chr.uuid.toString() == glucoseModelNumberUuid,
  //         orElse: null);
  //
  //     String modelNumber = modelNumberChar.
  //   }catch(ex){
  //
  //   }
  // }

  getBGData(BluetoothDevice device, BluetoothService glucoseService) async {
    BluetoothCharacteristic? glucoseMeasureChar;
    BluetoothCharacteristic? glucoseMeasureContextChar;
    BluetoothCharacteristic? glucoseRacpServiceChar;
    try {
      glucoseMeasureChar = (await glucoseService.characteristics)
          .firstWhere((chr) => chr.uuid.toString() == glucoseMeasureCharUuid,
          orElse: null);

      glucoseMeasureContextChar = (await glucoseService.characteristics)
          .firstWhere((chr) =>
      chr.uuid.toString() == glucoseMeasureContextCharUuid, orElse: null);

      glucoseRacpServiceChar = (await glucoseService.characteristics)
          .firstWhere((chr) => chr.uuid.toString() == glucoseRacpUuid,
          orElse: null);


      if (!isbloodGlucoseCharSubscripe) {
        try {
          isbloodGlucoseCharSubscripe = true;
          glucoseMeasureChar.value.listen((event) async {
            print("Publish to server $event");
            if (event.isNotEmpty) {
              try {
                glucoseReading = event.toList();
                int flags = glucoseReading[0];
                var contextWillFollow = (flags & 0x10) > 0;
                if (!contextWillFollow) {
                  /// Publish Data
                  await publishBGData(serialNumber: device.name,
                      data: glucoseReading,
                      data2: glucoseContext);
                }
              } catch (ex) {
                disconnectDevice(device);
              }
            }
            // glucoseMeasurement = await parseGlucoseMeasurement(event);
          });
          glucoseMeasureContextChar.value.listen((event) async {
            print("Publish to server $event");
            if (event.isNotEmpty) {
              try {
                glucoseContext = event.toList();
                await publishBGData(serialNumber: device.name,
                    data: glucoseReading,
                    data2: glucoseContext);

                /// Publish Data

              } catch (ex) {
                disconnectDevice(device);
              }
            }
          });
          glucoseRacpServiceChar.value.listen((event) {
            print("$event");
          });
        } catch (ex) {
          isbloodGlucoseCharSubscripe = true;
        }
      }

      await glucoseMeasureChar.setNotifyValue(true);
      await glucoseMeasureContextChar.setNotifyValue(true);
      await glucoseRacpServiceChar.setNotifyValue(true);
      await glucoseRacpServiceChar.write(
          [0x01, 0x06], withoutResponse: Platform.isIOS ? false : true);
    } catch (ex) {
      deviceConnect = false;
      await device.disconnect();
    } finally {
      Future.delayed(Duration(seconds: 10), () {
        disconnectDevice(device);
        notifyListeners();
      });
    }
  }


  disconnectDevice(BluetoothDevice device) async {
    deviceConnect = false;
    await device.disconnect();
  }

  static String _uuidFromShortString(String uuid) {
    return "0000$uuid-0000-1000-8000-00805f9b34fb";
  }

  // bluetoothExist({String? serialNumber, var data, var data2}){
  //   ModalitiesModel? modalitiesModel = modalitiesList.firstWhereOrNull((element) => element.serialNo?.toUpperCase() == serialNumber?.toUpperCase());
  //   if(modalitiesModel != null){
  //     publishBGData(serialNumber: serialNumber,data: data, data2: data2);
  //   }else{
  //     AlertMessageCustomDesign(
  //         title: "The device $serialNumber not configure. Do you want configure?",
  //         onConfirm: (){
  //           Navigator.pop(applicationContext!.currentContext!);
  //           publishBGData(serialNumber: serialNumber,data: data, data2: data2);
  //         }
  //     );
  //   }
  //
  // }


  publishBGData({String? serialNumber, var data, var data2}) async {
    var body;
    try {
      int patientId = await _sharedPrefServices?.getCurrentUserId() ?? 0;
      body = {
        "patientId": patientId,
        "modality": "BG",
        "macAddress": serialNumber,
        "publishTime": DateTime.now().toString(),
        "data": data,
        "data2": data2,
        "manufacturer": "Roche",
        "model": "925",
        "serialNo": serialNumber
      };
      var response = await _phDeviceService?.publishPhdData(body);
      if (response is bool) {
        _rpmService?.refreshModalities.add(
            RefreshModalityData(patientId, false));
      }
    } catch (ex) {
      _sharedPrefServices?.setlogRpmDataLogs(body);

      /// save reading in logs
    }
  }

  getModalitiesByUserId()async{
    int patientId = await _sharedPrefServices?.getCurrentUserId() ?? 0;
    var res = await _rpmService?.getModalitiesByUserId(currentUserId: patientId);
    if(res is List){
      modalitiesList = [];
      res.forEach((element){
        modalitiesList.add(element);
      });
    }
  }
}