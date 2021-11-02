import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/error_handlers.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';

class ApiInterceptor extends Interceptor{
  ProviderReference? ref;
  ApiInterceptor({this.ref});
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    // SnackBarMessage(message: err.response!.data.toString());
    super.onError(err, handler);
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            SnackBarMessage(message: err.response!.data??"");
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
     LoginVM loginVM =  ref!.read(loginVMProvider);

    // TODO: implement onRequest
    options.headers = {
      "Authorization": "Bearer ${loginVM.currentUser?.bearerToken??""}"
    };
    print(options.path);
    super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(response.data);
    // print()
    super.onResponse(response, handler);
  }
}