import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
class VerificationMark extends StatelessWidget {
  bool isVerified;
  VerificationMark({required this.isVerified,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: isVerified ? appColor : Colors.red,
          shape: BoxShape.circle
      ),
      child: isVerified
          ? Icon(Icons.check,size: 15, color: Colors.white,)
          : Icon(Icons.close,size: 15,color: Colors.white,),
    );
  }
}
