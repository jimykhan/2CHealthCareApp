import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/verification_mark.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_profile_view_model.dart';
import 'package:twochealthcare/views/auths/otp_verification.dart';
import 'package:twochealthcare/views/facility_user/fu_home/components/verified_info.dart';

class FUProfile extends HookWidget {
  FUProfile({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    FUProfileVM fuProfileVM = useProvider(fuProfileVMProvider);
    // HomeVM homeVM = useProvider(homeVMProvider);
    // ApplicationRouteService applicationRouteService =
    // useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
      () {
        Future.microtask(() async {
          fuProfileVM.getFuProfileInfo();
        });
        return () {};
      },
      const [],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
        child: CustomAppBar(
          leadingIcon: Container(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(80),
          parentContext: context,
          centerWigets: AppBarTextStyle(
            text: "My Profile",
          ),
        ),
      ),
      body: _body(context, fuProfileVM: fuProfileVM),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingButton(),
    );
  }

  _body(context, {required FUProfileVM fuProfileVM}) {
    return Stack(
      children: [
        Container(
            child: fuProfileVM.fuProfileModel == null
                ? Column(
                    children: [
                      NoData(),
                    ],
                  )
                : Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ApplicationSizing.horizontalMargin()),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              boxShadow: CustomShadow.whiteBoxShadowWith15(
                                  dy: 0, dx: 0),
                              border: Border.all(
                                  color: fontGrayColor.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffF0F1F5)),
                          child: Row(
                            children: [
                              CircularImage(
                                h: 80,
                                w: 80,
                                imageUrl: "assets/icons/personIcon.png",
                                assetImage: true,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${fuProfileVM.fuProfileModel?.firstName} ${fuProfileVM.fuProfileModel?.lastName}",
                                      style: Styles.PoppinsRegular(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${fuProfileVM.fuProfileModel?.email}",
                                      style: Styles.PoppinsRegular(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: fontGrayColor),
                                    ),
                                    Text(
                                      "${fuProfileVM.fuProfileModel?.phoneNo}",
                                      style: Styles.PoppinsRegular(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: fontGrayColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: fontGrayColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text("Organizational Information",
                                style: Styles.PoppinsRegular(
                                  fontSize: ApplicationSizing.constSize(14),
                                  color: appColorSecondary,
                                  fontWeight: FontWeight.w700
                                ),),
                              ),
                              VerifiedInfo(isVerified: fuProfileVM.fuProfileModel?.isPhoneNumberVerified?? false,
                                textInfo: fuProfileVM.fuProfileModel?.phoneNo ?? "",
                                textInfoTitle: "Phone No.",
                                ontap: fuProfileVM.fuProfileModel?.isPhoneNumberVerified?? false ? (){
                                  // Navigator.push(context,
                                  //     PageTransition(child: OtpVerification(userName: fuProfileVM.fuProfileModel?.userName??"",
                                  //       phone: fuProfileVM.fuProfileModel?.phoneNo,
                                  //       isForgetPassword: false,
                                  //       userId: fuProfileVM.fuProfileModel?.userName??"",
                                  //     ), type: PageTransitionType.leftToRight)
                                  // );
                                } : null,
                              ),

                              keyValue(
                                  key: "Facility Name",
                                  value: fuProfileVM.fuProfileModel?.facilityDto?.facilityName ??
                                      ""),

                              keyValue(
                                  key: "Secondary No.",
                                  value: fuProfileVM.fuProfileModel?.phoneNo ??
                                      ""),
                              VerifiedInfo(isVerified: fuProfileVM.fuProfileModel?.isEmailVerified?? false,
                                textInfo: fuProfileVM.fuProfileModel?.email ?? "",
                                textInfoTitle: "Email",
                                ontap: fuProfileVM.fuProfileModel?.isEmailVerified?? false ? (){
                                  // Navigator.push(context,
                                  //     PageTransition(child: OtpVerification(userName: fuProfileVM.fuProfileModel?.userName??"",
                                  //       phone: fuProfileVM.fuProfileModel?.phoneNo,
                                  //       isForgetPassword: false,
                                  //       userId: fuProfileVM.fuProfileModel?.userName??"",
                                  //     ), type: PageTransitionType.leftToRight)
                                  // );
                                } : null,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
        fuProfileVM.loadingProfile ? AlertLoader() : Container(),
      ],
    );
  }

  keyValue({required String key, required String value,Widget? customWidget}) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: fontGrayColor.withOpacity(0.3)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(70, 141, 255, 0.27),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              key,
              style:
                  Styles.PoppinsRegular(color: appColorSecondary, fontSize: 14),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: customWidget?? Text(
                value,
                style: Styles.PoppinsRegular(
                    color: appColor, fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
