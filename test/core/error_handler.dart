import 'package:diary/core/helpers/either_error_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:diary/core/errors/exceptions.dart';
import 'package:diary/core/services/localization_service.dart';
import 'package:diary/core/connection/connection.dart';

import '../data/datasource/authentication/authentication_datasource.dart';

// Generate mocks for dependencies
import '../mocks.mocks.dart';
import 'error_handler.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<LocalizationService>(), MockSpec<NetworkInfo>(), MockSpec<ExceptionsHandler>(), MockSpec<Dio>()])
void main() {
  late ExceptionsHandler exceptionsHandler;
  late MockLocalizationService mockLocalizationService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalizationService = MockLocalizationService();
    mockNetworkInfo = MockNetworkInfo(); // Use the mocked NetworkInfo
    exceptionsHandler = ExceptionsHandler(mockLocalizationService, mockNetworkInfo);
  });

  group('dioExceptionsHandler', () {
    test('should return result when there is internet', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true); // Mock isConnected
      Future<int> testCall() async => 42;

      // Act
      final result = await exceptionsHandler.dioExceptionsHandler(testCall);

      // Assert
      expect(result, equals(42));
      verify(mockNetworkInfo.isConnected).called(1);
    });
  });
}
