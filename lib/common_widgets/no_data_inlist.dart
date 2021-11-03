import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // color: Colors.green,
      height: 400,
      child: Text("No Record Found",
      style: Styles.PoppinsRegular(
        fontSize: ApplicationSizing.convert(20),
      ),),
    );
  }
}
