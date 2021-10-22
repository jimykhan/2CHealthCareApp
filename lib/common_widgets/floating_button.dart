import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_sizing.dart';
class FloatingButton extends StatelessWidget {
   FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: SvgPicture.asset("assets/icons/side_menu/home-icon.svg",
        height: ApplicationSizing.convert(25),
      ),
      onPressed: () {},);
  }
}
