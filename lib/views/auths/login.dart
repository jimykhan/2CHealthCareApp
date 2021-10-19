import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/home/home.dart';
class Login extends HookWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
         child: SingleChildScrollView(
           child: Column(
             children: [
                Container(
                 child: Image.asset("assets/icons/loginBg.png"),
               ),
               _loginform(context),
             ],
           ),
         ),
        ),

    );
  }

  _loginform(BuildContext context) {

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
                  onchange: (val) {
                    // userNameLength = val.toString().length;
                    // fieldValidation("email");
                  },
                  // textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress,
                  hints: "E-mail / User Name",
                  // color1: error["email"][0] && error["email"][1] != ""
                  //     ? errorColor
                  //     : disableColor,
                  // onSubmit: () {
                  //   fieldValidation("email");
                  // },
                ),
              ),
              // error["email"][0]
              //     ? ErrorText(error["email"][1] ?? "")
              //     : Container()
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
                    ),),
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: CustomTextField(
                  onchange: (val) {
                    // passwordLength = val.toString().length;
                    // fieldValidation("password");
                  },
                  // textEditingController: _passwordController,
                  hints: "Password",
                  // color1: error["password"][0] && error["password"][1] != ""
                  //     ? errorColor
                  //     : disableColor,
                  // onSubmit: () {
                  //   fieldValidation("password");
                  // },
                  // obscureText: !hidePass,
                  // trailingIcon: InkWell(
                  //   // onTap: () {
                  //   //   setState(() {
                  //   //     hidePass = !hidePass;
                  //   //   });
                  //   // },
                  //   child: Container(
                  //     child: !hidePass
                  //         ? Icon(
                  //       IcoFontIcons.eyeBlocked,
                  //       color: Colors.grey.shade500,
                  //     )
                  //         : Icon(
                  //       IcoFontIcons.eye,
                  //       color: Colors.green.shade600,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              // error["password"][0]
              //     ? ErrorText(error["password"][1] ?? "")
              //     : Container()
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
            onTap: (){
              Navigator.pushReplacement(context, PageTransition(
                  child: Home(), type: PageTransitionType.bottomToTop));
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
