import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:twochealthcare/common_widgets/aler_dialogue.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/verify_barcode.dart';

class BarcodeVM extends ChangeNotifier{
  ProviderReference? _ref;
  SignalRServices? signalRServices;
  late MobileScannerController cameraController;
  TextEditingController verifyBarcodeText = TextEditingController();
  String scanBarcode = "";
  int scanBarcodeRCount = 0;
  bool sendingBarCode = false;
  bool showAlert = true;
  List<String> barcodeList = [];
  GlobalKey focusContainer = GlobalKey();


  Timer? _timer;
  int syncTime = 5;

  BarcodeVM({ProviderReference? ref}){
    _ref = ref;
    signalRServices = ref?.read(signalRServiceProvider);
  }

  initBarcode(){
    cameraController  = MobileScannerController()..stop();
    barcodeList = [];
    scanBarcode = "";
    scanBarcodeRCount = 0;
    showAlert = true;
  }

  onDetect(Barcode barcode, MobileScannerArguments? args){
    if (barcode.rawValue == null) {
      debugPrint('Failed to scan Barcode');
    }
    else {
      RenderBox box = focusContainer.currentContext!.findRenderObject() as RenderBox;
      Offset endposition = box.localToGlobal(Offset.zero);
      Offset startposition = box.localToGlobal(Offset(0, -(box.constraints.maxHeight)));
      final String code = barcode.rawValue!;
      Future.delayed(Duration(seconds: 1),(){{
        barcode.corners?.forEach((element) {
          if((element.dy >= startposition.dy && element.dy <= endposition.dy))
          {
            scanBarcodeRCount++;
            if(code != scanBarcode){
              scanBarcode = barcode.rawValue!;
              scanBarcodeRCount = 0;
            }
            print("$scanBarcodeRCount $code");
            if(scanBarcodeRCount > 8 && showAlert) {
              showBarcodeConfimation(code);
            }
            debugPrint('Barcode found! $code');
          }
        });
      }});
    }
  }


  showBarcodeConfimation(String code){
    showAlert = false;
    verifyBarcodeText.text = code;
    cameraController.stop();
    CenterAlertDialog(child:
    VerifyBarcode(),
        title: "Confirm IMEI"
    );
    startTimer();
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
    showAlert = true;
    cameraController.start();
    Navigator.pop(applicationContext!.currentContext!);
  }
}