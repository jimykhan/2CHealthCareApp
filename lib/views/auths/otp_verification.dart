import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/forget-password-vm.dart';

class OtpVerification extends HookWidget {
  String userName;
  OtpVerification({required this.userName});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordVM forgetPasswordVM = useProvider(forgetPasswordVMProvider);
    useEffect(() {
      forgetPasswordVM.errorController = StreamController<ErrorAnimationType>();
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
                                    text: "Please enter the 4-digit code send to you at",
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
                                    text: userName,
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
                              controller: forgetPasswordVM.textEditingController,
                              cursorColor: appColor,
                              cursorHeight: ApplicationSizing.convert(20),

                              textStyle: Styles.PoppinsRegular(
                                fontSize: ApplicationSizing.fontScale(20),
                              ),
                              onCompleted: (v) {
                                print("Completed${v} ${forgetPasswordVM.textEditingController?.text??""}");
                              },
                              onChanged: (value) {
                                forgetPasswordVM.setOtpLength(value.length);
                                print(value);
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
                              child: forgetPasswordVM.verifyOtpLoading
                                  ? loader()
                                  : FilledButton(
                                txt: "Submit".toUpperCase(),
                                color1: forgetPasswordVM.otpLength >= 6 ? appColor : appColor.withOpacity(0.5),
                                borderColor: appColor,
                                borderwidth: 0,
                                onTap: forgetPasswordVM.otpLength >= 6 ?
                                    () async {
                                  forgetPasswordVM.SetVerifyOtpLoadingState(true);
                                  await forgetPasswordVM.VerifyPinCode(userName: userName ,pinCode: forgetPasswordVM.textEditingController?.text??"");
                                  // Future.delayed(Duration(seconds: 2),(){applicatonState.SetVerifyOtpLoadingState(false)});
                                } :(){print("none");},
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: ApplicationSizing.convertWidth(120),
                                height: ApplicationSizing.convert(35),
                                child: Text("Go Back",
                                  style: Styles.PoppinsRegular(
                                    fontSize: ApplicationSizing.fontScale(14),),
                                ),
                              ),
                            ),
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
    );
  }




}