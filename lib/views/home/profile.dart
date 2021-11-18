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
  _body({LoginVM? loginVM,ProfileVm? profileVm}){
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
                ApplicationSizing.verticalSpacer(n:10),
                infoWidget
                  (
                    widgetTitle: 'Care Provider',
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context,index){
                          return Column(
                            children: [
                              tile(
                                  key: "Name",
                                  value: profileVm!.patientCareProvider[index].name??""
                              ),
                              tile(
                                  key: "Email",
                                  // value: profileVm.currentUserInfo?.careProviders?[index].e??""
                                  value: profileVm.patientCareProvider[index].email??""
                              ),

                              tile(
                                  key: "Contact No",
                                  // value: profileVm.currentUserInfo?.careProviders?[index].e??""
                                  value: profileVm.patientCareProvider[index].contactNo??""
                              ),

                            ],
                          );
                        },
                        separatorBuilder: (context,index){
                          return ApplicationSizing.verticalSpacer();
                        },
                        itemCount: profileVm!.patientCareProvider.length),
                ),
                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget
                  (
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
                                    value: profileVm.currentUserInfo?.fullName??""
                                ),
                              )
                            ),

                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: tile(
                                    key: "EmrId",
                                    value: profileVm.currentUserInfo?.patientEmrId??""
                                ),
                              )
                            ),

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
                                      value: profileVm.currentUserInfo?.sex??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Date of Birth",
                                      value: profileVm.currentUserInfo?.dateOfBirth?.substring(0, 10) ?? ""
                                  ),
                                )
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget
                  (
                  widgetTitle: 'Contact Information',
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
                                      key: "Primary Phone No.",
                                      value: profileVm.currentUserInfo?.homePhone??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Secondary Contact No.",
                                      value: profileVm.currentUserInfo?.emergencyContactSecondaryPhoneNo??""
                                  ),
                                )
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget
                  (
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
                                      value: profileVm.currentUserInfo?.currentAddress??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "City",
                                      value: profileVm.currentUserInfo?.city??""
                                  ),
                                )
                            ),

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
                                      value: profileVm.currentUserInfo?.state??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Zip Code",
                                      value: profileVm.currentUserInfo?.zip??""
                                  ),
                                )
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget
                  (
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
                                      value: profileVm.currentUserInfo?.mailingAddress??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "City",
                                      value: profileVm.currentUserInfo?.maillingAddressCity??""
                                  ),
                                )
                            ),

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
                                      value: profileVm.currentUserInfo?.maillingAddressState??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Zip Code",
                                      value: profileVm.currentUserInfo?.maillingAddressZipCode??""
                                  ),
                                )
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget
                  (
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
                                      value: profileVm.currentUserInfo?.bestTimeToCall??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Preferred Language",
                                      value: profileVm.currentUserInfo?.preferredLanguage??""
                                  ),
                                )
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),


                ApplicationSizing.verticalSpacer(n: 15),
                infoWidget
                  (
                  widgetTitle: 'Emergency Contact',
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
                                      value: profileVm.currentUserInfo?.emergencyContactName??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Relationship",
                                      value: profileVm.currentUserInfo?.emergencyContactRelationship??""
                                  ),
                                )
                            ),

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
                                      value: profileVm.currentUserInfo?.emergencyContactPrimaryPhoneNo??""
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: tile(
                                      key: "Secondary Phone",
                                      value: profileVm.currentUserInfo?.emergencyContactSecondaryPhoneNo??""
                                  ),
                                )
                            ),

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
