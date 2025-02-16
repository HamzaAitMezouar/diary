import 'dart:developer';
import 'package:dio/dio.dart';
import '../connection/connection.dart';
import '../errors/exceptions.dart';
import '../services/localization_service.dart';

class ExceptionsHandler {
  final LocalizationService _localizationService;
  final NetworkInfo _networkInfo;

  const ExceptionsHandler(this._localizationService, this._networkInfo);

  Future<T> dioExceptionsHandler<T>(Future<T> Function() call) async {
    if (!await _networkInfo.isConnected) {
      throw CustomException(message: _localizationService.translate("network_error"));
    }

    try {
      return await call();
    } on DioException catch (e) {
      log(e.toString());
      throw CustomException(message: _getDioErrorMessage(e));
    } catch (e) {
      throw UnexpectedException(message: 'An error occurred: ${e.toString()}');
    }
  }

  String _getDioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return _localizationService.translate('timeout_error');
      case DioExceptionType.connectionError:
        return _localizationService.translate('network_error');
      case DioExceptionType.cancel:
        return _localizationService.translate('cancelled_error');
      case DioExceptionType.badCertificate:
        return _localizationService.translate('certificate_error');
      case DioExceptionType.badResponse:
        return _localizationService.translate('server_error');
      case DioExceptionType.unknown:
      default:
        return e.response?.data?["message"] ?? _localizationService.translate('unknown_error');
    }
  }
}
