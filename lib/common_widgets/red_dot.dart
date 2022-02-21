import 'package:flutter/material.dart';

class RedDot extends StatelessWidget {
  double? paddingAll;
   RedDot({this.paddingAll,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingAll??6),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red
      ),
    );
  }
}
