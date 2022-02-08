import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ApplicationSizing.constSize(52),
      height: ApplicationSizing.constSize(52),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SvgPicture.asset("assets/icons/filter_icon.svg"),
    );
  }
}
