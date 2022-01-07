import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/io_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/models/health_guide_models/health_guide_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/util/conversion.dart';
class HealthGuidesService {

  ProviderReference? _ref;
  AuthServices? _authServices;
  DioServices? dio;
  HealthGuidesService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);
     dio = _ref!.read(dioServicesProvider);
  }


  Future<List<HealthGuideModel>> getAllHealthGuides() async{
    List<HealthGuideModel> healthGuides = [];
    try{
      var response = await dio!.dio!.get(ApiStrings.healthGuideLines);
      if(response.statusCode == 200){
        response.data.forEach((element) {
          healthGuides.add(HealthGuideModel.fromJson(element));
        });
        healthGuides.forEach((element) {
          if(element.createdOn != null){
            convertLocalToUtc(element.createdOn!.replaceAll("Z", ""));
            element.createdOn = Jiffy(element.createdOn).format(Strings.dateAndTimeFormat);
          }
        });
      }
      return healthGuides;
    }
    catch(e){
      return healthGuides;
    }
  }

}