import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/radio-button.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/facility_user_models/facilityModel/facility_model.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';

import '../../../../services/auth_services/auth_services.dart';

class AllFacility extends StatelessWidget {
  List<FacilityModel> facilities = [];
  Function changeFacility;
  int selectedFacilityId;
  AllFacility(
      {Key? key,
      required this.facilities,
      required this.selectedFacilityId,
      required this.changeFacility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      "Change Facility",
                      style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.constSize(20),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: SingleChildScrollView(
                      child: ListView.separated(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                selectedFacilityId == facilities[index].id
                                    ? null
                                    : changeFacility(facilities[index].id);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 11),
                                // color: Colors.red,
                                margin: EdgeInsets.symmetric(
                                    horizontal: ApplicationSizing.horizontalMargin()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        facilities[index].facilityName ?? "",
                                        style: Styles.PoppinsRegular(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ApplicationSizing.constSize(17),
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      child: RadioButton(
                                        buttonSelected:
                                        selectedFacilityId == facilities[index].id,
                                        noText: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              // margin: EdgeInsets.symmetric(horizontal: 5,vertical: 11),
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Color(0xffC6C6C9),
                            );
                          },
                          itemCount: facilities.length),
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
