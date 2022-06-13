import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/verification_mark.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/styles.dart';

class VerifiedInfo extends StatelessWidget {
  bool isVerified;
  String? textInfo;
  String? textInfoTitle;
  Function()? ontap;
  VerifiedInfo(
      {required this.isVerified,
      this.textInfo,
      this.textInfoTitle,
      this.ontap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5, top: 8),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: fontGrayColor.withOpacity(0.3)))),
      // color: Colors.amber,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(70, 141, 255, 0.27),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              textInfoTitle ?? "",
              style:
                  Styles.PoppinsRegular(color: appColorSecondary, fontSize: 14),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: ontap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      textInfo ?? "",
                      style: Styles.PoppinsRegular(
                          color: isVerified ? appColor : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  VerificationMark(
                    isVerified: isVerified,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
