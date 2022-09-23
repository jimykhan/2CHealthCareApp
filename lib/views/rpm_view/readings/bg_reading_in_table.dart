import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class bGReadingInTable extends HookWidget {
  List<BGDataModel> bGReadings = [];
  bGReadingInTable({Key? key, required this.bGReadings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    String measureDate = "00 000 00";
    bGReadings.sort((a, b) {
      return b.measurementDate!.compareTo(a.measurementDate!);
      // return b.measurementDate.compareTo(a.measurementDate);
    });
    return Container(
      color: Colors.white,
      child: ListView.separated(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            // if (measureDate !=
            //     bGReadings[index].measurementDate!.substring(0, 9)) {
            //   measureDate = bGReadings[index].measurementDate!.substring(0, 9);
            //   return Container(
            //     margin: EdgeInsets.symmetric(
            //         horizontal: ApplicationSizing.horizontalMargin()),
            //     child: Column(
            //       children: [
            //         Container(
            //           margin: EdgeInsets.only(bottom: 5),
            //           alignment: Alignment.centerLeft,
            //           child: Text(
            //             measureDate,
            //             style: Styles.PoppinsRegular(
            //               fontWeight: FontWeight.bold,
            //               fontSize: ApplicationSizing.fontScale(16),
            //               color: fontGrayColor,
            //             ),
            //           ),
            //         ),
            //         ApplicationSizing.horizontalSpacer(n: 5),
            //         Container(
            //           padding: const EdgeInsets.only(
            //             top: 5,
            //             bottom: 5,
            //             left: 20,
            //             right: 10,
            //           ),
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //                 width: 1, color: appColor.withOpacity(0.5)),
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.white,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Color(0Xff1d161712),
            //                 blurRadius: 20,
            //                 offset: Offset(4, 10), // Shadow position
            //               ),
            //             ],
            //           ),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                 flex: 1,
            //                 child: Container(
            //                   alignment: Alignment.centerLeft,
            //                   child: Text(
            //                     bGReadings[index]
            //                         .measurementDate!
            //                         .substring(11),
            //                     style: Styles.PoppinsRegular(
            //                         fontSize: ApplicationSizing.fontScale(16),
            //                         color: fontGrayColor),
            //                   ),
            //                 ),
            //               ),
            //               Expanded(
            //                   flex: 3,
            //                   child: Container(
            //                     alignment: Alignment.centerRight,
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.end,
            //                       children: [
            //                         Container(
            //                           margin: EdgeInsets.symmetric(
            //                               horizontal: ApplicationSizing
            //                                   .horizontalMargin(n: 5)),
            //                           child: RichText(
            //                             text: TextSpan(children: [
            //                               TextSpan(
            //                                   text: bGReadings[index]
            //                                           .bg
            //                                           ?.toStringAsFixed(0) ??
            //                                       "",
            //                                   style: Styles.PoppinsBold(
            //                                     fontSize:
            //                                         ApplicationSizing.fontScale(
            //                                             20),
            //                                     fontWeight: FontWeight.bold,
            //                                     color: appColor,
            //                                   )),
            //                               TextSpan(
            //                                   text: bGReadings[index].bgUnit ??
            //                                       "",
            //                                   style: Styles.PoppinsRegular(
            //                                     fontSize:
            //                                         ApplicationSizing.fontScale(
            //                                             10),
            //                                     color: appColor,
            //                                   )),
            //                             ]),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ))
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   );
            // }
            bool showDate = false;
            if(measureDate != bGReadings[index].measurementDate!.substring(0, 9)){
              measureDate = bGReadings[index].measurementDate!.substring(0, 9);
              showDate = true;
            }
            return Column(
              children: [
                Container(
                  child:   !showDate ? Container() :
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ApplicationSizing.horizontalMargin(n: 18)),
                    child: Column(
                      children: [
                         Row(
                           children: [
                             Expanded(
                               child: Text(
                                  measureDate,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.PoppinsBold(
                                    fontSize: ApplicationSizing.fontScale(16),
                                    color: fontGrayColor,
                                  ),
                                ),
                             ),
                           ],
                         ),
                        ApplicationSizing.horizontalSpacer(),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin()),
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: appColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0Xff1d161712),
                        blurRadius: 20,
                        offset: Offset(4, 10), // Shadow position
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [

                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        bGReadings[index].measurementDate!.substring(11),
                                        style: Styles.PoppinsBold(
                                          fontSize: ApplicationSizing.fontScale(16),
                                          color: fontGrayColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              ApplicationSizing.horizontalMargin(n: 5)),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: bGReadings[index]
                                                      .bg
                                                      ?.toStringAsFixed(0) ??
                                                  "",
                                              style: Styles.PoppinsBold(
                                                fontSize:
                                                    ApplicationSizing.fontScale(20),
                                                fontWeight: FontWeight.bold,
                                                color: appColor,
                                              )),
                                          TextSpan(
                                              text: bGReadings[index].bgUnit ?? "",
                                              style: Styles.PoppinsRegular(
                                                fontSize:
                                                    ApplicationSizing.fontScale(10),
                                                color: appColor,
                                              )),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return ApplicationSizing.verticalSpacer();
          },
          itemCount: bGReadings.length),
    );
  }

  bpReading({double? sys, double? dia, int? hr}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "80",
                  style: Styles.PoppinsBold(
                    fontSize: ApplicationSizing.fontScale(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  )),
              TextSpan(
                  text: "HR",
                  style: Styles.PoppinsRegular(
                    fontSize: ApplicationSizing.fontScale(10),
                    color: Colors.red,
                  )),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(
              horizontal: ApplicationSizing.horizontalMargin(n: 5)),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "80",
                  style: Styles.PoppinsBold(
                    fontSize: ApplicationSizing.fontScale(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  )),
              TextSpan(
                  text: "HR",
                  style: Styles.PoppinsRegular(
                    fontSize: ApplicationSizing.fontScale(10),
                    color: Colors.red,
                  )),
            ]),
          ),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "80",
                style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
            TextSpan(
                text: "HR",
                style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(8),
                  color: Colors.red,
                )),
          ]),
        ),
      ],
    );
  }

  bgReading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "80",
                style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
            TextSpan(
                text: "HR",
                style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(8),
                  color: Colors.red,
                )),
          ]),
        ),
      ],
    );
  }
}
