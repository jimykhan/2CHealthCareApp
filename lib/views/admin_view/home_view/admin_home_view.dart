import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/drawer_menu_button.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_drawer.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/application_package_vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/admin_view/barcode_scan/barcode_scan.dart';
import 'package:twochealthcare/views/admin_view/home_view/admin_home_view_model.dart';
import 'package:twochealthcare/views/rpm_view/readings/modalities_reading.dart';

class AdminHome extends HookWidget {
  AdminHome({Key? key}) : super(key: key);
  List<Map<String, dynamic>?>? items = [
    {
      "icon": "assets/icons/home/barcode.svg",
      "title": "Scan device",
      "hints": "",
      "color": Color(0Xff548EFF),
      "bordercolor": Color(0Xff4eaf4840),
    },
  ];
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    AdminHomeVM adminHomeVM = useProvider(adminHomeVMProvider);
    ApplicationPackageVM _applicationPackageVm = useProvider(applicationPackageVMProvider);
    ApplicationRouteService applicationRouteService =
    useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
          () {
            adminHomeVM.adminHomeScreenLoading = false;
        _applicationPackageVm.checkForUpdate();
            adminHomeVM.resetAdminHome();
        Future.microtask(() async {});
        return () {};
      },
      const [],
    );
    return Scaffold(
      primary: false,
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          facilityIcon: false,
          leadingIcon: InkWell(
            onTap: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            child: DrawerMenuButton(),
          ),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          paddingLeft: 15,
        ),
      ),
      body: _body(
          loginVM: loginVM,
          adminHomeVM: adminHomeVM,
          applicationRouteService: applicationRouteService),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        // mini: true,
        // backgroundColor: Colors.black,
        // clipBehavior: Clip.hardEdge,
        enableFeedback: false,
        child: Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(15),
          child: SvgPicture.asset(
            "assets/icons/side_menu/home-icon.svg",
            height: ApplicationSizing.convert(25),
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color(0Xff4EAF48), Color(0xff60E558)])),
        ),
        onPressed: () {
          // Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //       child: Home(),
          //       type: PageTransitionType.bottomToTop,
          //     ));
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: 0,
      ),
      drawer: Container(
        width: ApplicationSizing.convertWidth(250),
        child: CustomDrawer(),
      ),
    );
  }

  _body(
      {required LoginVM loginVM,
        required AdminHomeVM adminHomeVM,
        required ApplicationRouteService applicationRouteService}) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.horizontalMargin(n: 20)),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          top: ApplicationSizing.convert(10),
                          bottom: ApplicationSizing.convert(0),
                        ),
                        child: Text(
                          "Welcome Back,",
                          style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.fontScale(12),
                            color: fontGrayColor,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          loginVM.currentUser?.fullName ?? "",
                          style: Styles.PoppinsRegular(
                              fontSize: ApplicationSizing.fontScale(20),
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                ApplicationSizing.verticalSpacer(n: 20),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ApplicationSizing.horizontalMargin()),
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      crossAxisCount: 2,
                      itemCount: items?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              if (index == 0) {
                                applicationRouteService.addScreen(
                                    screenName: "Scan Device");
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: BarcodeScan(),
                                        type: PageTransitionType.rightToLeft));
                              }
                            },
                            child:
                            squareBox(item: items?[index], index: index));
                      },
                      staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                      mainAxisSpacing: ApplicationSizing.convert(20),
                      crossAxisSpacing: ApplicationSizing.convert(20),
                    )),

                // Container(
                //   margin: EdgeInsets.symmetric(
                //       horizontal: ApplicationSizing.horizontalMargin(n: 20)),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Expanded(
                //         flex: 6,
                //         child: Container(
                //           alignment: Alignment.bottomLeft,
                //           child: Text(
                //             "Recent Notifications",
                //             style: Styles.PoppinsBold(
                //               fontSize: ApplicationSizing.fontScale(16),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 2,
                //         child: Container(
                //           alignment: Alignment.bottomRight,
                //           child: Text(
                //             "See All",
                //             style: Styles.PoppinsRegular(
                //               fontSize: ApplicationSizing.fontScale(12),
                //               color: appColor,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // ApplicationSizing.verticalSpacer(n: 0),
                // Container(
                //   child: ListView.separated(
                //       shrinkWrap: true,
                //       physics: ScrollPhysics(),
                //       itemBuilder: (context, index) {
                //         return InkWell(
                //           onTap: () {
                //             Navigator.push(
                //                 context,
                //                 PageTransition(
                //                     child: NotificationList(),
                //                     type: PageTransitionType.bottomToTop));
                //           },
                //           child: Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal: ApplicationSizing.horizontalMargin()),
                //             child: NotificationWidget(
                //               title: "Lorem ipsum",
                //               date: "6 April",
                //             ),
                //           ),
                //         );
                //       },
                //       separatorBuilder: (context, index) {
                //         return Container(
                //           height: 1,
                //           color: fontGrayColor.withOpacity(0.5),
                //           // margin: EdgeInsets.symmetric(vertical: ApplicationSizing.convert(10),
                //           // horizontal: ApplicationSizing.horizontalMargin(n: 20)),
                //         );
                //       },
                //       itemCount: 3),
                // ),
                ApplicationSizing.verticalSpacer(),
              ],
            ),
          ),
        ),
        adminHomeVM.adminHomeScreenLoading ? AlertLoader() : Container(),
      ],
    );
  }

  Widget squareBox({var item, int index = 0}) {
    return Container(
      // width: 150,
      height: ApplicationSizing.convert(160),
      padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.convert(10)),
      decoration: BoxDecoration(
        color: item["color"],
        // color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: item["bordercolor"],
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0Xff1d161712),
            blurRadius: 4,
            offset: Offset(0, 8), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(item["icon"],width: 100,height: 60,),
          SizedBox(height: 10,),
          Column(
            children: [
              Container(
                margin:
                EdgeInsets.symmetric(vertical: ApplicationSizing.convert(5)),
                child: Text(
                  item["title"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.PoppinsBold(
                    // fontSize: 32,
                      fontSize: ApplicationSizing.fontScale(16,minus: true),
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              item["hints"] == ""
                  ? Container()
                  : Text(
                item["hints"],
                overflow: TextOverflow.ellipsis,
                style: Styles.PoppinsBold(
                    fontSize: ApplicationSizing.fontScale(8,minus: true),
                    color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
