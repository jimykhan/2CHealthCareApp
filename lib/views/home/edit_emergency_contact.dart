import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/back_button.dart';
import 'package:twochealthcare/common_widgets/check_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/error_text.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/common_widgets/mask_formatter.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';

class EditEmergencyContact extends HookWidget {
   EditEmergencyContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService =
    useProvider(applicationRouteServiceProvider);
    ProfileVm profileVM = useProvider(profileVMProvider);
    useEffect(
          () {
        profileVM.initEditContactInfo();
        Future.microtask(() async {});

        return () {
          profileVM.disposeEditContactInfo();
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Update Emergency Contact",
            ),
            trailingIcon: InkWell(
              onTap: (){
                profileVM.editPatientContactInfo();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.check,
                  color: appColor,),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            _body(context,profileVm: profileVM),
            profileVM.loading ? AlertLoader() : Container(),
          ],
        )
    );
  }

  _body(context,{required ProfileVm profileVm}) {
    return Container(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ApplicationSizing.verticalSpacer(n: 15),
                _contactInfomation(context,profileVm: profileVm),
                ApplicationSizing.verticalSpacer(n: 15),


              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: 10),
          //     padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
          //     child: profileVm.loading ? loader() : FilledButton(
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
    String dropdownValue = "Spouse";
  _contactInfomation(context,{required ProfileVm profileVm}) {
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
                          "Emergency Contact",
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
                  child: RichText(
                    text: TextSpan(
                      text: "Name",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    onchange: (val) {},
                    textEditingController: profileVm.secondaryPhoneEditController,
                    textInputType: TextInputType.phone,
                    hints: "Name",
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
                      text: "Primary Phone",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    inputFormatter: [MaskFormatter("000-000-0000")],
                    onchange: (val) {},
                    textEditingController: profileVm.secondaryPhoneEditController,
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

          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Relationship",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: dropDown(context),
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
                    inputFormatter: [MaskFormatter("000-000-0000")],
                    onchange: (val) {},
                    textEditingController: profileVm.secondaryPhoneEditController,
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
  Widget dropDown(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 8, left: 8),
            decoration: BoxDecoration(
                border: Border.all(
                  color:  disableColor,
                  width:  1.2,
                ),
                borderRadius: BorderRadius.circular(7)),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
              size: 30,),
              // iconSize: 24,
              // elevation: 16,
              style: Styles.PoppinsRegular(
                fontSize: ApplicationSizing.fontScale(14),
              ),
              underline: Container(),
              onChanged: (String? newValue) {
                // setState(() {
                //   dropdownValue = newValue!;
                // });
              },
              items: Strings.relationshipList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                  style: Styles.PoppinsRegular(
                    fontSize: ApplicationSizing.fontScale(14),
                  ),
                  ),
                );
              })
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
