import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_model.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/patient_tile.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/patient_summary.dart';

class PatientList extends HookWidget {
  List<PatientsModel> patientsList = [];
  ScrollController scrollController;
  bool lastIndexLoading;
   PatientList({required this.patientsList,required this.scrollController,required this.lastIndexLoading,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,index){
        if(index == patientsList.length){
          return Container(
            child: lastIndexLoading ? Container(
              // color: Colors.pink,
              height: 80,
              child: loader(radius: 15,),) : Container(
              height: 30,
            ),
          );
        }
          return InkWell(
            onTap: patientsList[index].isDisable??false ? null : (){
                Navigator.push(context, PageTransition(child: PatientSummary(patientsModel: patientsList[index],), type: PageTransitionType.leftToRight));
            },
              child: PatientTile(patientsList: patientsList[index],));
        },
        separatorBuilder: (context,index){
          return Container(height: 10,);
        },
        itemCount: patientsList.length+1
    );
  }
}
