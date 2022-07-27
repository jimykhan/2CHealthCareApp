import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/error_text.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/application_package_vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/auths/components/privacy_policy.dart';
import 'package:twochealthcare/views/home/home.dart';

class Login extends HookWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    ApplicationPackageVM applicationPackageVM = useProvider(applicationPackageVMProvider);
    SignalRServices signalRServices = useProvider(signalRServiceProvider);
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    OnLaunchActivityAndRoutesService onLaunchActivityService = useProvider(onLaunchActivityServiceProvider);
    ProfileVm profileVm = useProvider(profileVMProvider);

    useEffect(
      () {
        loginVM.isPrivacyPolicyChecked = false;
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
                    child: Image.asset("assets/icons/loginBg.png",),
                  ),
                  _loginform
                    (context, loginVM: loginVM,firebaseService: firebaseService,applicationPackageVM: applicationPackageVM,
                  applicationRouteService: applicationRouteService,
                  onLaunchActivityService: onLaunchActivityService,
                    profileVm: profileVm,
                      signalRServices: signalRServices
                  ),

                ],
              ),
              loginVM.loading ? AlertLoader() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _loginform(BuildContext context, {LoginVM? loginVM,FirebaseService? firebaseService,
    ApplicationPackageVM? applicationPackageVM,
  SignalRServices? signalRServices,
    required ApplicationRouteService applicationRouteService,
    required OnLaunchActivityAndRoutesService onLaunchActivityService,
    required ProfileVm profileVm
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ApplicationSizing.fontScale(5)),
      ),
      padding:
          EdgeInsets.symmetric(horizontal: ApplicationSizing.convertWidth(20)),
      margin:
          EdgeInsets.symmetric(horizontal: ApplicationSizing.convertWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(40)),
            child: RichText(
              text: TextSpan(
                  text: "Welcome,",
                  style: Styles.PoppinsBold(
                      fontSize: ApplicationSizing.fontScale(22),
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
          ApplicationSizing.verticalSpacer(n: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RichText(
                  text: TextSpan(
                    text: "Email/Username",
                    style: Styles.PoppinsBold(
                        fontSize: ApplicationSizing.fontScale(12),
                        color: Colors.black),
                  ),
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: CustomTextField(
                  checkFocus: (val){},
                  onchange: loginVM!.onChangeEmail,
                  textEditingController: loginVM.emailController,
                  textInputType: TextInputType.emailAddress,
                  hints: "Email / User Name",
                  color1: loginVM.isEmailFieldValid ? disableColor : errorColor,
                  onSubmit: (val) {
                    loginVM.fieldValidation(val, fieldType: 0);
                  },
                ),
              ),
              loginVM.isEmailFieldValid
                  ? Container()
                  : ErrorText(text: loginVM.emailErrorText),
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
                        color: Colors.black),
                  ),
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: CustomTextField(
                  checkFocus: (val){},
                  onchange: loginVM.onChangePassword,
                  textEditingController: loginVM.passwordController,
                  textInputType: TextInputType.text,
                  hints: "Password",
                  color1:
                      loginVM.isPasswordFieldValid ? disableColor : errorColor,
                  onSubmit: (val) {
                    loginVM.fieldValidation(val, fieldType: 1);
                  },
                  // trailingIcon: ,
                  obscureText: loginVM.obscureText,
                  trailingIcon: InkWell(
                    onTap: () {
                      loginVM.obscureText = !loginVM.obscureText;
                      loginVM.notifyListeners();
                    },
                    child: Container(
                      child: !loginVM.obscureText
                          ? Icon(
                        IcoFontIcons.eye,
                        color: Colors.green.shade600,
                        // color: Colors.grey.shade500,
                      )
                          : Icon(
                        IcoFontIcons.eyeBlocked,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),
              loginVM.isPasswordFieldValid
                  ? Container()
                  : ErrorText(text: loginVM.passwordErrorText),
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
                        if (loginVM.fieldValidation(loginVM.emailController.text)){
                          loginVM.isSmsOrEmailVerified();
                        }

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
          PrivacyPolicy(
            isChecked: loginVM.isPrivacyPolicyChecked,
            onChecked: loginVM.onCheckedPrevacyPolicy,
          ),
          SizedBox(height: 10,),
          false
              ? Container(
                  width: 10,
                  height: 10,
                  color: Colors.red,
                )
              : FilledButton(
                  h: ApplicationSizing.convert(50),
                  txt: "Login",
                  color1: !(loginVM.isPrivacyPolicyChecked) ? appColorLight : null,
                  onTap: !(loginVM.isPrivacyPolicyChecked) ? null : () async {
                    // dd();
                    // loginVM.setLoading(true);
                    bool checkMail = loginVM.fieldValidation(
                        loginVM.emailController.text,
                        fieldType: 0);
                    bool checkPassword = loginVM.fieldValidation(
                        loginVM.passwordController.text,
                        fieldType: 1);
                    if (checkMail && checkPassword) {
                      bool isValid = await loginVM.userLogin();
                      if (isValid) {
                        applicationRouteService.addAndRemoveScreen(screenName: "Home");
                        firebaseService?.subNotification();
                        onLaunchActivityService.decideUserFlow();
                        onLaunchActivityService.syncLastApplicationUseDateAndTime();
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
                    text: applicationPackageVM?.currentVersion??"",
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
