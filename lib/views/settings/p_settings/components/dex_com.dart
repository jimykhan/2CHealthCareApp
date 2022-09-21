import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/common_widgets/buttons/flexible_button.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/settings_view_models/p_settings_view_models/p_settings_view_model.dart';

class DexCom extends StatelessWidget {
  PSettingsViewModel pSettingsViewModel;
  DexCom({Key? key, required this.pSettingsViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 25)),
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Color(0xffDDDDDD),
                  width: 1.5
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xff00000026),
                    offset: Offset(0,0.10),
                    blurRadius: 40
                )
              ]
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        dexComIcon(),
                        SizedBox(width: 10,),
                        Text(
                          "CGM DexCom",
                          style: Styles.PoppinsRegular(
                              fontSize: 15, fontWeight: FontWeight.w600,
                              color: appColorSecondary
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        pSettingsViewModel.isDexComConnect ? SvgPicture.asset(
                          "assets/icons/blue_button_plugin.svg",
                          height: ApplicationSizing.convert(25),
                        )
                            : SvgPicture.asset(
                          "assets/icons/not_plug.svg",
                          height: ApplicationSizing.convert(25),
                        ),
                      ],
                    ),
                  ),


                ],
              ),

              SizedBox(height: 10,),

              Align(
                alignment: Alignment.centerRight,
                child: FlexibleButton(
                  child: pSettingsViewModel.getDexComUrlLoading ? loader(width: 30,) :
                  pSettingsViewModel.isDexComConnect ? Text("Medicare Claims Authorize",
                    style: Styles.PoppinsRegular(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ) : Text("Share Your Medicare Claims",
                    style: Styles.PoppinsRegular(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  ontap: () {
                    if(pSettingsViewModel.isDexComConnect){
                      SnackBarMessage(message: "DexCom access is already Authorized",error: false);
                    }else{
                      pSettingsViewModel.dexComAutherizations();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}

class dexComIcon extends StatelessWidget {
  const dexComIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        "assets/icons/dexcomlogo.svg",
        height: ApplicationSizing.constSize(43),
      ),
    );
  }
}

