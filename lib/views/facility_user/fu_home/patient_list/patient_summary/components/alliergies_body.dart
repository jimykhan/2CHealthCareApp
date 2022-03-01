import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/common_container.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/headline_text_style.dart';

class AllergiesBody extends HookWidget {
  AllergiesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        print("init call of allegies");
        Future.microtask(() async {});
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
            height: 10,
          ),
          allergeTile(),
          SizedBox(
            height: 10,
          ),
          allergeTile(),
          SizedBox(
            height: 10,
          ),
          allergeTile(),
          SizedBox(
            height: 10,
          ),
          allergeTile(),
        ],
      ),
    );
  }

  allergeTile() {
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
                          "Allergies ",
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
                        children: ["Allergy", "Allergy", "Allergy"]
                            .map((e) => createRandomBox(e))
                            .toList(),
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
                    "Dec 20 2020",
                    style: Styles.PoppinsRegular(
                        fontWeight: FontWeight.w500,
                        fontSize: ApplicationSizing.constSize(10),
                        color: appColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: appColorSecondary),
                    child: Text(
                      "Active",
                      style: Styles.PoppinsRegular(
                          fontWeight: FontWeight.w500,
                          fontSize: ApplicationSizing.constSize(8),
                          color: whiteColor),
                    ),
                  ),
                ],
              ))),
        ],
      ),
    );
  }

  Widget createRandomBox(String text) {
    Color ramdomColor = randomColorPick();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
