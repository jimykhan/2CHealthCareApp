import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_model.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class UserInfoTile extends StatelessWidget {
  PatientsModel patientsModel;
  UserInfoTile({required this.patientsModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: CustomShadow.whiteBoxShadowWith15(),
      ),
      child: Row(
        children: [
          CircularImage(
            h: 55,
            w: 55,
            assetImage: true,
            imageUrl: "assets/icons/personIcon.png",
          ),
          ApplicationSizing.horizontalSpacer(n: 3),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(patientsModel.fullName??"",style: Styles.PoppinsRegular(
                    fontSize: ApplicationSizing.constSize(20),
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),),
                  Text(patientsModel.primaryPhoneNumber??"No Contact",style: Styles.PoppinsRegular(
                    fontSize: ApplicationSizing.constSize(12),
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              // color: Colors.black,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Male, ",
                      style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.constSize(12),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    TextSpan(
                      text: "3 Years",
                      style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.constSize(12),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
