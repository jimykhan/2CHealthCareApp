import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class NotificationWidget extends StatelessWidget {
  String? imageUrl;
  String? title;
  String? date;
  bool? disableIcon;
   NotificationWidget({Key? key,this.date,this.title,this.imageUrl,this.disableIcon = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ApplicationSizing.convert(10)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  CircularImage(
                    w: ApplicationSizing.convert(40),
                    h: ApplicationSizing.convert(40),
                    imageUrl: imageUrl,
                  ),
                  ApplicationSizing.horizontalSpacer(),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(title??"",
                              style: Styles.PoppinsRegular(
                                fontSize: ApplicationSizing.fontScale(12),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            child: Text(date??"",
                              style: Styles.PoppinsRegular(
                                fontSize: ApplicationSizing.fontScale(10),
                                fontWeight: FontWeight.normal,
                                color: fontGrayColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          disableIcon! ? Container()  : Container(
            width: ApplicationSizing.convertWidth(30),
            child: SvgPicture.asset("assets/icons/home/right-arrow-icon.svg"),
          )
        ],
      ),
    );
  }
}
