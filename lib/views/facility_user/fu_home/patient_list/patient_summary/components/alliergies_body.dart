import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/models/patient_summary/allergy_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/common_container.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/headline_text_style.dart';

class AllergiesBody extends HookWidget {
  AllergiesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FUPatientSummaryVM _fuPatientSummaryVM =
        useProvider(fUPatientSummaryVMProvider);
    useEffect(
      () {
        print("init call of allegies");
        Future.microtask(() async {
          await _fuPatientSummaryVM.getAllergyByPatientId();
        });
        return () {};
      },
      const [],
    );
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadLineTextStyle(
            text: "Allergies",
          ),
          SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              _fuPatientSummaryVM.isLoading
                  ? AlertLoader(bottomMargin: 350)
                  : _fuPatientSummaryVM.medicationList.length == 0
                      ? NoData()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return allergeTile(
                                allergyModel:
                                    _fuPatientSummaryVM.allergyList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: _fuPatientSummaryVM.allergyList.length)
            ],
          ),
        ],
      ),
    );
  }

  allergeTile({required AllergyModel allergyModel}) {
    return CommonContainer(
      horizontalPadding: 8,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                // color: Colors.green,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          allergyModel.agent ?? "",
                          style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w500,
                              fontSize: ApplicationSizing.constSize(18),
                              color: Colors.black),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SvgPicture.asset(
                                "assets/icons/medicine_info_icon.svg"))
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: [
                          createRandomBox(
                              allergyModel.reaction ?? "", Color(0xffFF3E39)),
                          createRandomBox("category", Color(0xffEF831F)),
                          createRandomBox("type", Color(0xff18A9C9))
                        ],
                        // children: ["Allergy", "Allergy", "Allergy"]
                        //     .map((e) => createRandomBox(e))
                        //     .toList(),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.pink,
                  child: Column(
                children: [
                  Text(
                    allergyModel.createdOn ?? "",
                    style: Styles.PoppinsRegular(
                        fontWeight: FontWeight.w500,
                        fontSize: ApplicationSizing.constSize(10),
                        color: appColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: appColorSecondary),
                    child: Text(
                      allergyModel.isActiveState ?? false
                          ? "InActive"
                          : "Active",
                      style: Styles.PoppinsRegular(
                          fontWeight: FontWeight.w500,
                          fontSize: ApplicationSizing.constSize(10),
                          color: whiteColor),
                    ),
                  ),
                ],
              ))),
        ],
      ),
    );
  }

  Widget createRandomBox(String text, Color color) {
    // Color ramdomColor = randomColorPick();
    Color ramdomColor = color;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: ramdomColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: Styles.PoppinsRegular(
            fontSize: ApplicationSizing.constSize(10),
            color: ramdomColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
