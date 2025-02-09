import 'dart:developer';

import 'package:dio/dio.dart';

import '../connection/connection.dart';
import '../errors/exceptions.dart';
import '../services/localization_service.dart';

class ExceptionsHandler {
  final LocalizationService localizationService;
  final NetworkInfo networkInfo;
  ExceptionsHandler({required this.localizationService, required this.networkInfo});

  Future<T> dioExceptionsHandler<T>(Future<T> Function() call) async {
    try {
      if (await networkInfo.isConnected!) return await call();
      String translatedMessage = localizationService.translate("network_error");
      return throw CustomException(message: translatedMessage);
    } on DioException catch (e) {
      String messageKey;
      log(e.toString());
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          messageKey = 'timeout_error';
          break;
        case DioExceptionType.connectionError:
          messageKey = 'network_error';
          break;
        case DioExceptionType.cancel:
          messageKey = 'cancelled_error';
          break;
        case DioExceptionType.badCertificate:
          messageKey = 'certificate_error';
          break;
        case DioExceptionType.unknown:
        default:
          throw CustomException(message: e.response?.data?["message"] ?? "Unexcpected error");
      }

      String translatedMessage = localizationService.translate(messageKey);

      throw CustomException(message: translatedMessage);
    } catch (e) {
      throw UnexpectedException(message: 'An error occurred: ${e.toString()}');
    }
  }
}
