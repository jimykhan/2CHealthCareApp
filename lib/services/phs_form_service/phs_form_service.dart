import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/app_data_models/country_model.dart';
import 'package:twochealthcare/models/phs_form_models/phs_form_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';

class PhsFormService {
  ProviderReference? _ref;
  DioServices? _dioServices;

  PhsFormService({ProviderReference? ref}) {
    _ref = ref;
    initService();
  }

  initService() {
    _dioServices = _ref!.read(dioServicesProvider);
  }

  getPhsFormById(int id) async {
    PhsFormModel phsFormModel;
    try {
      Response? res = await _dioServices?.dio
          ?.get(PhsFormController.getPHSFormRecordById + "/$id");
      if (res?.statusCode == 200) {
        phsFormModel = PhsFormModel.fromJson(res?.data);
        return phsFormModel;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> editQuestionOption(var body) async {
    try {
           Response? response = await _dioServices?.dio
        ?.put(PhsFormController.editPHSFormRecordOption, data: body);
    if (response?.statusCode == 200) {
      return true;
    }
    return false;
    } catch (e) {
      return false;
    }
  }

    Future<bool> submitPhsForm(var body) async {
    try {
           Response? response = await _dioServices?.dio
        ?.put(PhsFormController.editPHSFormRecord, data: body);
    if (response?.statusCode == 200) {
      SnackBarMessage(message: response?.data??"",error: false);
      return true;
    }
    return false;
    } catch (e) {
      return false;
    }
  }
}
