import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class MadLinePlus extends HookWidget {

  MadLinePlus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ChronicCareVM chronicCareVM = useProvider(fuChronicCareVMProvider);
    return Container(
      height: MediaQuery.of(context).size.height/1.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30)
          ),
          color: Colors.white
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5,bottom: 10),
            width: 170,
            height: 5,
            decoration: BoxDecoration(
                color: fontGrayColor,
                borderRadius: BorderRadius.circular(2)
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}