import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_drawer.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'dart:math';

import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/home/profile.dart';
import 'package:twochealthcare/views/notifiction/notifiction_list.dart';
import 'package:twochealthcare/views/readings/modalities_reading.dart';
class Home extends HookWidget {
   Home({Key? key}) : super(key: key);
  List<Map<String, dynamic>?>? items = [
    {
      "icon":"assets/icons/home/user-icon.svg",
      "title":"My Profile",
      "hints":"",
    },
    {
      "icon":"assets/icons/home/reading-icon.svg",
      "title":"My Reading",
      "hints":"",
    },
    {
      "icon":"assets/icons/home/trophy-icon.svg",
      "title":"My Rewards",
      "hints":"Coming Soon...",
    },
    {
      "icon":"assets/icons/home/health-guide-icon.svg",
      "title":"Health Guides",
      "hints":"Coming Soon...",
    },
  ];
   GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: InkWell(
              onTap: (){
                _scaffoldkey.currentState!.openDrawer();
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(right: 20),
                  child: SvgPicture.asset("assets/icons/home/side-menu-icon.svg")),
            ),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
          ),
        ),
        body: _body(),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: SvgPicture.asset("assets/icons/bottom_navbar/user-icon.svg",
            height: ApplicationSizing.convert(25),
          ),
          onPressed: () {
            Navigator.pushReplacement(context, PageTransition(child: Profile(),
              type: PageTransitionType.bottomToTop
              ,));
          },),
        bottomNavigationBar: BottomBar(selectedIndex: 1,),
      drawer: Container(
        width: ApplicationSizing.convertWidth(280),
        child: CustomDrawer(),
      ),
    );
  }
  _body(){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 20)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      top: ApplicationSizing.convert(10),
                      bottom: ApplicationSizing.convert(0),
                    ),
                    child: Text("Welcome Back,",
                    style: Styles.PoppinsRegular(
                      fontSize: ApplicationSizing.fontScale(11),
                      color: fontGrayColor,
                    ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Jamshed khan",
                      style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.fontScale(20),
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ApplicationSizing.verticalSpacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                crossAxisCount: 2,
                itemCount: items?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      if(index == 1){
                        Navigator.push(context, PageTransition(
                            child: ModalitiesReading(), type: PageTransitionType.rightToLeft));
                      }
                    },
                      child: squareBox(item: items?[index],index: index));
                },
                staggeredTileBuilder: (int index) =>
                 const StaggeredTile.fit(1),
                mainAxisSpacing: ApplicationSizing.convert(5),
                crossAxisSpacing: ApplicationSizing.convert(5),

              )
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Text("Recent Notifications",
                        style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(16),

                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text("See All",
                        style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: appColor,


                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            ApplicationSizing.verticalSpacer(n: 20),
            Container(
              child:ListView.separated(
                shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(
                            child: NotificationList(), type: PageTransitionType.bottomToTop));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
                        child: NotificationWidget(
                          title: "EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin())",
                          date: "6 April",
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return Container(
                      height: 1,
                      color: fontGrayColor.withOpacity(0.5),
                      // margin: EdgeInsets.symmetric(vertical: ApplicationSizing.convert(10),
                      // horizontal: ApplicationSizing.horizontalMargin(n: 20)),
                    );
                  },
                  itemCount: 10),
            ),
            ApplicationSizing.verticalSpacer(),
          ],
        ),
      ),
    );
  }
  Widget squareBox({var item,int index= 0}){
    return Container(
      width: 150,
        height: 150,
        padding: EdgeInsets.symmetric(vertical: ApplicationSizing.convert(20)),
        decoration: BoxDecoration(
          color: appColor.withOpacity(0.1),
          // color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: appColor.withOpacity(0.8),
            width: 0.6,

          )
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(item["icon"]),
          Container(
            margin: EdgeInsets.symmetric(vertical: ApplicationSizing.convert(5)),
              child: Text(item["title"],
                style: Styles.PoppinsBold(
                  fontSize: ApplicationSizing.fontScale(12),
                ),
              ),
          ),
          Text(item["hints"],
            style: Styles.PoppinsRegular(
              fontSize: ApplicationSizing.fontScale(8),
              color: fontGrayColor
            ),
          ),
        ],
      ),
    );
  }
}

