import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/settings_services/p_settings_services/p_settings_service.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/settings_view_models/p_settings_view_models/p_settings_view_model.dart';
import 'package:twochealthcare/views/settings/p_settings/components/blue_button.dart';

class PSettings extends HookWidget {
  const PSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);
    PSettingsViewModel pSettingsViewModel = useProvider(pSettigsVMProvider);

    useEffect(
      () {
        pSettingsViewModel.initState();
        Future.microtask(() async {
          await pSettingsViewModel.checkIsBlueBottonConnected();
        });
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
      primary: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          centerWigets: AppBarTextStyle(
            text: "Settings",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              BlueButton(
                pSettingsViewModel: pSettingsViewModel,
              ),
              pSettingsViewModel.loadingSettings ? AlertLoader() : Container()
            ],
          ),
        ),
      ),
    );
  }
}
