import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/menu_tile.dart';

class SliderMenu extends HookWidget {
  List<PatientSummaryMenu> menu;
   Function(int val) onMenuClick;
  SliderMenu({required this.menu,required this.onMenuClick,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FUPatientSummaryVM fuPatientSummaryVM = useProvider(fUPatientSummaryVMProvider);
    return Container(
      decoration: BoxDecoration(
        // boxShadow: CustomShadow.whiteBoxShadowWith15(),
        // color: Colors.black.withOpacity(0.050)
      ),
      height: ApplicationSizing.constSize(55),
      child: ScrollablePositionedList.separated(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemScrollController: fuPatientSummaryVM.categoryScrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return InkWell(
              onHover: (val){

              },
              onTap: ()=> onMenuClick(index),
            //   onTap: ()=> {
            //   onMenuClick(){
            //   return index;
            // }
            // },
              child: Container(
                margin: index == 0 ? EdgeInsets.only(left: 45) : index == menu.length -1 ? EdgeInsets.only(right: 45) : EdgeInsets.zero,
                  child: MenuTile(isSelected: menu[index].isSelected,menuText: menu[index].menuText, index: index,)),
            );
          },
          separatorBuilder: (context,index){
            return SizedBox(
              width: ApplicationSizing.constSize(8),
            );
          },
          itemCount: menu.length),
    );
  }
}
