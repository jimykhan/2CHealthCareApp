import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("No Records found",
      style: Styles.PoppinsRegular(
        fontSize: ApplicationSizing.convert(20),
      ),),
    );
  }
}
