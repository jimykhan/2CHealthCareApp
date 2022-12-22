import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/barcode_view_model.dart';
class VerifyBarcode extends StatelessWidget {
  BarcodeVM? barcodeVM;
  VerifyBarcode({this.barcodeVM,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      // margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/2.8),
      decoration: BoxDecoration(
        color: whiteColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
              onchange: (val){},
              onSubmit: (val){},
              checkFocus: (c){},
              textEditingController: barcodeVM?.verifyBarcodeText,
          ),
          SizedBox(height: 40,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                    onTap: barcodeVM?.onCancel,
                  h: 30,
                  w: 80,
                  txt: "Close",
                  color1: errorColor,
                  borderColor: errorColor,
                  paddingLeftRight: 0,
                ),
                SizedBox(width: 10,),
                FilledButton(
                  onTap: (){},
                  h: 30,
                  w: 80,
                  txt: "Send",
                  paddingLeftRight: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
