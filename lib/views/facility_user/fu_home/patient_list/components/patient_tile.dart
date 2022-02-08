import 'package:flutter/material.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_list.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/tile_components/center_text.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/tile_components/profile_image.dart';

class PatientTile extends StatelessWidget {
  PatientsList patientsList;
   PatientTile({required this.patientsList,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: ApplicationSizing.constSize(25)),
      padding:  EdgeInsets.all(ApplicationSizing.constSize(8)),
      decoration: BoxDecoration(
        border: Border.all(
          color: fontGrayColor.withOpacity(0.3),
          width: 1
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImage(),
          CenterText(patientsList: patientsList,),
        ],
      ),
    );
  }
}
