import 'dart:convert';

import 'package:diary/core/constants/urls.dart';
import 'package:diary/core/helpers/either_error_handler.dart';
import 'package:diary/core/params/social_media_params.dart';
import 'package:diary/core/responses/datasource_responses.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationDatasource {
  Future<bool> requestOtpCode(String phoneNumber);
  Future<AuthResponse> verifyOtpCode(String phoneNumber, String code);
  Future<bool> resendOtp(String phoneNumber);
  Future loginMail(String email, String password);
  Future<AuthResponse> socialMediaLogin(SocialMediaParams params);
  Future logout();
  Future addToken(String token);
}

class AuthenticationDatasourceImpl extends AuthenticationDatasource {
  final Dio _dio;
  final Dio _authDio;
  final ExceptionsHandler _exceptionsHandler;
  AuthenticationDatasourceImpl(this._dio, this._exceptionsHandler, this._authDio);
  @override
  Future loginMail(String email, String password) {
    // TODO: implement loginMail
    throw UnimplementedError();
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> requestOtpCode(String phoneNumber) async {
    var data = json.encode({
      "phone": phoneNumber,
    });
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.post(
        Urls.requestOtp,
        data: data,
      );
      return response.statusCode == 200;
    });
  }

  @override
  Future<bool> resendOtp(String phoneNumber) async {
    var data = json.encode({
      "phone": phoneNumber,
    });
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.post(
        Urls.resenOtp,
        data: data,
      );
      return response.statusCode == 200;
    });
  }

  @override
  Future<AuthResponse> socialMediaLogin(SocialMediaParams params) async {
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.post(
        Urls.socialMediaLogin,
        data: params.toJsonString(),
      );
      return AuthResponse.fromJson(response.data);
    });
  }

  @override
  Future<AuthResponse> verifyOtpCode(String phoneNumber, String code) {
    var data = json.encode({"phone": phoneNumber, "otp": code});
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _dio.post(
        Urls.verifyOtp,
        data: data,
      );

      return AuthResponse.fromJson(response.data);
    });
  }

  @override
  Future addToken(String token) {
    var data = json.encode({
      "token": token,
    });
    return _exceptionsHandler.dioExceptionsHandler(() async {
      var response = await _authDio.post(
        Urls.addToken,
        data: data,
      );

      return AuthResponse.fromJson(response.data);
    });
  }
}
