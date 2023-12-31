import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
class ChangeFacilityTile extends StatelessWidget {
  Function() onClick;
  LoginVM loginVM;
   ChangeFacilityTile({required this.onClick,Key? key,required this.loginVM}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String faciilityName = "";
    loginVM.currentUser?.claims?.forEach((clam) {
      if(clam.claimType == "FacilityName"){
        faciilityName = clam.claimValue??"";
      }
    });
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 18),
        decoration: BoxDecoration(
          boxShadow: CustomShadow.whiteBoxShadowWith15(dy: 0,dx: 0),
          border: Border.all(
            color: fontGrayColor.withOpacity(0.5),
            width: 1
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset("assets/icons/facility_change_icon.svg"),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(loginVM.currentUser?.fullName?? "Demo Facilty",style: Styles.PoppinsRegular(
                      fontWeight: FontWeight.w600,
                      fontSize: ApplicationSizing.constSize(16),
                      color: Colors.black
                    ),),
                    Row(
                      children: [
                        Text("Current Facility: ",style: Styles.PoppinsRegular(
                            fontWeight: FontWeight.w600,
                            fontSize: ApplicationSizing.constSize(12),
                            color: fontGrayColor
                        ),),
                        Expanded(
                          child: Container(
                            // alignment: Alignment.center,
                            child: Text(faciilityName,style: Styles.PoppinsRegular(
                                fontWeight: FontWeight.w600,
                                fontSize: ApplicationSizing.constSize(12),
                                color: appColor
                            ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            SvgPicture.asset("assets/icons/arrow_down.svg"),
          ],
        ),
      ),
    );
  }
}
