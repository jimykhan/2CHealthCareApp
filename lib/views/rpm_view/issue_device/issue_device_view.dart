import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/buttons/icon_button.dart';
import 'package:twochealthcare/common_widgets/check_button.dart';
import 'package:twochealthcare/common_widgets/error_text.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/barcode_scan.dart';
import 'package:twochealthcare/views/rpm_view/issue_device/issue_device_vm.dart';

class IssuedDeviceView extends HookWidget {
  IssuedDeviceView(
      {Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IssuedDeviceVM issuedDeviceVM = useProvider(issuedDeviceVMProvider);
    useEffect(
          () {
        Future.microtask(() async {
        });
        issuedDeviceVM.initIssuedDeviceScreen();
        issuedDeviceVM.getRpmInventoryDeviceByFacilityId();
        issuedDeviceVM.checkUnbilledDeviceConfigClaimByPatientId();
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.white),
      margin: EdgeInsets.only(top: 200),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 10),
            width: 100,
            height: 5,
            decoration: BoxDecoration(
                color: fontGrayColor, borderRadius: BorderRadius.circular(4)),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Issued Device",
                      style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.constSize(20),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.only(bottom: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 24),
                            // height: 80,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTextField(
                                        checkFocus: (val){},
                                        onchange: issuedDeviceVM.onBarcodechange,
                                        textEditingController: issuedDeviceVM.scanBarcode,
                                        onSubmit: (val) {},
                                        hints: "Scan Device",
                                        color1: ((issuedDeviceVM.scanBarcode.text != "") && !issuedDeviceVM.isIssuedValid) ? errorColor : disableColor,

                                      ),
                                      ((issuedDeviceVM.scanBarcode.text != "") && !issuedDeviceVM.isIssuedValid)
                                          ? ErrorText(text: "Invalid Serial No")
                                          : Container(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SqureIconButton(onClick: () {
                                  Navigator.push(
                                      applicationContext!.currentContext!,
                                      PageTransition(
                                          child: BarcodeScan(fromPatinetSummary: true,),
                                          type: PageTransitionType.rightToLeft));
                                },
                                    svgPictureUrl : "assets/icons/home/barcode.svg"
                                ),
                              ],
                            ),
                          ),
                          CustomTextField(
                            checkFocus: (val){},
                            onchange: issuedDeviceVM.onBarcodechange,
                            textEditingController: TextEditingController()..text = issuedDeviceVM.issuedDevice?.serialNo??"",
                            onSubmit: (val) {},
                            hints: "Serial No",
                            isEnable: false,
                          ),
                          SizedBox(height: 15,),
                          CustomTextField(
                            checkFocus: (val){},
                            onchange: issuedDeviceVM.onBarcodechange,
                            textEditingController: TextEditingController()..text = issuedDeviceVM.issuedDevice?.macAddress??"",
                            onSubmit: (val) {},
                            hints: "IMEI No",
                            isEnable: false,
                          ),
                          SizedBox(height: 15,),
                          CustomTextField(
                            checkFocus: (val){},
                            onchange: issuedDeviceVM.onBarcodechange,
                            textEditingController: TextEditingController()..text = issuedDeviceVM.issuedDevice?.modalityName??"",
                            onSubmit: (val) {},
                            hints: "Modality Name",
                            isEnable: false,
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomCheckButton(ontap: issuedDeviceVM.onClickCPT994553, isChecked: issuedDeviceVM.cpt99453,),
                              SizedBox(width: 10,),
                              Text("CPT 99453",style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(14)),)
                            ],
                          ),
                          SizedBox(height: 10,),
                          issuedDeviceVM.cpt99453Message != "" ?
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: errorColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text("${issuedDeviceVM.cpt99453Message}"
                                ,style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(14),color: errorColor),)
                              )
                              : Container(),
                          SizedBox(height: 35,),
                          issuedDeviceVM.loading ? Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: loader(
                              color: whiteColor,
                            ),)
                              : FilledButton(onTap: issuedDeviceVM.isIssuedValid ? issuedDeviceVM.onIssuedDevice : null,
                            txt: "Issue",
                            color1: issuedDeviceVM.isIssuedValid ? appColor : appColor.withOpacity(0.3),
                            borderColor: issuedDeviceVM.isIssuedValid ? appColor : appColor.withOpacity(0.3),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}