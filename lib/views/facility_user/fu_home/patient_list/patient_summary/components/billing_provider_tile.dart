import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_model.dart';
import 'package:twochealthcare/models/facility_user_models/fu_profile_models/fu_profile_model.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class BillingProviderTile extends StatelessWidget {
  FUProfileModel billingProvider;
  BillingProviderTile({required this.billingProvider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.symmetric(vertical: 10),
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
        children: [
          CircularImage(
            h: 55,
            w: 55,
            assetImage: true,
            imageUrl: "assets/icons/personIcon.png",
          ),
          ApplicationSizing.horizontalSpacer(n: 10),
          Expanded(
            // flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${billingProvider.firstName} ${billingProvider.lastName}",
                    style: Styles.PoppinsRegular(
                      fontSize: ApplicationSizing.constSize(20),
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Text(
                    "${billingProvider.email}",
                    style: Styles.PoppinsRegular(
                      fontSize: ApplicationSizing.constSize(12),
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
