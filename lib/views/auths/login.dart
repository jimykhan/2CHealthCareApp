import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/error_text.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/home/home.dart';
class Login extends HookWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);

    useEffect(
          () {
        Future.microtask(() async {});

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        body: Container(
         child: SingleChildScrollView(
           child: Stack(
             children: [
               Column(
                 children: [
                    Container(
                     child: Image.asset("assets/icons/loginBg.png"),
                   ),
                   _loginform(context,loginVM: loginVM),
                 ],
               ),
               loginVM.loading ? AlertLoader() : Container(),
             ],
           ),
         ),
        ),

    );
  }

  _loginform(BuildContext context,{LoginVM? loginVM}) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ApplicationSizing.fontScale(5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.convertWidth(20)),
      margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.convertWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(30)),
            child: RichText(
              text: TextSpan(
                  text: "Welcome,",
                  style: Styles.PoppinsBold(
                      fontSize: ApplicationSizing.fontScale(20),
                      color: appColor)),
            ),
          ),
          Container(
            child: RichText(
              text: TextSpan(
                  text: "Sign in to your account",
                  style: Styles.PoppinsRegular(
                      fontSize: ApplicationSizing.fontScale(12),
                      color: fontGrayColor),
              ),
            ),
          ),
          ApplicationSizing.verticalSpacer(n: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RichText(
                  text: TextSpan(
                      text: "User Name or Email Address",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                        color: Colors.black
                      ),
                  ),
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: CustomTextField(
                  onchange: loginVM!.onChangeEmail,
                  textEditingController: loginVM.emailController,
                  textInputType: TextInputType.emailAddress,
                  hints: "E-mail / User Name",
                  color1: loginVM.isEmailFieldValid
                      ? disableColor
                      : errorColor,
                  onSubmit: (val) {
                    loginVM.fieldValidation(val,fieldType: 0);
                  },
                ),
              ),
              loginVM.isEmailFieldValid ? Container():
              ErrorText(text: loginVM.emailErrorText),

            ],
          ),
          ApplicationSizing.verticalSpacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RichText(
                  text: TextSpan(
                    text: "Password",
                    style: Styles.PoppinsBold(
                        fontSize: ApplicationSizing.fontScale(12),
                        color: Colors.black
                    ),
                  ),
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: CustomTextField(
                  onchange: loginVM.onChangePassword,
                  textEditingController: loginVM.passwordController,
                  textInputType: TextInputType.text,
                  hints: "Password",
                  color1: loginVM.isPasswordFieldValid
                      ? disableColor
                      : errorColor,
                  onSubmit: (val) {
                    loginVM.fieldValidation(val,fieldType: 1);
                  },
                ),
              ),
              loginVM.isPasswordFieldValid ? Container():
              ErrorText(text: loginVM.passwordErrorText),

            ],
          ),
          ApplicationSizing.verticalSpacer(n: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              false
                  ? Container(
                  width: ApplicationSizing.convertWidth(120),
                  height: ApplicationSizing.convert(25),
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(
                    right: ApplicationSizing.convertWidth(6),
                    bottom: ApplicationSizing.convert(10),
                  ),
                  // color: Colors.red,
                  child: CupertinoActivityIndicator(
                    radius: ApplicationSizing.fontScale(10),
                  ))
                  : InkWell(
                onTap: () async {

                },
                child: Container(
                  width: ApplicationSizing.convertWidth(150),
                  height: ApplicationSizing.convert(30),
                  alignment: Alignment.topRight,
                  child: RichText(
                    text: TextSpan(
                        text: "Forgot Password?",
                        style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.fontScale(12),
                            color: fontGrayColor)),
                  ),
                ),
              ),
            ],
          ),
          false
              ? Container(width: 10,height: 10,color: Colors.red,)
              : FilledButton(
            h: ApplicationSizing.convert(50),
            txt: "Login",
            onTap: () async {

              // dd();
              // loginVM.setLoading(true);
              bool checkMail = loginVM.fieldValidation(loginVM.emailController.text,fieldType: 0);
              bool checkPassword = loginVM.fieldValidation(loginVM.passwordController.text,fieldType: 1);
              if(checkMail && checkPassword){
                bool isValid = await loginVM.userLogin();
                if(isValid){
                  Navigator.pushReplacement(context, PageTransition(
                      child: Home(), type: PageTransitionType.bottomToTop)
                  );
                }
              }

            },
          ),
          SizedBox(
            height: ApplicationSizing.convert(12),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Version : ",
                    style: Styles.RobotoMedium(
                      fontSize: ApplicationSizing.fontScale(12),
                    )),
                TextSpan(
                    text: "${""}",
                    style: Styles.RobotoMedium(
                      fontSize: ApplicationSizing.fontScale(10),
                    )),
              ]),
            ),
            // child: Text("${deviceService?.info?.version ?? ""}+${deviceService?.info?.buildNumber??""}",
            //   style: style.RobotoBold(
            //     color: Color(0xff134389),
            //     fontSize: size.convert(context, 8),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
