import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/health_guides_vm/health_guides_vm.dart';
import 'package:twochealthcare/views/health_guides/in_app_browser.dart';

class HealthGuides extends HookWidget {
  const HealthGuides({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);
    HealthGuidesVM healthGuidesVM = useProvider(healthGuidesVMProviders);

    useEffect(
      () {
        healthGuidesVM.loadingHealthGuides = true;

        Future.microtask(() async {
          healthGuidesVM.getAllHealthGuides();
        });
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        primary: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
          child: CustomAppBar(
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(70),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Health Guidelines",
            ),
          ),
        ),
        body: _body(healthGuidesVM: healthGuidesVM));
  }

  _body({required HealthGuidesVM healthGuidesVM}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ApplicationSizing.verticalSpacer(n: 20),
                (!healthGuidesVM.loadingHealthGuides &&
                        healthGuidesVM.listOfHealthGuide.length == 0)
                    ? NoData(
                        paddingFormTop: 100,
                      )
                    : Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  String? isPdf = healthGuidesVM
                                      .listOfHealthGuide[index].url
                                      ?.substring(healthGuidesVM
                                              .listOfHealthGuide[index]
                                              .url!
                                              .length -
                                          3);
                                  print(healthGuidesVM
                                      .listOfHealthGuide[index].url);
                                  print(isPdf?.toUpperCase());
                                  if (isPdf?.toUpperCase() == "PDF") {
                                    launchURL(
                                        url: healthGuidesVM
                                            .listOfHealthGuide[index].url!);
                                  } else {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: InAppBrowser(
                                              url: healthGuidesVM
                                                      .listOfHealthGuide[index]
                                                      .url ??
                                                  "",
                                              title: healthGuidesVM
                                                      .listOfHealthGuide[index]
                                                      .title ??
                                                  "",
                                            ),
                                            type: PageTransitionType.fade));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: appColor, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          ApplicationSizing.horizontalMargin()),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          healthGuidesVM
                                                  .listOfHealthGuide[index]
                                                  .title ??
                                              "",
                                          style: Styles.PoppinsRegular(
                                              color: Colors.black,
                                              fontSize:
                                                  ApplicationSizing.fontScale(
                                                      16),
                                              fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          healthGuidesVM
                                                  .listOfHealthGuide[index]
                                                  .createdOn ??
                                              "",
                                          style: Styles.PoppinsRegular(
                                              color: appColor,
                                              fontSize:
                                                  ApplicationSizing.fontScale(
                                                      8),
                                              fontWeight: FontWeight.w400),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 10,
                              );
                            },
                            itemCount: healthGuidesVM.listOfHealthGuide.length),
                      ),
                ApplicationSizing.verticalSpacer(),
              ],
            ),
            healthGuidesVM.loadingHealthGuides ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }
}
