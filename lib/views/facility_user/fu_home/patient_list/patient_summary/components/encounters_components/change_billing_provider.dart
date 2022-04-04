import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_encounter_vm.dart';
class ChangeBillingProvider extends HookWidget {
  const ChangeBillingProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RpmEncounterVM _rmpEncounterVM = useProvider(rpmEncounterVMProvider);
    useEffect(
          () {
        Future.microtask(() async {

        });
        return () {};
      },
      const [],
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      height: 250,

      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            // padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(flex: 1,
                  child: FilledButton(onTap: (){
                    Navigator.pop(context);
                  },
                    color1: appColorSecondary,
                    borderColor: appColorSecondary,
                    txt: "Close".toUpperCase(),
                    paddingLeftRight: 0,
                    fontsize: 13,
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(flex: 1,
                    child: _rmpEncounterVM.addEncounterLoader ? SimpleLoader() : FilledButton(onTap: _rmpEncounterVM.isFormValid ? (){
                      // _rmpEncounterVM.addRpmEncounter(patientId: patientId);
                    } : null,
                      color1: _rmpEncounterVM.isFormValid? appColor : appColorLight,
                      borderColor: _rmpEncounterVM.isFormValid? appColor : appColorLight,
                      txt: "Proceed".toUpperCase(),
                      paddingLeftRight: 0,
                      fontsize: 13,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
