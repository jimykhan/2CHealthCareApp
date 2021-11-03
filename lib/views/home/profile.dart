import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/modalities_reading_vm.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';
import 'package:twochealthcare/views/readings/bg_reading.dart';
import 'package:twochealthcare/views/readings/blood_pressure_reading.dart';
class Profile extends HookWidget {
  Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final sharedPrefService = useProvider(sharedPrefServiceProvider);
    // final modalitiesReadingVM = useProvider(modalitiesReadingVMProvider);
    useEffect(
          () {
        Future.microtask(() async {});
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: Container(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Profile",
            ),
          ),
        ),
        floatingActionButtonLocation:  FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
        body: _body(),
    );
  }
  _body({SharedPrefServices? sharedPrefServices,ModalitiesReadingVM? modalitiesReadingVM}){
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ApplicationSizing.verticalSpacer(n: 30),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
            child: CircularImage(
              w: ApplicationSizing.convert(110),
              h: ApplicationSizing.convert(110),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
            child: Column(
              children: [
                Text("Jamshed khan",
                style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(20),
                  fontWeight: FontWeight.w600,
                  color: appColor
                ),),
                Text("jamshed@gmail.com",
                style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(12),
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),),
              ],
            ),
          ),
          ApplicationSizing.verticalSpacer(n:10),
          infoWidget(widgetTitle: "Care Provider Details",
          key1: "Name",
            value1: "Jamshed khan"
          )

        ],
      ),
    );
  }
}