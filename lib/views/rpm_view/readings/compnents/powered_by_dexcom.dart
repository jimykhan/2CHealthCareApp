import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class PoweredByDexcom extends StatelessWidget {
  const PoweredByDexcom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 20),vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("CGM DATA BY",style: Styles.PoppinsRegular(fontSize: 10,color: fontGrayColor),),
              ),
              Container(
                child: Image.asset("assets/icons/dexcom_logo.png",width: 80,color: Color(0xff29b34b),),
              )
            ],
          ),
        ],
      ),
    );
  }
}
