import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_model.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/tile_components/center_text.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/tile_components/profile_image.dart';

class PatientTile extends StatelessWidget {
  PatientsModel patientsList;
  PatientTile({required this.patientsList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.constSize(20),
          vertical: ApplicationSizing.constSize(4)),
      padding: EdgeInsets.only(
          top: ApplicationSizing.constSize(10),
          right: ApplicationSizing.constSize(10),
          left: ApplicationSizing.constSize(10),
          bottom: ApplicationSizing.constSize(7)),
      decoration: BoxDecoration(
          border: Border.all(color: fontGrayColor.withOpacity(0.3), width: 1),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImage(),
              Expanded(
                  flex: 9,
                  child: CenterText(
                    patientsList: patientsList,
                  )),
              Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      patientsList.lastAppLaunchDate == null
                          ? Container()
                          : SvgPicture.asset(patientsList.isActve ?? false
                              ? "assets/icons/fu_icons/enablePhone.svg"
                              : "assets/icons/fu_icons/disablePhone.svg"),
                    ],
                  ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 60),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                patientsList.isBHIRevoked ?? false
                    ? serviceCircle(text: "RPM", color: Color(0xff134389))
                    : Container(),
                patientsList.isCCMRevoked ?? false
                    ? serviceCircle(text: "CCM")
                    : Container(),
                patientsList.isRPMRevoked ?? false
                    ? serviceCircle(text: "BHI", color: Color(0xffA148AF))
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  serviceCircle({Color? color, String? text}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? appColor,
      ),
      padding: EdgeInsets.all(5),
      child: Text(
        text ?? "",
        style: Styles.PoppinsRegular(fontSize: 8, color: Colors.white),
      ),
    );
  }
}
