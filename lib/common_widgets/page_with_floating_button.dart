import 'package:flutter/material.dart';

import 'floating_button.dart';
class PageWithFloatingButton extends StatelessWidget {
  Widget container;
   PageWithFloatingButton({required this.container,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          container,
          Container(
            margin: EdgeInsets.only(right: 10,bottom: 10),
            alignment: Alignment.bottomRight,
              child: FloatingButton()),
        ],
      ),
    );
  }
}
