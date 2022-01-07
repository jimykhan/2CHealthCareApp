import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/error_text.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/common_widgets/radio-button.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/forget-password-vm.dart';
import 'package:twochealthcare/views/auths/login.dart';
import 'package:twochealthcare/views/auths/otp_verification.dart';

class forgetPassword extends HookWidget {
  bool isSmsVerify = false;
  bool isEmailVerify = false;
  String userName;
  forgetPassword({required this.userName,required this.isSmsVerify,required this.isEmailVerify});



  @override
  Widget build(BuildContext context) {
     ForgetPasswordVM forgetPasswordVM = useProvider(forgetPasswordVMProvider);
    useEffect(() {
      forgetPasswordVM.initForgetPasswordScreen(userName: userName);

      return () {
        // Dispose Objects here
      };
    }, []);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                child: Image.asset("assets/icons/loginBg.png"),
              ),
              SizedBox(
                height: ApplicationSizing.convert(30),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ApplicationSizing.convert(5)),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: ApplicationSizing.convert(20)
                      ),
                      margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: RichText(
                              text: TextSpan(
                                  text: "Forgot Password",
                                  style: Styles.PoppinsBold(
                                    fontSize: ApplicationSizing.fontScale(20),
                                    fontWeight: FontWeight.w700,
                                    color: appColor
                                  )),
                            ),
                          ),
                          Container(
                            child: RichText(
                              text: TextSpan(
                                  text: "Did you forget your password?",
                                  style: Styles.PoppinsRegular(
                                    fontSize: ApplicationSizing.fontScale(12),
                                    fontWeight: FontWeight.w400,
                                    color: fontGrayColor

                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                      text: "UserName/Email",
                                      style:  Styles.PoppinsRegular(
                                        fontSize: ApplicationSizing.fontScale(12),
                                        fontWeight: FontWeight.w700
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ApplicationSizing.convert(3),
                              ),
                              CustomTextField(
                                onchange: (val) {
                                  // fieldValidation("email");
                                },
                                textEditingController: forgetPasswordVM.emailController,
                                textInputType: TextInputType.emailAddress,
                                hints: "UserName/Email",
                                color1: forgetPasswordVM.error["email"][0] && forgetPasswordVM.error["email"][1] != ""
                                    ? errorColor
                                    : disableColor, onSubmit: (String val) {  },
                                // onSubmit: () {
                                //   // fieldValidation("email");
                                // },
                                isEnable: false,
                              ),
                              forgetPasswordVM.error["email"][0]
                                  ? ErrorText( text: forgetPasswordVM.error["email"][1] ?? "",)
                                  : Container()
                            ],
                          ),

                          Container(
                            child: RichText(
                              text: TextSpan(
                                  text: "Select the option to request a verification code",
                                  style: Styles.PoppinsRegular(
                                    fontSize: ApplicationSizing.convert(12),
                                    fontWeight: FontWeight.w700
                                  )
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: ApplicationSizing.convert(25)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RadioButton(
                                  buttonSelected: forgetPasswordVM.verificationWithPhone,
                                  onchange: forgetPasswordVM.verificationWithPhone || !isSmsVerify ? (){} : (){
                                    forgetPasswordVM.SetVerificationWithPhone(!forgetPasswordVM.verificationWithPhone);
                                  },
                                  text: "SMS",
                                  disableText: !isSmsVerify,
                                  LineWidth: ApplicationSizing.convertWidth( 38),
                                ),
                                SizedBox(width: ApplicationSizing.convertWidth(15),),
                                RadioButton(
                                  buttonSelected: forgetPasswordVM.verificationWithEmail,
                                  onchange: forgetPasswordVM.verificationWithEmail || !isEmailVerify ? (){} : (){
                                    forgetPasswordVM.SetVerificationWithEmail(!forgetPasswordVM.verificationWithEmail);
                                  },
                                  text: "Email",
                                  disableText: !isEmailVerify,
                                  LineWidth: ApplicationSizing.convertWidth(45),
                                ),

                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: FilledButton(
                                  // w: ApplicationSizing.convertWidth(120),
                                  // h: ApplicationSizing.convert(35),
                                  txt: "go back".toUpperCase(),
                                  color1: Colors.red,
                                  borderColor: Colors.red,
                                  borderwidth: 0,
                                  onTap: (){
                                    Navigator.pop(context);
                                  }
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: forgetPasswordVM.verifyOtpLoading
                                      ? loader()
                                      : FilledButton(
                                    // w: ApplicationSizing.convertWidth(120),
                                    // h: ApplicationSizing.convert(35),
                                    txt: "Submit".toUpperCase(),
                                    color1: forgetPasswordVM.verificationWithPhone || forgetPasswordVM.verificationWithEmail? appColor : appColor.withOpacity(0.5),
                                    borderColor: appColor,
                                    borderwidth: 0,
                                    onTap: forgetPasswordVM.verificationWithPhone || forgetPasswordVM.verificationWithEmail?
                                        () async {
                                      await forgetPasswordVM.sendVerificationCode(userName: userName ,sendBy: forgetPasswordVM.verificationWithPhone? "phone":"email");
                                      Navigator.push(applicationContext!.currentContext!, PageTransition(child: OtpVerification(
                                        userName: userName,
                                        sendBy: forgetPasswordVM.verificationWithPhone? "phone":"email",
                                      ), type: PageTransitionType.fade));

                                    } :(){print("none");},
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}