

import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class CustomAppBar extends StatelessWidget {
  BuildContext? parentContext;
  Function()? clickOnDrawer;
  Color? color1;
  Color? color2;
  Widget? leadingIcon;
  Widget? trailingIcon;
  Widget? centerWigets;
  double? hight;
  double? paddingBottom;
  bool? isbottomLine;
  CustomAppBar({
   @required this.parentContext,this.color1,this.color2,this.leadingIcon,
    this.trailingIcon,this.centerWigets, @required this.hight,this.paddingBottom,this.isbottomLine =false,
    this.clickOnDrawer
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ApplicationSizing.convert(80),
      decoration: BoxDecoration(
      ),
      child:  Container(
        padding: EdgeInsets.only(
            left: ApplicationSizing.convertWidth(20),
            right: ApplicationSizing.convertWidth(20),
          top: ApplicationSizing.convert(30)
        ),
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [color1??AppBarStartColor,color2??AppBarEndColor],
          //   end: Alignment.centerRight,
          //   begin: Alignment.centerLeft,
          // ),
          // color: Colors.red
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: clickOnDrawer,
                //     () async {
                //   // await FlutterBlue.instance.stopScan();
                //   Navigator.pushReplacement(context,
                //       PageTransition(
                //           child: HealthDevicesScreen(),
                //           type: PageTransitionType.fade
                //       ));
                // },
                child: leadingIcon ?? Icon(Icons.menu,
                  size: ApplicationSizing.convert(25),
                ) ,
              ),
              centerWigets ??  Container(),
              trailingIcon ?? Container(),
            ],
          ),
      ),
    );
  }

  _message(context,{bool notification = true}){
    return Container(
      padding: EdgeInsets.only(
        top: ApplicationSizing.convert(30),
      ),
      child: InkWell(
        onTap: () async {
          // await FlutterBlue.instance.stopScan();
          // Navigator.pushReplacement(context,
          //     PageTransition(
          //         child: DeviceState(),
          //         type: PageTransitionType.fade
          //     ));
        },
        child: Column(
          children: [
            Container(
              // child: Icon(FontAwesomeIcons.angleDoubleDown)
            ),
            Container(
              padding: EdgeInsets.only(
                  top: ApplicationSizing.convert(5),
                  right: ApplicationSizing.convertWidth(10)
              ),
              child: Text(
                "Add device",
                style: Styles.PoppinsRegular(
                  color: Colors.black,
                  fontSize: ApplicationSizing.fontScale(12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
