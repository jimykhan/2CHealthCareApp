import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/home/home.dart';

class FloatingButton extends StatelessWidget {
  FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Container(
        width: 60,
        height: 60,
        padding: EdgeInsets.all(15),
        child: SvgPicture.asset(
          "assets/icons/side_menu/home-icon.svg",
          height: ApplicationSizing.convert(25),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient:
                LinearGradient(colors: [Color(0Xff4EAF48), Color(0xff60E558)])),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          applicationContext!.currentContext!,
          MaterialPageRoute(
            builder: (BuildContext context) => Home(),
          ),
          (route) => false,
        );
      },
    );
  }
}
