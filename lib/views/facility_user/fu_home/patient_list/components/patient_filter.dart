import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/radio-button.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/chronic_care_view_model.dart';

class PatientsFilter extends HookWidget {
  PatientsFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChronicCareVM chronicCareVM = useProvider(fuChronicCareVMProvider);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 10),
            width: 100,
            height: 5,
            decoration: BoxDecoration(
                color: fontGrayColor, borderRadius: BorderRadius.circular(2)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              "Patients Filter",
              style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.constSize(20),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      chronicCareVM.setCareProviderFilter(1);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      // color: Colors.red,
                      margin: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing.horizontalMargin()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Me",
                            style: Styles.PoppinsRegular(
                                fontWeight: FontWeight.w400,
                                fontSize: ApplicationSizing.constSize(17),
                                color: Colors.black),
                          ),
                          RadioButton(
                            buttonSelected: chronicCareVM.careProviderId == 0
                                ? false
                                : true,
                            onchange: () {},
                            noText: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color(0xffC6C6C9),
                  ),
                  InkWell(
                    onTap: () {
                      chronicCareVM.setCareProviderFilter(0);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      // color: Colors.red,
                      margin: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing.horizontalMargin()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "All Care Coordinator",
                            style: Styles.PoppinsRegular(
                                fontWeight: FontWeight.w400,
                                fontSize: ApplicationSizing.constSize(17),
                                color: Colors.black),
                          ),
                          RadioButton(
                            buttonSelected: chronicCareVM.careProviderId == 0
                                ? true
                                : false,
                            onchange: () {},
                            noText: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
