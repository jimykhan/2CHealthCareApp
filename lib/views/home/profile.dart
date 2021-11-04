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
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/modalities_reading_vm.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';
import 'package:twochealthcare/views/readings/bg_reading.dart';
import 'package:twochealthcare/views/readings/blood_pressure_reading.dart';

class Profile extends HookWidget {
  Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    ProfileVm profileVm = useProvider(profileVMProvider);
    // final modalitiesReadingVM = useProvider(modalitiesReadingVMProvider);
    useEffect(
      () {
        Future.microtask(() async {
          profileVm.getUserInfo();
        });
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingButton(),
      body: _body(loginVM: loginVM, profileVm: profileVm),
    );
  }

  _body({LoginVM? loginVM, ProfileVm? profileVm}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ApplicationSizing.verticalSpacer(n: 30),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin()),
                  child: CircularImage(
                    w: ApplicationSizing.convert(110),
                    h: ApplicationSizing.convert(110),
                    imageUrl:
                        'https://www.propertytwinsswfl.com/wp-content/uploads/2018/09/dummy-profile-pic-male.jpg',
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20),
                  margin: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin()),
                  child: Column(
                    children: [
                      Text(
                        loginVM?.currentUser?.fullName ?? "",
                        style: Styles.PoppinsBold(
                            fontSize: ApplicationSizing.fontScale(22),
                            color: appColor),
                      ),
                      Text(
                        loginVM?.currentUser?.userName ?? "",
                        style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.fontScale(14),
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                ApplicationSizing.verticalSpacer(n: 10),
                ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return infoWidget(
                          widgetTitle: 'Care Provider',
                          key1: "Name",
                          value1: profileVm!.currentUserInfo
                                  ?.careProviders?[index].fullName ??
                              "");
                    },
                    separatorBuilder: (context, index) {
                      return ApplicationSizing.verticalSpacer();
                    },
                    itemCount:
                        profileVm!.currentUserInfo?.careProviders?.length ?? 0)
                // infoWidget(widgetTitle: "Care Provider Details",
                // key1: "Name",
                //   value1: "Jamshed khan"
                // )
              ],
            ),
            profileVm.loading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }
}
