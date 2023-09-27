import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/phs_form_models/phs_form_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/phs_form_service/phs_form_service.dart';
import 'package:flutter/services.dart';

class PhsFormVeiwModel extends ChangeNotifier {
  ProviderReference? _ref;
  PhsFormService? _pshFormServiceProvider;
  PhsFormModel? phsFormModel;
  bool loadingQuestion = true;
  bool loadingOption = false;

  static const deepLinkChannel = const MethodChannel('deeplink_channel');

  PhsFormVeiwModel({ProviderReference? ref}) {
    _ref = ref;
    _pshFormServiceProvider = _ref?.read(phsFormServiceProvider);
  }

  initPshFormScreen(){
    loadingQuestion = true;
    loadingOption = false;
  }

  getPhsFormById(int id) async {
    try {
      phsFormModel = await _pshFormServiceProvider?.getPhsFormById(id);
      setLoadingQuestion(false);
    } catch (e) {
      setLoadingQuestion(false);
      return null;
    }
  }

  setLoadingQuestion(flag) {
    loadingQuestion = flag;
    notifyListeners();
  }



  setLoadingOption(flag) {
    loadingOption = flag;
    notifyListeners();
  }

  onSaveForm() {}

  onPostForm({required int formId, required bool formSubmit}) async {
    try {
      setLoadingOption(true);
      var body = {"formId": formId, "isSubmitted": formSubmit};
      var res = await _pshFormServiceProvider?.submitPhsForm(body);
      setLoadingOption(false);
    } catch (e) {
      setLoadingOption(false);
      return null;
    }
  }

  onSelectOption(
      {required int questionId,
      required int optionId,
      required bool selected,
      required bool isMultiSelect}) async {
    try {
      var body = {
        "optionId": optionId,
        "isSelected": selected,
        "questionId": questionId
      };
      setLoadingOption(true);
      bool res =
          await _pshFormServiceProvider?.editQuestionOption(body) ?? false;
      if (res) {
        phsFormModel?.phsFormQuestionRecords?.forEach((question) {
          if (question.id == questionId) {
            question.phsFormOptionRecords?.forEach((option) {
              if (isMultiSelect) {
                if (option.id == optionId) option.isSelected = selected;
              } else {
                if (option.id == optionId) {
                  option.isSelected = true;
                } else {
                  option.isSelected = false;
                }
              }
            });
          }
        });
      }
      setLoadingOption(false);
    } catch (e) {
      setLoadingOption(false);
      return null;
    }
  }
}
