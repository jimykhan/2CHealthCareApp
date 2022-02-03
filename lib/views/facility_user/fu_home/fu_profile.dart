import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_profile_view_model.dart';
class FUProfile extends HookWidget {
  FUProfile({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    FUProfileVM fuProfileVM = useProvider(fuProfileVMProvider);
    // HomeVM homeVM = useProvider(homeVMProvider);
    // ApplicationRouteService applicationRouteService =
    // useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
          () {
        Future.microtask(() async {
          fuProfileVM.getFuProfileInfo();
        });
        return () {};
      },
      const [],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
        child: CustomAppBar(
          leadingIcon: Container(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(80),
          parentContext: context,
        ),
      ),
      body: _body(fuProfileVM: fuProfileVM),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingButton(),
    );
  }

  _body({required FUProfileVM fuProfileVM}){
    return Stack(
      children: [
        Container(
            child: fuProfileVM.fuProfileModel == null ? Column(
              children:  [
                NoData(),
              ],
            ):
            Container(
              child: Column(
                children: [
                  CircularImage(),
                  Text("${fuProfileVM.fuProfileModel?.userName}")
                ],
              ),
            )
        ),
        fuProfileVM.loadingProfile ? AlertLoader() : Container(),
      ],
    );
  }

}