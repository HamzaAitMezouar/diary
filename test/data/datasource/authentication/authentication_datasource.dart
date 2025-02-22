import 'package:diary/core/constants/urls.dart';
import 'package:diary/core/errors/exceptions.dart';
import 'package:diary/data/datasource/authentication/authentication_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../core/error_handler.mocks.dart';

void main() {
  late AuthenticationDatasourceImpl datasource;
  late MockDio mockDio;
  late MockExceptionsHandler mockExceptionsHandler;
  late MockNetworkInfo mockNetworkInfo;
  late MockLocalizationService mockLocalizationService;

  setUp(() {
    mockDio = MockDio();
    mockLocalizationService = MockLocalizationService();
    mockNetworkInfo = MockNetworkInfo();
    mockExceptionsHandler = MockExceptionsHandler();
    datasource = AuthenticationDatasourceImpl(mockDio, mockExceptionsHandler);
  });

  group('requestOtpCode', () {
    const String phoneNumber = '+123456789';

    test('should return true when response status is 200', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenReturn(() async => true);
      when(() => mockDio.post(Urls.requestOtp, data: {"phone": phoneNumber})).thenReturn(
        () async => Response(statusCode: 200, requestOptions: RequestOptions(path: '')),
      );

      // Act
      final result = await datasource.requestOtpCode(phoneNumber);

      // Assert
      expect(result, true);
      verify(() => mockDio.post(Urls.requestOtp, data: {"phone": phoneNumber})).called(1);
    });

    test('should throw CustomException when there is no network', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenReturn(() async => true);
      when(() => mockLocalizationService.translate("network_error")).thenReturn(() => "No internet connection");

      // Act & Assert
      expect(() => datasource.requestOtpCode(phoneNumber), throwsA(isA<CustomException>()));
    });

    test('should throw CustomException when Dio throws an error', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenReturn(() async => true);
      when(() => mockDio.post(Urls.requestOtp, data: {"phone": phoneNumber})).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      when(() => mockLocalizationService.translate("timeout_error")).thenReturn(() => "Request timed out");

      // Act & Assert
      expect(() => datasource.requestOtpCode(phoneNumber), throwsA(isA<CustomException>()));
    });
  });
}
