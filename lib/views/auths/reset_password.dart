import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/error_text.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/onlunch_activity_service.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/application_package_vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/home/home.dart';

class ResetPassword extends HookWidget {
  String userName;
  String pinCode;
   ResetPassword({required this.userName,required this.pinCode,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    ApplicationPackageVM applicationPackageVM = useProvider(applicationPackageVMProvider);
    SignalRServices signalRServices = useProvider(signalRServiceProvider);
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    OnLaunchActivityService onLaunchActivityService = useProvider(onLaunchActivityServiceProvider);
    ProfileVm profileVm = useProvider(profileVMProvider);

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
                    child: Image.asset("assets/icons/loginBg.png",
                    ),
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

  _loginform(BuildContext context, {required LoginVM loginVM,FirebaseService? firebaseService,
    ApplicationPackageVM? applicationPackageVM,
    SignalRServices? signalRServices,
    required ApplicationRouteService applicationRouteService,
    required OnLaunchActivityService onLaunchActivityService,
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
            margin: EdgeInsets.only(top: ApplicationSizing.convert(60)),
            child: RichText(
              text: TextSpan(
                  text: "Enter your new password",
                  style: Styles.PoppinsBold(
                      fontSize: ApplicationSizing.fontScale(22),
                      color: appColor)),
            ),
          ),
          ApplicationSizing.verticalSpacer(n: 50),
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
          ApplicationSizing.verticalSpacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RichText(
                  text: TextSpan(
                    text: "Confirm Password",
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
                  onchange: loginVM.onChangeConfirmPassword,
                  textEditingController: loginVM.confirmPasswordController,
                  textInputType: TextInputType.text,
                  hints: "Confirm Password",
                  color1:
                  loginVM.isConfirmPasswordFieldValid ? disableColor : errorColor,
                  onSubmit: (val) {
                    loginVM.fieldValidation(val, fieldType: 3);
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
              loginVM.isConfirmPasswordFieldValid
                  ? Container()
                  : ErrorText(text: loginVM.confirmPasswordErrorText),
            ],
          ),
          SizedBox(
            height: ApplicationSizing.convert(12),
          ),
          false
              ? Container(
            width: 10,
            height: 10,
            color: Colors.red,
          )
              : FilledButton(
            h: ApplicationSizing.convert(50),
            txt: "Submit",
            onTap: () async {
              // dd();
              // loginVM.setLoading(true);
              bool checkPassword = loginVM.fieldValidation(
                  loginVM.emailController.text,
                  fieldType: 4);

              if (checkPassword) {
                bool isValid = await loginVM.changePassword(userName: userName,pinCode: pinCode);
                if (isValid) {
                  onLaunchActivityService.syncLastApplicationUseDateAndTime();
                  applicationRouteService.addAndRemoveScreen(screenName: "Home");
                  onLaunchActivityService.decideUserFlow();
                  try{
                    await firebaseService?.initNotification();
                    await signalRServices?.initSignalR();
                    if(loginVM.currentUser?.userType == 1){
                      profileVm.getUserInfo();
                    }
                  }catch(e){
                    print("$e");
                  }

                }
              }
            },
          ),

        ],
      ),
    );
  }
}
