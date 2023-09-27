import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/phs_form_models/phs_question_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/phs_form/components/muti_option_select_question.dart';
import 'package:twochealthcare/views/phs_form/components/signal_option_select_question.dart';
import 'package:twochealthcare/views/phs_form/phs_form_view_model.dart';

class PhsFormScreen extends HookWidget {
  String? id;
  PhsFormScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // ApplicationSizing(applicationContext?.currentContext);
    PhsFormVeiwModel phsFormVeiwModel = useProvider(phsFormVMProvider);
    // OnLaunchActivityAndRoutesService onLaunchActivityAndRoutesService = useProvider(onLaunchActivityServiceProvider);
    // ConnectivityService connectivityService = useProvider(connectivityServiceProvider);
    // ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);

    useEffect(
      () {
        // onLaunchActivityAndRoutesService.handleMessage();
        // connectivityService.checkInternetConnection();
        id != null ? ApplicationSizing(applicationContext?.currentContext) : null;
        phsFormVeiwModel.initPshFormScreen();
        Future.microtask(() async {});
        phsFormVeiwModel.getPhsFormById(int.parse(id ?? "9"));
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        primary: false,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
          child: CustomAppBar(
            facilityIcon: false,
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(70),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Phs Form",
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              phsFormVeiwModel.loadingQuestion
                  ? Container()
                  : phsFormVeiwModel.phsFormModel == null
                      ? NoData()
                      : Container(
                        child: Stack(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ListView.separated(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  PhsFormQuestionRecords
                                                      question = phsFormVeiwModel
                                                              .phsFormModel!
                                                              .phsFormQuestionRecords![
                                                          index];
                                                  return question
                                                              .phsquestionType ==
                                                          PhsQuestionType
                                                              .multiSelect
                                                      ? MutiSelectOptionQuestion(
                                                          onOptionClick:
                                                              (id, isSelected) {
                                                            phsFormVeiwModel
                                                                .onSelectOption(
                                                                    questionId:
                                                                        question.id ??
                                                                            0,
                                                                    optionId: id,
                                                                    selected:
                                                                        isSelected,
                                                                    isMultiSelect:
                                                                        true);
                                                          },
                                                          phsFormOptionRecords:
                                                              question.phsFormOptionRecords ??
                                                                  [],
                                                          question: question
                                                                  .description ??
                                                              "",
                                                        )
                                                      : (question
                                                                      .phsquestionType ==
                                                                  PhsQuestionType
                                                                      .singleSelect ||
                                                              question.phsquestionType ==
                                                                  PhsQuestionType
                                                                      .linearScale ||
                                                              question.phsquestionType ==
                                                                  PhsQuestionType
                                                                      .yesNo)
                                                          ? Container(
                                                              child:
                                                                  SignalSelectOptionQuestion(
                                                                onOptionClick:
                                                                    (id) {
                                                                  phsFormVeiwModel.onSelectOption(
                                                                      questionId:
                                                                          question.id ??
                                                                              0,
                                                                      optionId:
                                                                          id,
                                                                      selected:
                                                                          true,
                                                                      isMultiSelect:
                                                                          false);
                                                                },
                                                                phsFormOptionRecords:
                                                                    question.phsFormOptionRecords ??
                                                                        [],
                                                                question: question
                                                                        .description ??
                                                                    "",
                                                              ),
                                                            )
                                                          : Container(
                                                              child: Text(
                                                                "",
                                                              ),
                                                            );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Container(
                                                    height: 20,
                                                  );
                                                },
                                                itemCount: phsFormVeiwModel
                                                        .phsFormModel
                                                        ?.phsFormQuestionRecords
                                                        ?.length ??
                                                    0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: CustomFilledButton(
                                                h: 40,
                                                onTap: () =>
                                                    phsFormVeiwModel.onPostForm(
                                                        formId: phsFormVeiwModel
                                                                .phsFormModel
                                                                ?.id ??
                                                            0,
                                                        formSubmit: false),
                                                txt: "Save",
                                                color1: appColorSecondary,
                                              )),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: CustomFilledButton(
                                                h: 40,
                                                onTap: () =>
                                                    phsFormVeiwModel.onPostForm(
                                                        formId: phsFormVeiwModel
                                                                .phsFormModel
                                                                ?.id ??
                                                            0,
                                                        formSubmit: true),
                                                txt: "Submit",
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              phsFormVeiwModel.loadingOption
                                  ? AlertLoader()
                                  : Container(),
                            ],
                          ),
                      ),
              phsFormVeiwModel.loadingQuestion ? AlertLoader() : Container(),
            ],
          ),
        ));
  }
}
