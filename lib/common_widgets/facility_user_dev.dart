import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
class FacilityUserDev extends HookWidget {
  const FacilityUserDev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    OnLaunchActivityAndRoutesService onLaunchActivityService = useProvider(onLaunchActivityServiceProvider);
    return InkWell(
      onTap: (){
        onLaunchActivityService.HomeDecider();
      },
      child: Container(
        width: 120,
        // color: Colors.blue,
        child: Row(
          children: [
            Expanded(
              child: Text(
                loginVM.getCurrentFacilityName(),
                style: Styles.PoppinsRegular(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: appColorSecondary
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Container(
              // width: 40,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: appColorWithOpacity,
                  borderRadius: BorderRadius.circular(8)
              ),
                child: SvgPicture.asset("assets/icons/facility_change_icon.svg",height: 24,)),
          ],
        ),
      ),
    );
  }
}
