import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class NoData extends StatelessWidget {
  double paddingFormTop;
   NoData({this.paddingFormTop = 50, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingFormTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20,bottom: 20),
            child: Text("No Record Found",
            style: Styles.PoppinsRegular(
              fontSize: ApplicationSizing.fontScale(18),
              fontWeight: FontWeight.w700,
              color: appColorSecondary
            ),),
          ),
          Container(

            alignment: Alignment.center,
            child: Image.asset("assets/icons/no_result.png"),
          ),
          Container(
            margin: EdgeInsets.only(top: 20,bottom: 10),
            child: Text("Ooops!",
              style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(18),
                  fontWeight: FontWeight.w700,
                color: appColorSecondary

              ),),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n:50)),
            child: Text("There is no record based on the details you entered.",
              style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(12),
                  fontWeight: FontWeight.w400,
                color: appColorSecondary
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
