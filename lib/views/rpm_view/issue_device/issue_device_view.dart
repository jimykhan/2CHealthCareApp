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
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/barcode_scan.dart';
import 'package:twochealthcare/views/rpm_view/issue_device/enum.dart';
import 'package:twochealthcare/views/rpm_view/issue_device/issue_device_vm.dart';

class IssuedDeviceView extends HookWidget {
  List<ModalitiesModel>? modalities = [];
  IssuedDeviceView(
      {Key? key,this.modalities})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IssuedDeviceVM issuedDeviceVM = useProvider(issuedDeviceVMProvider);
    useEffect(
          () {
        Future.microtask(() async {
        });
        issuedDeviceVM.initIssuedDeviceScreen(modalities: modalities);
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                          ? ErrorText(text: Strings.ScanDeviceNotFound)
                                          : Container(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SqureIconButton(
                                    onClick: () {
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
                          Column(
                            children: [
                              CustomTextField(
                                checkFocus: (val){},
                                onchange: issuedDeviceVM.onBarcodechange,
                                textEditingController: TextEditingController()..text = issuedDeviceVM.issuedDevice?.modalityName??"",
                                onSubmit: (val) {},
                                hints: "Modality Name",
                                color1: issuedDeviceVM.modalityAleadyAssign ? errorColor : disableColor,
                                isEnable: false,
                              ),
                              (issuedDeviceVM.modalityAleadyAssign)
                                  ? ErrorText(text: Strings.AleadyDeviceAssignText+" ${issuedDeviceVM.issuedDevice?.serialNo}")
                                  : Container(),
                            ],
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
                          issuedDeviceVM.issuedDevice != null ? (issuedDeviceVM.issuedDevice!.status == PHDeviceStatus.Active.index) ? Container() :
                          GestureDetector(
                            onTap: issuedDeviceVM.ActiveDeviceAlert,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: errorColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(Strings.AlertToActiveDevice
                                  ,style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(14),color: errorColor),)
                            ),
                          )
                              : Container(),
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
                              : CustomFilledButton(onTap: (issuedDeviceVM.isIssuedValid && !issuedDeviceVM.modalityAleadyAssign&& (issuedDeviceVM.issuedDevice!.status == PHDeviceStatus.Active.index)) ? issuedDeviceVM.issuedDeviceAlert : null,
                            txt: "Issue",
                            color1: (issuedDeviceVM.isIssuedValid && !issuedDeviceVM.modalityAleadyAssign && (issuedDeviceVM.issuedDevice!.status == PHDeviceStatus.Active.index)) ? appColor : appColor.withOpacity(0.3),
                            borderColor: (issuedDeviceVM.isIssuedValid && !issuedDeviceVM.modalityAleadyAssign && (issuedDeviceVM.issuedDevice!.status == PHDeviceStatus.Active.index)) ? appColor : appColor.withOpacity(0.3),
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