import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/common_widgets/buttons/flexible_button.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/settings_view_models/p_settings_view_models/p_settings_view_model.dart';

class BlueButton extends StatelessWidget {
  PSettingsViewModel pSettingsViewModel;
  BlueButton({Key? key, required this.pSettingsViewModel}) : super(key: key);

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
                        BlueButtonIcon(),
                        SizedBox(width: 10,),
                        Text(
                          "Blue Button",
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
                        pSettingsViewModel.isBlueButtonConnected ? SvgPicture.asset(
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
                  child: pSettingsViewModel.getBlueButtonUrlLoading ? loader(width: 30,) : Text("Share Your Medicare Claims",
                    style: Styles.PoppinsRegular(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  ontap: () {
                    // if (!(pSettingsViewModel.isBlueButtonConnected))
                    pSettingsViewModel.blueButtonAutherizations();
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

class BlueButtonIcon extends StatelessWidget {
  const BlueButtonIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration:  BoxDecoration(
        gradient:  const RadialGradient(
          colors: [
            Color(0xff60A3CB),
            Color(0xff0089D7),
          ],
          radius: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        // color: Colors.red,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          "assets/icons/blue_button_icon.svg",
          height: ApplicationSizing.convert(25),
        ),
      ),
    );
  }
}

