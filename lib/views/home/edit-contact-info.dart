import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/check_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/error_text.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/common_widgets/mask_formatter.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/common_widgets/verification_mark.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/app_data_models/country_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';

class EditContactInfo extends HookWidget {
  const EditContactInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);
    ProfileVm profileVM = useProvider(profileVMProvider);
    useEffect(
      () {
        profileVM.initEditContactInfo();

        Future.microtask(() async {
          // await profileVM.getAllCountry();
        });

        return () {
          profileVM.disposeEditContactInfo();
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        primary: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
          child: CustomAppBar(
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(70),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Update Contact Info",
            ),
            trailingIcon: InkWell(
              onTap: () {
                if (profileVM.checkRequireFieldValid()) {
                  profileVM.editPatientContactInfo();
                }
              },
              child: Container(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.check,
                  color: appColor,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            _body(profileVm: profileVM),
            profileVM.loading ? AlertLoader() : Container(),
          ],
        ));
  }

  _body({required ProfileVm profileVm}) {
    return Container(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ApplicationSizing.verticalSpacer(n: 15),
                _contactInfomation(profileVm: profileVm),
                ApplicationSizing.verticalSpacer(n: 15),
                _currentAddress(profileVm: profileVm),
                ApplicationSizing.verticalSpacer(n: 15),
                _mailingAddress(profileVm: profileVm),
                ApplicationSizing.verticalSpacer(n: 80),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: 10),
          //     padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
          //     child: profileVm.loading ? loader() : CustomFilledButton(
          //       onTap: (){
          //         profileVm.editPatientContactInfo();
          //       },
          //       txt: "Update",
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  _contactInfomation({required ProfileVm profileVm}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin()),
                  decoration: boxDecoration,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Text(
                          "Contact Infomation",
                          style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w700,
                              fontSize: ApplicationSizing.fontScale(15),
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Primary Phone *",
                          style: Styles.PoppinsBold(
                              fontSize: ApplicationSizing.fontScale(12),
                              color: Colors.black),
                        ),
                      ),
                      isContactVerified(
                          isVerified:
                              profileVm.patientInfo?.phoneNumberConfirmed ??
                                  false),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 50,
                        padding: EdgeInsets.only(right: 0, left: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: disableColor,
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(7)),
                        child: Text(
                          "+1 US",
                          style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.fontScale(14),
                          ),
                        ),
                        // child: DropdownButton(
                        //   value: profileVm.countryCallingCode,
                        //   isExpanded: true,
                        //   icon: const Icon(
                        //     Icons.keyboard_arrow_down,
                        //     size: 30,
                        //   ),
                        //   // iconSize: 24,
                        //   // elevation: 16,
                        //   style: Styles.PoppinsRegular(
                        //     fontSize: ApplicationSizing.fontScale(14),
                        //   ),
                        //   underline: Container(),
                        //   onChanged: (val){},
                        //   items: ["+1"]
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       // enabled: false,
                        //       // onTap: (){},
                        //       value: value,
                        //       child: Text(
                        //         "${value} US",
                        //         style: Styles.PoppinsRegular(
                        //           fontSize: ApplicationSizing.fontScale(14),
                        //         ),
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                      ),

                      // Container(
                      //   width: 120,
                      //   height: 50,
                      //   padding: EdgeInsets.only(right: 0, left: 5),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: disableColor,
                      //         width: 1.2,
                      //       ),
                      //       borderRadius: BorderRadius.circular(7)),
                      //   child: DropdownButton(
                      //     value: profileVm.selectedCountry,
                      //     isExpanded: true,
                      //     icon: const Icon(
                      //       Icons.keyboard_arrow_down,
                      //       size: 30,
                      //     ),
                      //     // iconSize: 24,
                      //     // elevation: 16,
                      //     style: Styles.PoppinsRegular(
                      //       fontSize: ApplicationSizing.fontScale(14),
                      //     ),
                      //     underline: Container(),
                      //     onChanged: profileVm.onCountryCodeChange,
                      //     items: profileVm.countryList
                      //         .map<DropdownMenuItem>((CountryModel value) {
                      //       return DropdownMenuItem(
                      //         value: value,
                      //         child: Text(
                      //           "${value.callingCode} ${value.code2}",
                      //           style: Styles.PoppinsRegular(
                      //             fontSize: ApplicationSizing.fontScale(14),
                      //           ),
                      //         ),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: CustomTextField(
                                  checkFocus: (val){},
                                  inputFormatter: [MaskFormatter("000-000-0000")],
                                  onchange: profileVm.onPrimaryPhoneChange,
                                  textEditingController: profileVm.primaryPhoneEditController,
                                  textInputType: TextInputType.phone,
                                  hints: "Primary Contact",
                                  color1: profileVm.isPrimaryPhoneFieldValid
                                      ? disableColor
                                      : errorColor,
                                  onSubmit: (val) {
                                    profileVm.isFieldEmpty(text: val, fieldType: "PH");
                                  },
                                ),
                              ),
                              profileVm.isPrimaryPhoneFieldValid
                                  ? Container()
                                  : ErrorText(text: profileVm.primaryPhoneErrorText),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Secondary Phone",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    inputFormatter: [MaskFormatter("000-000-0000")],
                    onchange: (val) {},
                    textEditingController:
                        profileVm.secondaryPhoneEditController,
                    textInputType: TextInputType.phone,
                    hints: "Secondary Phone",
                    // color1:
                    // profileVm.isPrimaryPhoneFieldValid ? disableColor : errorColor,
                    onSubmit: (val) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _currentAddress({required ProfileVm profileVm}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin()),
                  decoration: boxDecoration,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Current Address",
                            style: Styles.PoppinsRegular(
                                fontWeight: FontWeight.w700,
                                fontSize: ApplicationSizing.fontScale(15),
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Current Address *",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    onchange: profileVm.onCurrentAddressChange,
                    textEditingController:
                        profileVm.currentAddressEditController,
                    textInputType: TextInputType.text,
                    hints: "Current Address",
                    color1: profileVm.isCurrentAddressFieldValid
                        ? disableColor
                        : errorColor,
                    onSubmit: (val) {
                      profileVm.isFieldEmpty(text: val, fieldType: "CA");
                    },
                  ),
                ),
                profileVm.isCurrentAddressFieldValid
                    ? Container()
                    : ErrorText(text: profileVm.currentAddressErrorText),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Zip Code *",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    inputFormatter: [MaskFormatter("00000")],
                    onchange: profileVm.oncAZipCodeChange,
                    textEditingController: profileVm.cAZipCodeEditController,
                    textInputType: TextInputType.number,
                    hints: "Zip Code",
                    color1: profileVm.isCAZipCodePhoneFieldValid
                        ? disableColor
                        : errorColor,
                    onSubmit: (val) {
                      profileVm.isFieldEmpty(text: val, fieldType: "CAZC");
                    },
                  ),
                ),
                profileVm.isCAZipCodePhoneFieldValid
                    ? Container()
                    : ErrorText(text: profileVm.cAZipCodeErrorText),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "City",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    onchange: (val) {},
                    textEditingController: profileVm.cACityEditController,
                    textInputType: TextInputType.text,
                    hints: "City",
                    // color1:
                    // profileVm.isPrimaryPhoneFieldValid ? disableColor : errorColor,
                    onSubmit: (val) {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "State",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    onchange: (val) {},
                    textEditingController: profileVm.cAStateEditController,
                    textInputType: TextInputType.text,
                    hints: "State",
                    // color1:
                    // profileVm.isPrimaryPhoneFieldValid ? disableColor : errorColor,
                    onSubmit: (val) {
                      profileVm.filterStateList = [];
                      profileVm.notifyListeners();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin(),
                      vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            profileVm.cAStateEditController?.text =
                                profileVm.filterStateList[index].name ?? "";
                            profileVm.filterStateList = [];
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              profileVm.filterStateList[index].name ?? "",
                              style: Styles.PoppinsRegular(
                                fontSize: ApplicationSizing.fontScale(14),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: fontGrayColor,
                        );
                      },
                      itemCount: profileVm.filterStateList.length),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _mailingAddress({required ProfileVm profileVm}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin()),
                  decoration: boxDecoration,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Mailing Address",
                            style: Styles.PoppinsRegular(
                                fontWeight: FontWeight.w700,
                                fontSize: ApplicationSizing.fontScale(15),
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ApplicationSizing.verticalSpacer(),
          Row(
            children: [
              Expanded(
                  child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomCheckButton(
                      ontap: profileVm.onClickCheckButton,
                      isChecked: profileVm.isMailingSame,
                    ),
                    ApplicationSizing.horizontalSpacer(n: 5),
                    Expanded(
                      child: Text(
                        "Mailing address is same",
                        style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.fontScale(12),
                            color: appColor,
                            fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Mailing Address",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    onchange: (val) {},
                    textEditingController: profileVm.isMailingSame
                        ? profileVm.currentAddressEditController
                        : profileVm.mailingAddressEditController,
                    textInputType: TextInputType.text,
                    hints: "Mailing Address",
                    onSubmit: (val) {
                      // profileVm.isFieldEmpty(text: val, fieldType: "CA");
                    },
                    isEnable: !profileVm.isMailingSame,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Zip Code",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    isEnable: !profileVm.isMailingSame,
                    onchange: (val) {},
                    textEditingController: profileVm.isMailingSame
                        ? profileVm.cAZipCodeEditController
                        : profileVm.mAZipCodeEditController,
                    textInputType: TextInputType.number,
                    hints: "Zip Code",
                    // color1:
                    // profileVm.isMAZipCodePhoneFieldValid ? disableColor : errorColor,
                    onSubmit: (val) {
                      // profileVm.isFieldEmpty(text: val, fieldType: "CAZC");
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "City",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    isEnable: !profileVm.isMailingSame,
                    onchange: (val) {},
                    textEditingController: profileVm.isMailingSame
                        ? profileVm.cACityEditController
                        : profileVm.mACityEditController,
                    textInputType: TextInputType.text,
                    hints: "City",
                    // color1:
                    // profileVm.isPrimaryPhoneFieldValid ? disableColor : errorColor,
                    onSubmit: (val) {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "State",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    isEnable: !profileVm.isMailingSame,
                    onchange: (val) {},
                    textEditingController: profileVm.isMailingSame
                        ? profileVm.cAStateEditController
                        : profileVm.mAStateEditController,
                    textInputType: TextInputType.text,
                    hints: "State",
                    // color1:
                    // profileVm.isPrimaryPhoneFieldValid ? disableColor : errorColor,
                    onSubmit: (val) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

isContactVerified({required bool isVerified}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      VerificationMark(
        isVerified: isVerified,
      ),
      ApplicationSizing.horizontalSpacer(n: 5),
      Container(
        child: Text(
          isVerified ? "Verified" : "Not Verified",
          style: Styles.PoppinsRegular(
              color: isVerified ? appColor : Colors.red,
              fontSize: ApplicationSizing.fontScale(11),
              fontWeight: FontWeight.w700),
        ),
      )
    ],
  );
}
