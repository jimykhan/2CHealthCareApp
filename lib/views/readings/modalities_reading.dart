import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/readings/blood_pressure_reading.dart';
class ModalitiesReading extends StatelessWidget {
   ModalitiesReading({Key? key}) : super(key: key);

  List items = [
    {
      "modalityName":"Blood Pressure",
      "reading":"180 sys 90 dia",
      "context":"this is something",
      "icon":"assets/icons/readings/blood-glucose-icon.svg",
      "color":const Color(0xffFD5C58)
    },

    {
      "modalityName":"Blood Pressure",
      "reading":"180 sys 90 dia",
      "context":"this is something",
      "icon":"assets/icons/readings/blood-glucose-icon.svg",
      "color":const Color(0xffFFA654)
    },

    {
      "modalityName":"Blood Pressure",
      "reading":"180 sys 90 dia",
      "context":"this is something",
      "icon":"assets/icons/readings/blood-glucose-icon.svg",
      "color":const Color(0xff548EFF)
    },

    {
      "modalityName":"Blood Pressure",
      "reading":"180 sys 90 dia",
      "context":"this is something",
      "icon":"assets/icons/readings/blood-glucose-icon.svg",
      "color":const Color(0xffBE54FF)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(right:ApplicationSizing.convertWidth(10)),
                child: RotatedBox(
                    quarterTurns: 2,child: SvgPicture.asset("assets/icons/home/right-arrow-icon.svg")),
              ),
            ),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "My Readings",
            ),
          ),
        ),
        body: _body());
  }
  _body(){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ApplicationSizing.verticalSpacer(n: 20),
            Container(
              child:ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        if(index == 0){
                          Navigator.push(context, PageTransition(
                              child: BloodPressureReading(), type: PageTransitionType.bottomToTop));
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: items[index]["color"],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(items[index]["modalityName"],
                                    style: Styles.PoppinsRegular(
                                      fontSize: ApplicationSizing.fontScale(12),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text("27-Jul-2021 11:30 PM",
                                    style: Styles.PoppinsRegular(
                                      fontSize: ApplicationSizing.fontScale(8),
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:2,
                                    child: Container(
                                      alignment: Alignment.center,
                                        child: SvgPicture.asset(items[index]["icon"]))),
                                Expanded(
                                  flex:5,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "190",
                                                  style: Styles.PoppinsRegular(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: ApplicationSizing.fontScale(30),
                                                    color: Colors.white
                                                  )
                                                ),
                                                TextSpan(
                                                  text: "sys",
                                                  style: Styles.PoppinsRegular(
                                                    fontSize: ApplicationSizing.fontScale(10),
                                                    color: Colors.white
                                                  )
                                                ),
                                              ]
                                            )
                                        ),
                                        ApplicationSizing.horizontalSpacer(),
                                        RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "90",
                                                  style: Styles.PoppinsRegular(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: ApplicationSizing.fontScale(30),
                                                    color: Colors.white
                                                  )
                                                ),
                                                TextSpan(
                                                  text: "dia",
                                                  style: Styles.PoppinsRegular(
                                                    fontSize: ApplicationSizing.fontScale(10),
                                                    color: Colors.white
                                                  )
                                                ),
                                              ]
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                            ApplicationSizing.verticalSpacer(),
                            Row(
                              children: [
                                Expanded(
                                    flex:2,
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Before Meal",
                                                      style: Styles.PoppinsRegular(
                                                          fontSize: ApplicationSizing.fontScale(10),
                                                          color: Colors.white
                                                      )
                                                  ),
                                                  TextSpan(
                                                      text: "",
                                                      style: Styles.PoppinsRegular(
                                                          fontSize: ApplicationSizing.fontScale(10),
                                                          color: Colors.white
                                                      )
                                                  ),
                                                ]
                                            )
                                        ),
                                    )
                                ),
                                Expanded(
                                  flex:5,
                                  child: Container(
                                  ),
                                )

                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return Container(
                      height: 10,
                    );
                  },
                  itemCount: items.length),
            ),
            ApplicationSizing.verticalSpacer(),
          ],
        ),
      ),
    );
  }
}
