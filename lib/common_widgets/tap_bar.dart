import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class TapBar extends StatelessWidget {
  int selectedIndx;
  Function(int? val) ontap;
   TapBar({Key? key,this.selectedIndx = 0,required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()
      ),
      height: ApplicationSizing.convert(35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: appColor,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                  ontap(0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndx == 0
                      ? appColor
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft:  Radius.circular(3),
                    bottomLeft: Radius.circular(3),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Day",
                  style: Styles.PoppinsRegular(
                    color: selectedIndx == 0 ? Colors.white : appColor,
                    fontSize: ApplicationSizing.convert(12),
                    fontWeight: selectedIndx == 0 ? FontWeight.bold : FontWeight.normal
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                ontap(1);
              },
              child: Container(
                decoration: BoxDecoration(
                    color:
                    selectedIndx == 1
                        ? appColor
                        : Colors.white,
                    border: Border(
                      right: BorderSide(color: appColor, width: 1),
                      left: BorderSide(color: appColor, width: 1),
                    )),
                alignment: Alignment.center,
                child: Text(
                  "Week",
                  style: Styles.PoppinsRegular(
                      color: selectedIndx == 1 ? Colors.white : appColor,
                      fontSize: ApplicationSizing.convert(12),
                      fontWeight: selectedIndx == 1 ? FontWeight.bold : FontWeight.normal
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                ontap(2);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndx == 2
                      ? appColor
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Month",
                  style: Styles.PoppinsRegular(
                      color: selectedIndx == 2 ? Colors.white : appColor,
                      fontSize: ApplicationSizing.convert(12),
                      fontWeight: selectedIndx == 2 ? FontWeight.bold : FontWeight.normal
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
