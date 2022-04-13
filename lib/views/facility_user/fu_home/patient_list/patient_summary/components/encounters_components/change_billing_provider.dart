import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/drop_down/drop_down_button.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/heading_text/text_field_title.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/models/facility_user_models/FacilityUserListModel.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_encounter_vm.dart';
class ChangeBillingProvider extends HookWidget {
  const ChangeBillingProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RpmEncounterVM _rmpEncounterVM = useProvider(rpmEncounterVMProvider);
    useEffect(
          () {
            _rmpEncounterVM.isPasswordFieldValid = true;

        Future.microtask(() async {

        });
        return () {};
      },
      const [],
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      height: 250,

      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Container(
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //
              //           padding: EdgeInsets.only(right: 8, left: 8),
              //           decoration: BoxDecoration(
              //               border: Border.all(
              //                 color:  disableColor,
              //                 width:  1.2,
              //               ),
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(7)),
              //           child: DropdownButton(
              //             value: _rmpEncounterVM.selectedBillingProvider?.fullName??"",
              //             isExpanded: true,
              //             icon: const Icon(Icons.keyboard_arrow_down,
              //               size: 30,),
              //             // iconSize: 24,
              //             // elevation: 16,
              //             style: Styles.PoppinsRegular(
              //               fontSize: ApplicationSizing.fontScale(14),
              //             ),
              //
              //             underline: Container(),
              //             onChanged: _rmpEncounterVM.onChangeBillingProvider,
              //             // onChanged: _rmpEncounterVM.on,
              //             items: _rmpEncounterVM.billingProviders
              //                 .map<DropdownMenuItem>((FacilityUserListModel value) {
              //               return DropdownMenuItem(
              //                 value: value,
              //                 child:  Row(
              //                   children: [
              //                     Expanded(
              //                       child: Container(
              //                         alignment: Alignment.centerLeft,
              //                         // color: Colors.pink,
              //                         child: Text(value.fullName??"",
              //                           maxLines: 1,
              //                           style: Styles.PoppinsRegular(
              //                             fontSize: ApplicationSizing.fontScale(14),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //
              //               );
              //             })
              //                 .toList(),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(title: 'Provider Name',),
                    Container(margin: EdgeInsets.only(top: 1),
                      child: DropDownButton(dropDownValue: _rmpEncounterVM.selectedProviderName,
                        onChange: _rmpEncounterVM.onChangeBillingProvider,
                        menuList: _rmpEncounterVM.billingProvidersName,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: CustomTextField(
                  onchange: _rmpEncounterVM.onChangePassword,
                  textEditingController: _rmpEncounterVM.passwordController,
                  textInputType: TextInputType.text,
                  hints: "Password",
                  color1:
                  _rmpEncounterVM.isPasswordFieldValid ? disableColor : errorColor,
                  onSubmit: (val) {
                    _rmpEncounterVM.fieldValidation(val);
                  },
                  // trailingIcon: ,
                  obscureText: _rmpEncounterVM.obscureText,
                  trailingIcon: InkWell(
                    onTap: () {
                      _rmpEncounterVM.obscureText = !_rmpEncounterVM.obscureText;
                      _rmpEncounterVM.notifyListeners();
                    },
                    child: Container(
                      child: !_rmpEncounterVM.obscureText
                          ? Icon(
                        IcoFontIcons.eye,
                        color: Colors.green.shade600,
                        // color: Colors.grey.shade500,
                      )
                          : Icon(
                        IcoFontIcons.eyeBlocked,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
            // padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(flex: 1,
                  child: FilledButton(onTap: (){
                    Navigator.pop(context);
                  },
                    color1: appColorSecondary,
                    borderColor: appColorSecondary,
                    txt: "Close".toUpperCase(),
                    paddingLeftRight: 0,
                    fontsize: 13,
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(flex: 1,
                    child: _rmpEncounterVM.checkProviderLoading ? SimpleLoader()
                        : FilledButton(
                      onTap: _rmpEncounterVM.isPasswordFieldValid ? _rmpEncounterVM.isValidUser : null,
                      color1: _rmpEncounterVM.isPasswordFieldValid? appColor : appColorLight,
                      borderColor: _rmpEncounterVM.isPasswordFieldValid? appColor : appColorLight,
                      txt: "Proceed".toUpperCase(),
                      paddingLeftRight: 0,
                      fontsize: 13,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
