import 'package:flutter/material.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class bpReadingInTable extends StatelessWidget {
  List<BloodPressureReadingModel> bPReadings = [];
  bpReadingInTable({Key? key, required this.bPReadings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String measureDate = "00 000 00";
    bPReadings.sort((a, b) {
      return b.measurementDate!.compareTo(a.measurementDate!);
      // return b.measurementDate.compareTo(a.measurementDate);
    });
    return Container(
      child: ListView.separated(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            if (measureDate !=
                bPReadings[index].measurementDate!.substring(0, 9)) {
              measureDate = bPReadings[index].measurementDate!.substring(0, 9);
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ApplicationSizing.horizontalMargin()),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        measureDate,
                        style: Styles.PoppinsRegular(
                          fontWeight: FontWeight.bold,
                          fontSize: ApplicationSizing.fontScale(16),
                          color: fontGrayColor,
                        ),
                      ),
                    ),
                    ApplicationSizing.horizontalSpacer(n: 5),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 20,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: appColor.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                bPReadings[index]
                                    .measurementDate!
                                    .substring(11),
                                style: Styles.PoppinsRegular(
                                    fontSize: ApplicationSizing.fontScale(16),
                                    color: fontGrayColor),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: bPReadings[index]
                                                    .heartRate
                                                    ?.toStringAsFixed(0) ??
                                                "",
                                            style: Styles.PoppinsBold(
                                              fontSize:
                                                  ApplicationSizing.fontScale(
                                                      20),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            )),
                                        TextSpan(
                                            text: "HR",
                                            style: Styles.PoppinsRegular(
                                              fontSize:
                                                  ApplicationSizing.fontScale(
                                                      10),
                                              color: Colors.red,
                                            )),
                                      ]),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: ApplicationSizing
                                              .horizontalMargin(n: 5)),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: bPReadings[index]
                                                      .highPressure
                                                      ?.toStringAsFixed(0) ??
                                                  "",
                                              style: Styles.PoppinsBold(
                                                fontSize:
                                                    ApplicationSizing.fontScale(
                                                        20),
                                                fontWeight: FontWeight.bold,
                                                color: appColor,
                                              )),
                                          TextSpan(
                                              text: "Sys",
                                              style: Styles.PoppinsRegular(
                                                fontSize:
                                                    ApplicationSizing.fontScale(
                                                        10),
                                                color: appColor,
                                              )),
                                        ]),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: bPReadings[index]
                                                    .lowPressure
                                                    ?.toStringAsFixed(0) ??
                                                "",
                                            style: Styles.PoppinsBold(
                                              fontSize:
                                                  ApplicationSizing.fontScale(
                                                      20),
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff1D3D71),
                                            )),
                                        TextSpan(
                                            text: "Dia",
                                            style: Styles.PoppinsRegular(
                                              fontSize:
                                                  ApplicationSizing.fontScale(
                                                      10),
                                              color: Color(0xff1D3D71),
                                            )),
                                      ]),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ApplicationSizing.horizontalMargin()),
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 20,
                right: 10,
              ),
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 1, color: appColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          bPReadings[index].measurementDate!.substring(11),
                          style: Styles.PoppinsRegular(
                              fontSize: ApplicationSizing.fontScale(16),
                              color: fontGrayColor),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: bPReadings[index]
                                            .heartRate
                                            ?.toStringAsFixed(0) ??
                                        "",
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
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      ApplicationSizing.horizontalMargin(n: 5)),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: bPReadings[index]
                                              .highPressure
                                              ?.toStringAsFixed(0) ??
                                          "",
                                      style: Styles.PoppinsBold(
                                        fontSize:
                                            ApplicationSizing.fontScale(20),
                                        fontWeight: FontWeight.bold,
                                        color: appColor,
                                      )),
                                  TextSpan(
                                      text: "Sys",
                                      style: Styles.PoppinsRegular(
                                        fontSize:
                                            ApplicationSizing.fontScale(10),
                                        color: appColor,
                                      )),
                                ]),
                              ),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: bPReadings[index]
                                            .lowPressure
                                            ?.toStringAsFixed(0) ??
                                        "",
                                    style: Styles.PoppinsBold(
                                      fontSize: ApplicationSizing.fontScale(20),
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1D3D71),
                                    )),
                                TextSpan(
                                    text: "Dia",
                                    style: Styles.PoppinsRegular(
                                      fontSize: ApplicationSizing.fontScale(10),
                                      color: Color(0xff1D3D71),
                                    )),
                              ]),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return ApplicationSizing.verticalSpacer();
          },
          itemCount: bPReadings.length),
    );
  }

  bpReading({double? sys, double? dia, int? hr}) {
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
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: ApplicationSizing.horizontalMargin(n: 5)),
          child: RichText(
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
