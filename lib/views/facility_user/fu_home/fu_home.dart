import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_drawer.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class FUHome extends HookWidget {
  FUHome({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // LoginVM loginVM = useProvider(loginVMProvider);
    // HomeVM homeVM = useProvider(homeVMProvider);
    // ApplicationRouteService applicationRouteService =
    // useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
          () {
        Future.microtask(() async {});
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
          leadingIcon: InkWell(
            onTap: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(right: 20),
                child:
                SvgPicture.asset("assets/icons/home/side-menu-icon.svg")),
          ),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(80),
          parentContext: context,
        ),
      ),
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        // mini: true,
        // backgroundColor: Colors.black,
        // clipBehavior: Clip.hardEdge,
        enableFeedback: false,
        child: Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(15),
          child: SvgPicture.asset(
            "assets/icons/side_menu/home-icon.svg",
            height: ApplicationSizing.convert(25),
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color(0Xff4EAF48), Color(0xff60E558)])),
        ),
        onPressed: () {
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: 0,
      ),
      drawer: Container(
        width: ApplicationSizing.convertWidth(250),
        child: CustomDrawer(),
      ),
    );
  }

  _body(){
    return Container(
      child: Column(
        children: const [
          Text("Facility User")
        ],
      ),
    );
  }

}