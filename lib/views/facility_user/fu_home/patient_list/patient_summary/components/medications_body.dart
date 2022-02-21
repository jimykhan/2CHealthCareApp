import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/common_container.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/headline_text_style.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';
class MedicationsBody extends HookWidget {
  const MedicationsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(
          () {
            print("init call of medications");
        Future.microtask(() async {});
        return () {};
      },
      const [],
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadLineTextStyle(text: "Medication Records",),
          medicineTile(),
          SizedBox(height: 10,),
          medicineTile(),
          SizedBox(height: 10,),
          medicineTile(),
          SizedBox(height: 10,),
          medicineTile(),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  medicineTile(){
    return CommonContainer(
      horizontalPadding: 8,
      child: Row(
        children: [
          Expanded(
              flex:4,
              child: Container(
                // color: Colors.green,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Medicine name",style: Styles.PoppinsRegular(
                          fontWeight: FontWeight.w500,
                          fontSize: ApplicationSizing.constSize(18),
                          color: Colors.black
                        ),),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SvgPicture.asset("assets/icons/medicine_info_icon.svg"))
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(
                      // color: Colors.black,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              // color: Colors.red,
                              child: Row(
                                children: [
                                Text("Start date: ",
                                style: Styles.PoppinsRegular(
                                  fontSize: ApplicationSizing.constSize(10),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),),
                                Text("Dec 12 2020",
                                style: Styles.PoppinsRegular(
                                  fontSize: ApplicationSizing.constSize(10),
                                  fontWeight: FontWeight.w500,
                                  color: appColor,
                                ),),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              // color: Colors.blue,
                              child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Text("End date: ",
                                style: Styles.PoppinsRegular(
                                  fontSize: ApplicationSizing.constSize(10),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),),
                                Text("Dec 12 2021",
                                style: Styles.PoppinsRegular(
                                  fontSize: ApplicationSizing.constSize(10),
                                  fontWeight: FontWeight.w500,
                                  color: appColor,
                                ),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              )
          ),
          Expanded(
              flex:1,
              child: Container(
                // color: Colors.pink,
                child: Column(
                  children: [
                    Text("5",style: Styles.PoppinsRegular(
                      fontWeight: FontWeight.w500,
                      fontSize: ApplicationSizing.constSize(20)
                    ),),
                    Text("Dose",style: Styles.PoppinsRegular(
                      fontWeight: FontWeight.w500,
                      fontSize: ApplicationSizing.constSize(14),
                      color: appColor
                    ),),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: appColor
                      ),
                      child: Text("Started",style: Styles.PoppinsRegular(
                        fontWeight: FontWeight.w500,
                        fontSize: ApplicationSizing.constSize(7),
                        color: whiteColor
                      ),),
                    ),
                  ],
                )
              )
          ),

        ],
      ),);
  }
}
