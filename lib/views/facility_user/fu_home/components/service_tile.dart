import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class ServiceTile extends StatelessWidget {
  Function()? onclick;
  int total;
  int completed;
  int Tcompleted;
  String serviceName;
  String? graphTile2;
  bool isRpm;
  ServiceTile({Key? key,this.onclick,this.completed = 0 ,
    this.total = 0, this.serviceName = "", this.isRpm = false, this.graphTile2,this.Tcompleted = 0 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
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
            Text(serviceName,style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w600,
                fontSize: ApplicationSizing.constSize(26),
                color: appColor
            ),),
            Row(
              children: [
                !isRpm ? Container()
                    :Container(
                  margin: EdgeInsets.only(right: 10),
                      child: CircularPercentIndicator(
                  radius:  25.0,
                  lineWidth: 5.0,
                  percent: Tcompleted == 0 ? 0 : Tcompleted/ ((total == 0 || Tcompleted > total) ? Tcompleted : total),
                  center: Center(
                      child:Text("${Tcompleted}/${total}",
                        style: Styles.PoppinsRegular(
                            fontWeight: FontWeight.w600,
                            fontSize: ApplicationSizing.constSize(10),
                            color: appColorSecondary
                        ),),
                  ),
                  footer: Container(
                      padding: EdgeInsets.only(top: 5),
                      child:Text("Transmission Completed",
                        style: Styles.PoppinsRegular(
                            fontWeight: FontWeight.w600,
                            fontSize: ApplicationSizing.constSize(8),
                            color: appColorSecondary
                        ),),
                  ),
                  progressColor: Colors.green,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                    ),
                CircularPercentIndicator(
                  radius:  25.0,
                  lineWidth: 5.0,
                  percent: completed == 0 ? 0 : completed/((total == 0 || completed>total) ? completed : total),
                  center: Center(
                    child:Text("${completed}/${total}",
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
            )
          ],
        ),
      ),
    );
  }
}