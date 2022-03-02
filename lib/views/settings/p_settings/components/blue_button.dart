import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/settings_view_models/p_settings_view_models/p_settings_view_model.dart';

class BlueButton extends StatelessWidget {
  PSettingsViewModel pSettingsViewModel;
  BlueButton({Key? key, required this.pSettingsViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Blue Button",
            style: Styles.PoppinsRegular(
                fontSize: 18, fontWeight: FontWeight.w500),
          ),
          pSettingsViewModel.getBlueButtonUrlLoading
              ? loader(
                  width: 150,
                )
              : FilledButton(
                  w: 150,
                  h: 35,
                  onTap: () {
                    if (!(pSettingsViewModel.isBlueButtonConnected))
                      pSettingsViewModel.blueButtonAutherizations();
                  },
                  txt: pSettingsViewModel.isBlueButtonConnected
                      ? "Connected"
                      : "Not Connect",
                  color1: pSettingsViewModel.isBlueButtonConnected
                      ? appColor
                      : Colors.red,
                  borderColor: pSettingsViewModel.isBlueButtonConnected
                      ? appColor
                      : Colors.red,
                ),
        ],
      ),
    );
  }
}
