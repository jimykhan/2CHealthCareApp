import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';

import '../circular_image.dart';

class HeadProfile extends StatelessWidget {
  LoginVM loginVM;
  HeadProfile({required this.loginVM,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppBarStartColor, AppBarEndColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: Row(
        children: [
          Container(
            height: ApplicationSizing.convert(200),
            margin: EdgeInsets.symmetric(
                horizontal:
                ApplicationSizing.horizontalMargin()),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing
                          .horizontalMargin()),
                  child: CircularImage(
                    w: ApplicationSizing.convert(80),
                    h: ApplicationSizing.convert(80),
                    imageUrl: "assets/icons/personIcon.png",
                    assetImage: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    loginVM.currentUser?.fullName ?? "",
                    style: Styles.PoppinsRegular(
                        fontSize:
                        ApplicationSizing.fontScale(
                            20),
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 10, left: 10),
                  child: Text(
                    loginVM.currentUser?.userName ?? "",
                    style: Styles.PoppinsRegular(
                        fontSize:
                        ApplicationSizing.fontScale(
                            10),
                        color: Colors.white,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
