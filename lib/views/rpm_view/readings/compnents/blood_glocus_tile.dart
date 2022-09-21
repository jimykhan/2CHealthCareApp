import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class BloodGlocusTile extends StatelessWidget {
  String date;
  String time;
  int reading;
   BloodGlocusTile({Key? key,required this.time,required this.date,required this.reading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      date,
                      style: Styles.PoppinsBold(
                        fontSize: ApplicationSizing.fontScale(16),
                        color: fontGrayColor,
                      ),
                    ),
                    ApplicationSizing.horizontalSpacer(),
                    Text(
                      time,
                      style: Styles.PoppinsBold(
                        fontSize: ApplicationSizing.fontScale(16),
                        color: fontGrayColor,
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
                              text: "${reading}",
                              style: Styles.PoppinsBold(
                                fontSize:
                                ApplicationSizing.fontScale(20),
                                fontWeight: FontWeight.bold,
                                color: appColor,
                              )),
                          TextSpan(
                              text: "mg/dL",
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
    );
  }
}
