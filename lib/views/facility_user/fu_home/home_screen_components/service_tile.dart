import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class ServiceTile extends StatelessWidget {
  ServiceTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
      padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
      decoration: BoxDecoration(
          boxShadow: CustomShadow.whiteBoxShadowWith15(dy: 0,dx: 0),
          border: Border.all(
              color: fontGrayColor.withOpacity(0.5),
              width: 1
          ),
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffF0F1F5)
        // gradient: LinearGradient(
        //   colors: [AppBarStartColor, AppBarEndColor],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // )
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("CCM",style: Styles.PoppinsRegular(
              fontWeight: FontWeight.w600,
              fontSize: ApplicationSizing.constSize(26),
              color: appColor
          ),),
          CircularPercentIndicator(
            radius:  25.0,
            lineWidth: 5.0,
            percent: 0.7,
            center: Center(
            child:Text("39/50",
              style: Styles.PoppinsRegular(
                  fontWeight: FontWeight.w600,
                  fontSize: ApplicationSizing.constSize(10),
                  color: appColorSecondary
              ),),
            ),
            footer: Container(
              padding: EdgeInsets.only(top: 5),
              child:Text("Time Completed",
                style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w600,
                    fontSize: ApplicationSizing.constSize(8),
                    color: appColorSecondary
                ),),
            ),
            progressColor: Colors.green,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}