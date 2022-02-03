import 'package:flutter/material.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_list.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class CenterText extends StatelessWidget {
  PatientsList patientsList;
  CenterText({required this.patientsList,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(patientsList.fullName??"",
          style: Styles.PoppinsRegular(
            fontSize: ApplicationSizing.constSize(16),
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),)
        ],
      ),
    );
  }
}
