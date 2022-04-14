import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/forget-password-vm.dart';
import 'package:twochealthcare/views/auths/reset_password.dart';

class OtpVerification extends HookWidget {
  String userName;
  String userId;
  String? phone;
  String? bearerToken;
  bool isForgetPassword;
  bool from2FA;
  String sendBy;
  OtpVerification({required this.userName,this.phone, this.isForgetPassword = true,
    this.sendBy = "phone",this.from2FA = false,required this.userId,this.bearerToken});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordVM forgetPasswordVM = useProvider(forgetPasswordVMProvider);
    useEffect(() {

      forgetPasswordVM.initOtpVerificationScreen();
      if(from2FA) forgetPasswordVM.send2FACodeInStartUp(userId: userId, method: 0, bearerToken: bearerToken??"");

      return () {
        forgetPasswordVM.errorController?.close();
        // forgetPasswordVM.otpTextEditingController?.dispose();
        // Dispose Objects here
      };
    }, []);
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                              // color: Colors.red
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: ApplicationSizing.convert(25)),
                            margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Code Verification",
                                        style: Styles.PoppinsBold(
                                            fontSize: ApplicationSizing.fontScale(20),
                                            fontWeight: FontWeight.w700,
                                            color: appColor
                                        )),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Please enter the 6-digit code send to you at",
                                        style: Styles.PoppinsRegular(
                                            fontSize: ApplicationSizing.fontScale(12),
                                            color: fontGrayColor

                                        )),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: phone??userName,
                                        style: Styles.PoppinsRegular(
                                            fontSize: ApplicationSizing.fontScale(14),
                                            fontWeight: FontWeight.w700

                                        )),
                                  ),
                                ),
                                ApplicationSizing.verticalSpacer(n: 40),
                                PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  obscureText: false,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: ApplicationSizing.convert(40),
                                    fieldWidth: ApplicationSizing.convert(35),

                                    // disabledColor: appColor.withOpacity(0.3),
                                    activeColor: appColor,
                                    inactiveColor: Colors.grey,
                                    selectedColor: appColor,

                                    inactiveFillColor: Colors.white,
                                    selectedFillColor: Colors.white,
                                    activeFillColor: Colors.white,
                                  ),
                                  animationDuration: Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  errorAnimationController: forgetPasswordVM.errorController,
                                  keyboardType: TextInputType.number,
                                  controller: forgetPasswordVM.otpTextEditingController,
                                  cursorColor: appColor,
                                  cursorHeight: ApplicationSizing.convert(20),

                                  textStyle: Styles.PoppinsRegular(
                                    fontSize: ApplicationSizing.fontScale(20),
                                  ),
                                  onCompleted: (v) {
                                    print("Completed${v} ${forgetPasswordVM.otpTextEditingController?.text??""}");
                                    if(isForgetPassword){
                                      forgetPasswordVM.verifyResetPasswordCode(userName: userName,pinCode: v.toString());
                                    }
                                    else if(from2FA){
                                      forgetPasswordVM.verify2FA(otp: v.toString(), bearerToken: bearerToken??"");
                                    }
                                    else{
                                      forgetPasswordVM.verifyVerificationCodeToPhone(userName: userName,pinCode: v.toString());
                                    }
                                  },
                                  onChanged: (value) {
                                    forgetPasswordVM.setOtpLength(value.length);
                                  },
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");
                                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return true;
                                  },
                                ),
                                SizedBox(height: ApplicationSizing.convert(40),),
                                Container(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Didn’t receive code?",
                                          style: Styles.PoppinsRegular(
                                            fontSize: ApplicationSizing.fontScale(12),
                                            fontWeight: FontWeight.w400,
                                            color: fontGrayColor
                                          )
                                        ),
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                              if(isForgetPassword){
                                                forgetPasswordVM.sendVerificationCode(userName: userName,sendBy: sendBy);
                                              }else if(from2FA){
                                                forgetPasswordVM.send2FACode(userId: userId,method: 0, bearerToken: bearerToken??"");
                                              }
                                              else{
                                                forgetPasswordVM.sendVerificationCodeToPhone(userName: userName,phoneNumber: phone);
                                              }
                                          },
                                            text: "  Resend Code",
                                            style: Styles.PoppinsRegular(
                                                fontSize: ApplicationSizing.fontScale(12),
                                                fontWeight: FontWeight.w400,
                                                color: appColor
                                            )
                                        ),
                                      ]
                                    ),
                                  ),
                                ),
                                SizedBox(height: ApplicationSizing.convert(40),),
                                // Container(
                                //   child: forgetPasswordVM.verifyOtpLoading
                                //       ? loader()
                                //       : FilledButton(
                                //     txt: "Submit".toUpperCase(),
                                //     color1: forgetPasswordVM.otpLength >= 6 ? appColor : appColor.withOpacity(0.5),
                                //     borderColor: appColor,
                                //     borderwidth: 0,
                                //     onTap: forgetPasswordVM.otpLength >= 6 ?
                                //         () async {
                                //       forgetPasswordVM.SetVerifyOtpLoadingState(true);
                                //       await forgetPasswordVM.VerifyPinCode(userName: userName ,pinCode: forgetPasswordVM.otpTextEditingController?.text??"");
                                //       // Future.delayed(Duration(seconds: 2),(){applicatonState.SetVerifyOtpLoadingState(false)});
                                //     } :(){print("none");},
                                //   ),
                                // ),
                                FilledButton(
                                  txt: "go back".toUpperCase(),
                                  color1: appColor ,
                                  borderColor: appColor,
                                  borderwidth: 0,
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          forgetPasswordVM.verifyOtpLoading ? AlertLoader()  : Container(),
        ],
      ),
    );
  }




}