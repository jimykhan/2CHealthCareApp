import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:rive/rive.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/barcode_view_model.dart';
class VerifyBarcode extends HookWidget {
  VerifyBarcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarcodeVM barcodeVM = useProvider(barcodeVMProvider);
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
              textEditingController: barcodeVM.verifyBarcodeText,
          ),
          Container(
                 child: Row(
                   children:  [
                     Expanded(child: Text("Sync barcode automatic in ${barcodeVM.syncTime} second")),
                   ],
                 ),
               ),
          SizedBox(height: 40,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomFilledButton(
                    onTap: barcodeVM.closeAlert,
                  h: 30,
                  w: 80,
                  txt: "Close",
                  color1: errorColor,
                  borderColor: errorColor,
                  paddingLeftRight: 0,
                ),
                SizedBox(width: 10,),
                barcodeVM.sendingBarCode ? CustomFilledButton(
                  onTap: (){},
                  h: 30,
                  w: 80,
                  txt: "Retry",
                  paddingLeftRight: 0,
                ) : loader(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class SucessIcon extends StatelessWidget {
  const SucessIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          height: ApplicationSizing.convert(200),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const RiveAnimation.asset('assets/rive_animation_file/done.riv'),
        ),
      ),
    );
  }
}

