import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/modalities_reading_vm/modalities_reading_vm.dart';
import 'package:twochealthcare/views/readings/blood_pressure_reading.dart';
class ModalitiesReading extends HookWidget {
   ModalitiesReading({Key? key}) : super(key: key);

  List items = [
    {
      "modalityName":"Blood Pressure",
      "reading":"180 sys 90 dia",
      "context":"this is something",
      "icon":"assets/icons/readings/blood-glucose-icon.svg",
      "color":const Color(0xffFD5C58)
    },

    {
      "modalityName":"Blood Pressure",
      "reading":"180 sys 90 dia",
      "context":"this is something",
      "icon":"assets/icons/readings/blood-glucose-icon.svg",
      "color":const Color(0xffFFA654)
    },

    {
      "modalityName":"Blood Pressure",
      "reading":"180 sys 90 dia",
      "context":"this is something",
      "icon":"assets/icons/readings/blood-glucose-icon.svg",
      "color":const Color(0xff548EFF)
    },

    {
      "modalityName":"Blood Pressure",
      "reading":"180 sys 90 dia",
      "context":"this is something",
      "icon":"assets/icons/readings/blood-glucose-icon.svg",
      "color":const Color(0xffBE54FF)
    },
  ];

  @override
  Widget build(BuildContext context) {
    final sharedPrefService = useProvider(sharedPrefServiceProvider);
    final modalitiesReadingVM = useProvider(modalitiesReadingVMProvider);
    useEffect(
          () {
        Future.microtask(() async {});
        modalitiesReadingVM.modalitiesLoading = true;
          modalitiesReadingVM.getModalitiesByUserId();
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(right:ApplicationSizing.convertWidth(10)),
                child: RotatedBox(
                    quarterTurns: 2,child: SvgPicture.asset("assets/icons/home/right-arrow-icon.svg")),
              ),
            ),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "My Readings",
            ),
          ),
        ),
        floatingActionButtonLocation:  FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingButton(),
        body: _body(sharedPrefServices: sharedPrefService,modalitiesReadingVM: modalitiesReadingVM));
  }
  _body({SharedPrefServices? sharedPrefServices,ModalitiesReadingVM? modalitiesReadingVM}){
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ApplicationSizing.verticalSpacer(n: 20),
                Container(
                  child:ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context,index){
                        ModalitiesModel modality = modalitiesReadingVM!.modalitiesList[index];
                        return modality.id == -1 ?  Container() : InkWell(
                          onTap: (){
                            if(index == 0){
                              // sharedPrefServices?.getBearerToken();
                              Navigator.push(context, PageTransition(
                                  child: const BloodPressureReading(), type: PageTransitionType.bottomToTop));
                            }

                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
                            padding: EdgeInsets.symmetric(
                              horizontal: ApplicationSizing.horizontalMargin(),
                              vertical: ApplicationSizing.convert(10),
                            ),
                            decoration: BoxDecoration(
                              color: modality.modality =="BP" ? const Color(0xffFD5C58) :
                              modality.modality == "BG" ? const Color(0xffFFA654) :
                              modality.modality=="WT" ? const Color(0xff548EFF) :
                              modality.modality == "CGM" ? const Color(0xffBE54FF) : const Color(0xff4EAF48),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  // color:Colors.amber,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(modality.modalityName??"",
                                          style: Styles.PoppinsRegular(
                                            fontSize: ApplicationSizing.fontScale(12),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(modality.lastReadingDate??"",
                                          style: Styles.PoppinsRegular(
                                            fontSize: ApplicationSizing.fontScale(8),
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical:ApplicationSizing.convert(5)),
                                  // color:Colors.blueAccent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex:2,
                                          child: Container(
                                            alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                  modality.modality =="BP" ? "assets/icons/readings/blood-glucose-icon.svg" :
                                                  modality.modality == "BG" ? "assets/icons/readings/blood-glucose-icon.svg" :
                                                  modality.modality=="WT" ? "assets/icons/readings/blood-glucose-icon.svg" :
                                                  modality.modality == "CGM" ? "" : "assets/icons/readings/blood-glucose-icon.svg",
                                              )
                                          )),
                                      Expanded(
                                        flex:5,
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: modality.lastReading??"",
                                                        style: Styles.PoppinsRegular(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: ApplicationSizing.fontScale(30),
                                                          color: Colors.white
                                                        )
                                                      ),
                                                      TextSpan(
                                                        text: modality.lastReadingUnit??"",
                                                        style: Styles.PoppinsRegular(
                                                          fontSize: ApplicationSizing.fontScale(10),
                                                          color: Colors.white
                                                        )
                                                      ),
                                                    ]
                                                  )
                                              ),
                                              // ApplicationSizing.horizontalSpacer(),
                                              // RichText(
                                              //     text: TextSpan(
                                              //       children: [
                                              //         TextSpan(
                                              //           text: "90",
                                              //           style: Styles.PoppinsRegular(
                                              //             fontWeight: FontWeight.bold,
                                              //             fontSize: ApplicationSizing.fontScale(30),
                                              //             color: Colors.white
                                              //           )
                                              //         ),
                                              //         TextSpan(
                                              //           text: "dia",
                                              //           style: Styles.PoppinsRegular(
                                              //             fontSize: ApplicationSizing.fontScale(10),
                                              //             color: Colors.white
                                              //           )
                                              //         ),
                                              //       ]
                                              //     )
                                              // ),
                                            ],
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                                Container(
                                  // color: Colors.black,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex:2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: RichText(
                                                  text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: modality.lastReadingContext??"",
                                                            style: Styles.PoppinsRegular(
                                                                fontSize: ApplicationSizing.fontScale(10),
                                                                color: Colors.white
                                                            )
                                                        ),
                                                        TextSpan(
                                                            text: "",
                                                            style: Styles.PoppinsRegular(
                                                                fontSize: ApplicationSizing.fontScale(10),
                                                                color: Colors.white
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              ),
                                          )
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return Container(
                          height: 10,
                        );
                      },
                      itemCount: modalitiesReadingVM?.modalitiesList.length ?? 0),
                ),
                ApplicationSizing.verticalSpacer(),
              ],
            ),
            modalitiesReadingVM!.modalitiesLoading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }
}
