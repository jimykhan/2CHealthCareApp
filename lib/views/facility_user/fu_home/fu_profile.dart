import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_profile_view_model.dart';
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
      body: _body(context,fuProfileVM: fuProfileVM),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingButton(),
    );
  }

  _body(context,{required FUProfileVM fuProfileVM}){
    return Stack(
      children: [
        Container(
            child: fuProfileVM.fuProfileModel == null ? Column(
              children:  [
                NoData(),
              ],
            ):
            Container(
              margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        boxShadow: CustomShadow.whiteBoxShadowWith15(dy: 0,dx: 0),
                        border: Border.all(
                            color: fontGrayColor.withOpacity(0.5),
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffF0F1F5)
                    ),
                    child: Row(
                      children: [
                        CircularImage(
                          h: 80,
                          w: 80,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("${fuProfileVM.fuProfileModel?.firstName} ${fuProfileVM.fuProfileModel?.lastName}",
                              style: Styles.PoppinsRegular(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),),
                              Text("${fuProfileVM.fuProfileModel?.email}",
                              style: Styles.PoppinsRegular(
                                fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                color: fontGrayColor
                              ),),
                              Text("${fuProfileVM.fuProfileModel?.phoneNo}",
                              style: Styles.PoppinsRegular(
                                fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                color: fontGrayColor
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: fontGrayColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        keyValue(key: "Phone No.",value: fuProfileVM.fuProfileModel?.phoneNo??""),
                        keyValue(key: "Secondary No.",value: fuProfileVM.fuProfileModel?.phoneNo??""),
                        keyValue(key: "Contact Email",value: fuProfileVM.fuProfileModel?.email??""),
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
        fuProfileVM.loadingProfile ? AlertLoader() : Container(),
      ],
    );
  }
  keyValue({required String key,required String value}){
    return Container(
      padding: EdgeInsets.only(bottom: 5,top: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: fontGrayColor.withOpacity(0.3)
              )
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: appColorSecondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(key,style: Styles.PoppinsRegular(
                color: appColorSecondary,
                fontSize: 14
            ),),
          ),

          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(value,style: Styles.PoppinsRegular(
                  color: appColor,
                  fontSize: 12,
                fontWeight: FontWeight.w400
              ),),
            ),
          ),



        ],
      ),
    );
  }

}