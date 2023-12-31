import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_beep/flutter_beep.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:twochealthcare/common_widgets/aler_dialogue.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/phdevice_service/phdevice_service.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/components/verify_barcode.dart';

class BarcodeVM extends ChangeNotifier{
  ProviderReference? _ref;
  SignalRServices? signalRServices;
  PhDeviceService? _phDeviceService;
  late MobileScannerController cameraController;
  TextEditingController verifyBarcodeText = TextEditingController();
  String scanBarcode = "";
  int scanBarcodeRCount = 0;
  bool sendingBarCode = false;
  bool showAlert = true;
  List<String> barcodeList = [];
  GlobalKey focusContainer = GlobalKey();
  /// Add Device for patient from facility end
  bool fromPatientSummary = false;
  /// Add Device for patient from facility end

  Timer? _timer;
  int syncTime = 5;

  BarcodeVM({ProviderReference? ref}){
    _ref = ref;
    signalRServices = ref?.read(signalRServiceProvider);
    _phDeviceService = ref?.read(phDeviceServiceProvider);
  }

  initBarcode({bool fromPatientSummary = false}){
    cameraController  = MobileScannerController(
      formats: [BarcodeFormat.code128,BarcodeFormat.aztec,BarcodeFormat.code39,BarcodeFormat.code93,BarcodeFormat.codebar,BarcodeFormat.ean8,BarcodeFormat.ean13,
        BarcodeFormat.itf,BarcodeFormat.pdf417],
      // detectionSpeed: DetectionSpeed.unrestricted,
    );
    this.fromPatientSummary = fromPatientSummary;
    barcodeList = [];
    scanBarcode = "";
    scanBarcodeRCount = 0;
    showAlert = true;
  }

  onDetect(BarcodeCapture barcodeCapture){
    Barcode barcode = barcodeCapture.barcodes.first;
    if (barcode.rawValue == null) {
      debugPrint('Failed to scan Barcode');
    }
    else {
      // RenderBox box = focusContainer.currentContext!.findRenderObject() as RenderBox;
      // Offset endposition = box.localToGlobal(Offset.zero);
      // Offset startposition = box.localToGlobal(Offset(0, -(box.constraints.maxHeight)));
      final String code = barcode.rawValue!;
      // double w = MediaQuery.of(applicationContext!.currentContext!).size.width;
      // double h = MediaQuery.of(applicationContext!.currentContext!).size.height;
      showBarcodeConfimation(code);
      // if(Platform.isIOS){
      //   barcode.corners?.forEach((element) {
      //     if((element.dy >= (startposition.dy * 2) && element.dy <= (endposition.dy * 2)))
      //     {
      //       scanBarcodeRCount++;
      //       if(code != scanBarcode){
      //         scanBarcode = barcode.rawValue!;
      //         scanBarcodeRCount = 0;
      //       }
      //       print("$scanBarcodeRCount $code");
      //
      //       if(scanBarcodeRCount > 8 && showAlert) {
      //         showBarcodeConfimation(code);
      //       }
      //       debugPrint('Barcode found! $code');
      //     }
      //   });
      // }
      // else{
      //   Future.delayed(Duration(seconds: 1),(){{
      //     barcode.corners?.forEach((element) {
      //       if((element.dy >= startposition.dy && element.dy <= endposition.dy))
      //       {
      //         scanBarcodeRCount++;
      //         if(code != scanBarcode){
      //           scanBarcode = barcode.rawValue!;
      //           scanBarcodeRCount = 0;
      //         }
      //         print("$scanBarcodeRCount $code");
      //
      //         if(scanBarcodeRCount > 8 && showAlert) {
      //           showBarcodeConfimation(code);
      //         }
      //         debugPrint('Barcode found! $code');
      //       }
      //     });
      //   }});
      // }

    }
  }
  onScannerStart(MobileScannerArguments? mobileScannerArguments){
    MobileScannerArguments? mobileScanArguments = mobileScannerArguments;
  }
  Widget scannerPlaceHolder(BuildContext? context,Widget? scannerWidget){
    Widget? scanWiget = scannerWidget;
    return Container(width: 200,height: 50,color: Colors.red,);
  }



  showBarcodeConfimation(String code){
    showAlert = false;
    verifyBarcodeText.text = code;
    cameraController.stop();
    // FlutterBeep.beep();
    fromPatientSummary ? pushBarToPhDeviceService() : showSucessIcon();
    // startTimer();
  }

  showSucessIcon(){
    showDialog(
      context: applicationContext!.currentContext!,
      builder: (BuildContext context) {
         sendBarcode();
        return SucessIcon();
      },
    );
  }

  pushBarToPhDeviceService()async{
    scanBarcode = "";
    scanBarcodeRCount = 0;
    Navigator.pop(applicationContext!.currentContext!);
    await Future.delayed(Duration(seconds: 2),() => showAlert = true);
    _phDeviceService?.scanBarcode.add(verifyBarcodeText.text);
  }




  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (syncTime == 0) {
          onTimerComplete();
          notifyListeners();
        } else {
          syncTime--;
          notifyListeners();
        }
      },
    );
  }

  stopTimer(){
    syncTime = 5;
    _timer?.cancel();
  }
  onTimerComplete(){
    stopTimer();
    sendBarcode();
  }

  sendBarcode() async {
    setSendingBarCode(true);
    await signalRServices?.SendBarcode(barcode: verifyBarcodeText.text);
    setSendingBarCode(false);
    closeAlert();
  }
  setSendingBarCode(bool check){
    sendingBarCode = check;
    notifyListeners();
  }

  closeAlert(){
    scanBarcode = "";
    scanBarcodeRCount = 0;
    Future.delayed(Duration(seconds: 2),() => showAlert = true);
    cameraController.start();
    Navigator.pop(applicationContext!.currentContext!);
  }
}