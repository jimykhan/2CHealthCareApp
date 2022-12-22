import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:twochealthcare/common_widgets/aler_dialogue.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/verify_barcode.dart';

class BarcodeVM extends ChangeNotifier{
  ProviderReference? _ref;
  late MobileScannerController cameraController;
  TextEditingController verifyBarcodeText = TextEditingController();
  String scanBarcode = "";
  int scanBarcodeRCount = 0;
  bool showAlert = true;
  List<String> barcodeList = [];
  GlobalKey focusContainer = GlobalKey();
  BarcodeVM({ProviderReference? ref}){
    _ref = ref;
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
          // && element.dx >=
          // if((element.dy >= startposition.dy && element.dy <= endposition.dy) && (element.dx >= 20 && element.dx <= MediaQuery.of(applicationContext!.currentContext!).size.width -20))
          if((element.dy >= startposition.dy && element.dy <= endposition.dy))
          {
            // bool isExists = barcodeList.any((element1) => element1 == barcode.rawValue);
            scanBarcodeRCount++;
            if(code != scanBarcode){
              scanBarcode = barcode.rawValue!;
              scanBarcodeRCount = 0;
            }
            print("$scanBarcodeRCount $code");
            if(scanBarcodeRCount > 8 && showAlert) {
              // barcodeList.add(code);
              showAlert = false;
              verifyBarcodeText.text = code;
              cameraController.stop();
              CenterAlertDialog(child:
              VerifyBarcode(barcodeVM: this,),
                title: "Confirm IMEI"
              );
              // notifyListeners();
            }
            debugPrint('Barcode found! $code');
          }
        });
      }});


    }
  }

  onCancel(){
    scanBarcode = "";
    scanBarcodeRCount = 0;
    showAlert = true;
    cameraController.start();
    Navigator.pop(applicationContext!.currentContext!);
  }
}