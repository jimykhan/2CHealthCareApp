import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/menu_tile.dart';

class SliderMenu extends StatelessWidget {
  List<PatientSummaryMenu> menu;
   Function(int val) onMenuClick;
  SliderMenu({required this.menu,required this.onMenuClick,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: CustomShadow.whiteBoxShadowWith15(),
        // color: Colors.black.withOpacity(0.050)
      ),
      height: ApplicationSizing.constSize(55),
      child: ListView.separated(
        shrinkWrap: true,
          physics: ScrollPhysics(),
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
