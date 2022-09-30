import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class ReadingTile extends StatelessWidget {
  String time;
  String? date;
  String? reading1;
  String? reading2;
  String? reading3;
  String? unit1;
  String? unit2;
  String? unit3;
  ReadingTile({Key? key,this.unit1,this.unit2,this.unit3,this.reading1,this.reading2,this.reading3,required this.time,this.date,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: date == null ? Container() :
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: ApplicationSizing.horizontalMargin(n: 18)),
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    date!,
                    style: Styles.PoppinsRegular(
                      fontWeight: FontWeight.bold,
                      fontSize: ApplicationSizing.fontScale(16),
                      color: fontGrayColor,
                    ),
                  ),
                ),
                ApplicationSizing.horizontalSpacer(),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: ApplicationSizing.horizontalMargin()),
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
              border:
              Border.all(width: 1, color: appColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0Xff1d161712),
                  blurRadius: 20,
                  offset: Offset(4, 10), // Shadow position
                ),
              ],
              color: Colors.white),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    time.substring(11),
                    style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.fontScale(16),
                        color: fontGrayColor),
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        reading1 == null ? Container(width: 1,height: 1,) : Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: reading1?? "",

                                    style: Styles.PoppinsBold(
                                      fontSize:
                                      ApplicationSizing.fontScale(
                                          20),
                                      fontWeight: FontWeight.bold,
                                      color: appColor,
                                    )),
                                TextSpan(
                                    text: unit1??"",
                                    style: Styles.PoppinsRegular(
                                      fontSize:
                                      ApplicationSizing.fontScale(
                                          10),
                                      color: appColor,
                                    )),
                              ]),
                            ),
                          ),
                        ),
                        reading2 == null ? Container(width: 1,height: 1,) : Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: reading2??"",
                                    style: Styles.PoppinsBold(
                                      fontSize:
                                      ApplicationSizing.fontScale(
                                          20),
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1D3D71),
                                    )),
                                TextSpan(
                                    text: unit2??"",
                                    style: Styles.PoppinsRegular(
                                      fontSize:
                                      ApplicationSizing.fontScale(
                                          10),
                                      color: Color(0xff1D3D71),
                                    )),
                              ]),
                            ),
                          ),
                        ),
                        reading3 == null ? Container(width: 1,height: 1,) :Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: reading3??"",
                                    style: Styles.PoppinsBold(
                                      fontSize:
                                      ApplicationSizing.fontScale(
                                          20),
                                      fontWeight: FontWeight.bold,
                                      color: drawerColor,
                                    )),
                                TextSpan(
                                    text: unit3??"",
                                    style: Styles.PoppinsRegular(
                                      fontSize:
                                      ApplicationSizing.fontScale(
                                          10),
                                      color: drawerColor,
                                    )),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
