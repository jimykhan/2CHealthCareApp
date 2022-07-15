import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/constants/validator.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/forget-password-vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/modalities_reading_vm.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/auths/otp_verification.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';
import 'package:twochealthcare/views/home/edit-contact-info.dart';
import 'package:twochealthcare/views/home/edit_emergency_contact.dart';
import 'package:twochealthcare/views/readings/bg_reading.dart';
import 'package:twochealthcare/views/readings/blood_pressure_reading.dart';

class Profile extends HookWidget {
  Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    ProfileVm profileVm = useProvider(profileVMProvider);
    ForgetPasswordVM forgetPasswordVM = useProvider(forgetPasswordVMProvider);
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);
    // final modalitiesReadingVM = useProvider(modalitiesReadingVMProvider);
    useEffect(
      () {
        Future.microtask(() async {
          await profileVm.getUserInfo();
          await profileVm.getAllCountry();
        });
        return () {
          applicationRouteService.removeScreen(screenName: "Profile");
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
          facilityIcon: false,
          // leadingIcon: Container(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          centerWigets: AppBarTextStyle(
            text: "My Profile",
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingButton(),
      body: _body(context,
          loginVM: loginVM,
          profileVm: profileVm,
          forgetPasswordVM: forgetPasswordVM),
    );
  }

  _body(
    context, {
    LoginVM? loginVM,
    ProfileVm? profileVm,
    ForgetPasswordVM? forgetPasswordVM,
  }) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ApplicationSizing.verticalSpacer(n: 1),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin()),
                  child: CircularImage(
                    w: ApplicationSizing.convert(100),
                    h: ApplicationSizing.convert(100),
                    imageUrl: "assets/icons/personIcon.png",
                    assetImage: true,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
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
                infoWidget(
                  widgetTitle: 'Care Provider',
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            tile(
                                key: "Name",
                                value: profileVm!
                                        .patientCareProvider[index].name ??
                                    ""),
                            tile(
                                key: "Email",
                                // value: profileVm.currentUserInfo?.careProviders?[index].e??""
                                value: profileVm
                                        .patientCareProvider[index].email ??
                                    ""),
                            tile(
                                key: "Contact No",
                                // value: profileVm.currentUserInfo?.careProviders?[index].e??""
                                value: profileVm
                                        .patientCareProvider[index].phoneNoWithCountryCallingCode ??
                                    ""),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return ApplicationSizing.verticalSpacer();
                      },
                      itemCount: profileVm!.patientCareProvider.length),
                ),
                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget(
                  widgetTitle: 'Personal Information',
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "Name",
                                      value: profileVm.patientInfo?.fullName ??
                                          ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "EmrId",
                                      value:
                                          profileVm.patientInfo?.patientEmrId ??
                                              ""),
                                )),
                          ],
                        ),
                        ApplicationSizing.verticalSpacer(n: 5),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "Sex",
                                      value: profileVm.patientInfo?.sex ?? ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Date of Birth",
                                      value:
                                          profileVm.patientInfo?.dateOfBirth ??
                                              ""),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget(
                  widgetTitle: 'Contact Information',
                  trallingWidget: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: EditContactInfo(),
                              type: PageTransitionType.bottomToTop));
                    },
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: ApplicationSizing.fontScale(15),
                            ),
                            ApplicationSizing.horizontalSpacer(n: 3),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Edit",
                                style: Styles.PoppinsRegular(
                                    color: Colors.white,
                                    fontSize: ApplicationSizing.fontScale(12)),
                              ),
                            )
                          ],
                        )),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: tile(
                                          key: "Primary Phone No.",
                                          value: profileVm.patientInfo?.homePhoneCountryCallingCode ?? ""),
                                    ),
                                    profileVm.patientInfo == null
                                        ? Container()
                                        : InkWell(
                                            onTap: profileVm.patientInfo
                                                        ?.phoneNumberConfirmed ??
                                                    false
                                                ? null
                                                : () {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            child:
                                                                OtpVerification(
                                                              userName: profileVm
                                                                      .patientInfo
                                                                      ?.userName ??
                                                                  "",
                                                              phone: profileVm
                                                                  .patientInfo
                                                                  ?.homePhoneCountryCallingCode,
                                                              isForgetPassword:
                                                                  false,
                                                              userId: profileVm
                                                                      .patientInfo
                                                                      ?.userId ??
                                                                  "",
                                                              isPhoneVerification:
                                                                  true,
                                                            ),
                                                            type: PageTransitionType
                                                                .leftToRight));
                                                  },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: ApplicationSizing
                                                      .horizontalMargin()),
                                              child: isContactVerified(
                                                  isVerified: profileVm
                                                          .patientInfo
                                                          ?.phoneNumberConfirmed ??
                                                      false),
                                            ),
                                          ),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Secondary Contact No.",
                                      value:
                                          profileVm.patientInfo?.personNumber ??
                                              ""),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget(
                  widgetTitle: 'Current Address',
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "Current Address",
                                      value: profileVm
                                              .patientInfo?.currentAddress ??
                                          ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "City",
                                      value: profileVm.patientInfo?.city ?? ""),
                                )),
                          ],
                        ),
                        ApplicationSizing.verticalSpacer(n: 5),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "State",
                                      value:
                                          profileVm.patientInfo?.state ?? ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Zip Code",
                                      value: profileVm.patientInfo?.zip ?? ""),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget(
                  widgetTitle: 'Mailing Address',
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "Mailing Address",
                                      value: profileVm
                                              .patientInfo?.mailingAddress ??
                                          ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "City",
                                      value: profileVm.patientInfo
                                              ?.maillingAddressCity ??
                                          ""),
                                )),
                          ],
                        ),
                        ApplicationSizing.verticalSpacer(n: 5),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "State",
                                      value: profileVm.patientInfo
                                              ?.maillingAddressState ??
                                          ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Zip Code",
                                      value: profileVm.patientInfo
                                              ?.maillingAddressZipCode ??
                                          ""),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget(
                  widgetTitle: 'Preferences',
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "Best time to call",
                                      value: profileVm
                                              .patientInfo?.bestTimeToCall ??
                                          ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Preferred Language",
                                      value: profileVm
                                              .patientInfo?.preferredLanguage ??
                                          ""),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget(
                  widgetTitle: 'Emergency Contact',
                  trallingWidget: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: EditEmergencyContact(),
                              type: PageTransitionType.bottomToTop));
                    },
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: ApplicationSizing.fontScale(15),
                            ),
                            ApplicationSizing.horizontalSpacer(n: 3),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Edit",
                                style: Styles.PoppinsRegular(
                                    color: Colors.white,
                                    fontSize: ApplicationSizing.fontScale(12)),
                              ),
                            )
                          ],
                        )),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "Name",
                                      value: profileVm.patientInfo
                                              ?.emergencyContactName ??
                                          ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Relationship",
                                      value: profileVm.patientInfo
                                              ?.emergencyContactRelationship ??
                                          ""),
                                )),
                          ],
                        ),
                        ApplicationSizing.verticalSpacer(n: 5),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: tile(
                                      key: "Primary Phone",
                                      value: profileVm.patientInfo
                                              ?.emergencyContactPrimaryPhoneNo ??
                                          ""),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Secondary Phone",
                                      value: profileVm.patientInfo
                                              ?.emergencyContactSecondaryPhoneNo ??
                                          ""),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 70),

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
