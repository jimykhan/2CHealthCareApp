import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/common_container.dart';

class EncouterTile extends StatelessWidget {
  String? providerName;
  String? serviceType;
  String? date;
  String? startTime;
  String? endTime;
  String? duration;
  String? notes;
  Function() onEdit;
  SizedBox _sizedBox =   SizedBox(height: 4,);
  EncouterTile ({this.duration,this.date,this.endTime,this.notes,this.providerName,
    this.serviceType,this.startTime,
    required this.onEdit,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (context) => onEdit(),
            backgroundColor: appColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit Log',
          ),
          // SlidableAction(
          //   onPressed: null,
          //   backgroundColor: Color(0xFF0392CF),
          //   foregroundColor: Colors.white,
          //   icon: Icons.save,
          //   label: 'Save',
          // ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
        child: CommonContainer(
          horizontalPadding: 8,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Container(
                        // color: Colors.green,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                   "Care Provider : ",
                                  style: Styles.PoppinsRegular(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ApplicationSizing.constSize(14),
                                      color: Colors.black),
                                ),
                                Text(
                                  "${providerName??""}",
                                  style: Styles.PoppinsRegular(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ApplicationSizing.constSize(14),
                                      color: Colors.black),
                                ),

                              ],
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Date : ",
                          style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w500,
                              fontSize: ApplicationSizing.constSize(10),
                              color: Colors.black),
                        ),
                        Text(
                          "${date??""}",
                          style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w500,
                              fontSize: ApplicationSizing.constSize(10),
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _sizedBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text("Service Type : ",
                     style: Styles.PoppinsRegular(
                         fontWeight: FontWeight.w500,
                         fontSize: ApplicationSizing.constSize(11),
                         color: Colors.black)
                 ),
                 Expanded(
                   child: Text("${serviceType??""}",
                       style: Styles.PoppinsRegular(
                           fontWeight: FontWeight.w500,
                           fontSize: ApplicationSizing.constSize(11),
                           color: Colors.black)

                   ),
                 ),

                ],
              ),
              _sizedBox,
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Text(
                            "Start Time : ",
                            style: Styles.PoppinsRegular(
                              fontSize: ApplicationSizing.constSize(10),
                              fontWeight: FontWeight.w500,
                              color: appColorSecondary,
                            ),
                          ),
                          Expanded(
                            child: Text(
                               "${startTime??""}",
                              style: Styles.PoppinsRegular(
                                fontSize: ApplicationSizing.constSize(10),
                                fontWeight: FontWeight.w500,
                                color: appColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "End Time : ",
                            style: Styles.PoppinsRegular(
                              fontSize: ApplicationSizing.constSize(10),
                              fontWeight: FontWeight.w500,
                              color: appColorSecondary,
                            ),
                          ),
                          Text(
                            "${endTime??""}",
                            style: Styles.PoppinsRegular(
                              fontSize: ApplicationSizing.constSize(10),
                              fontWeight: FontWeight.w500,
                              color: appColor,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
              _sizedBox,
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Text(
                            "Duration : ",
                            style: Styles.PoppinsRegular(
                              fontSize: ApplicationSizing.constSize(10),
                              fontWeight: FontWeight.w500,
                              color: appColorSecondary,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${duration??""}",
                              style: Styles.PoppinsRegular(
                                fontSize: ApplicationSizing.constSize(10),
                                fontWeight: FontWeight.w500,
                                color: appColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _sizedBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Notes : ",
                      style: Styles.PoppinsRegular(
                          fontWeight: FontWeight.w500,
                          fontSize: ApplicationSizing.constSize(11),
                          color: Colors.black)
                  ),
                  Expanded(
                    child: Text("${notes??""}",
                        style: Styles.PoppinsRegular(
                            fontWeight: FontWeight.w500,
                            fontSize: ApplicationSizing.constSize(11),
                            color: Colors.black)

                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

