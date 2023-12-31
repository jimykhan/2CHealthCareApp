import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';

CustomAlertDialog({String? message}) {
  showDialog(
    context: applicationContext!.currentContext!,

    builder: (BuildContext context) {
      // return object of type Dialog
      return Scaffold(

        // color: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
                color: Color(0xffE6EFFA),
              border: Border.all(
                width: 1,
                color: Color(0xff116DDA).withOpacity(0.7),
              )

            ),
            padding: EdgeInsets.all(
              ApplicationSizing.convert(10)
            ),
            // height: ApplicationSizing.convert(100),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration:  BoxDecoration(
                              color: Color(0xff116DDA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                ),
                                child: SvgPicture.asset("assets/icons/i.svg")),
                          ),
                          ApplicationSizing.horizontalSpacer(),
                          Expanded(
                            child: Container(
                              // color: Colors.red,
                              child: Text(message??"",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.PoppinsRegular(
                                    color: Color(0xff4F5153),
                                    fontSize: ApplicationSizing.fontScale(18,minus: true)
                                ),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      // color: Colors.blueAccent,
                      // margin: EdgeInsets.only(right: 10),
                      // width: 20,
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                      child: Icon(IcoFontIcons.close),
                    ),
                  )
                ],
              ),
          ),
        ),
      );
    },
  );
}

logoutAlertDialog({required LoginVM loginVM}) {
  showDialog(
    context: applicationContext!.currentContext!,
    builder: (BuildContext context) {
      // return object of type Dialog
      return ConfirmLogout();
    },
  );
}
GenerateAlert({required Widget child}) {
  showDialog(
    context: applicationContext!.currentContext!,
    builder: (BuildContext context) {
      // return object of type Dialog
      return Scaffold(
        // color: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: Container(
          // height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 25)),
          child: child,
        ),
      );

    },
  );
}

class ConfirmLogout extends HookWidget {
  const ConfirmLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    useEffect(
          () {
        Future.microtask(() async {});
        return () {};
      },
      const [],
    );
    return Scaffold(
      // color: Colors.transparent,
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 25)),
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,

            // border: Border.all(
            //   width: 1,
            //   color: Color(0xff116DDA).withOpacity(0.7),
            // )

          ),
          padding: EdgeInsets.symmetric(
            vertical:ApplicationSizing.convert(10),
            horizontal:ApplicationSizing.convert(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Are you sure you want to log out?",
                        textAlign: TextAlign.center,
                        style: Styles.PoppinsRegular(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),),
                    ),
                    Container(
                      child:  Column(
                        children: [
                          loginVM.loading ? Container(margin:EdgeInsets.only(bottom: 10),
                              child: loader()) : CustomFilledButton(onTap: (){
                            loginVM.userLogout();
                          },
                              txt: "Log out",
                              color1: appColor,
                              txtcolor: Colors.white,
                              w: 200,
                              borderRadius: 30
                          ),
                          SizedBox(height: 10,),
                          CustomFilledButton(
                            onTap: loginVM.loading ? null : (){
                            Navigator.pop(context);
                          },
                            color1: Colors.white,
                            w: 200,
                            borderRadius: 30,
                            borderColor: loginVM.loading ? fontGrayColor : Colors.red,
                            txtcolor: loginVM.loading ? fontGrayColor : Colors.red,
                            txt: "Cancel",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

CenterAlertDialog({String? title, required Widget child}){
  showDialog(
    context: applicationContext!.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title??"My title"),
        content: child,
      );
    },
  );
}


AlertMessageCustomDesign({String? title, Function()? onConfirm, Function()? onCancel}){
  showDialog(
    context: applicationContext!.currentContext!,
    builder: (BuildContext context) {
      // return object of type Dialog
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          // height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 10)),
          child: Container(
            // height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              vertical:ApplicationSizing.convert(10),
              horizontal:ApplicationSizing.convert(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(title??"Title",
                          textAlign: TextAlign.center,
                          style: Styles.PoppinsRegular(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        child:  Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CustomFilledButton(onTap: onConfirm,
                                  txt: "Confirm",
                                  color1: appColor,
                                  txtcolor: Colors.white,
                                  // w: 200,
                                  h: 40,
                                  borderRadius: 30
                              ),
                            ),
                            Expanded(flex :1,child: Container()),
                            Expanded(
                              flex: 5,
                              child: CustomFilledButton(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                color1: Colors.white,
                                // w: 200,
                                h: 40,
                                borderRadius: 30,
                                borderColor:  Colors.red,
                                txtcolor:  Colors.red,
                                txt: "Cancel",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

          ),
        ),
      );
    },
  );
}
