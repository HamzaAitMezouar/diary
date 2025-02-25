import 'package:diary/core/DI/dio_locator.dart';
import 'package:diary/core/DI/exception_handler_provider.dart';
import 'package:diary/core/DI/storage_provider.dart';
import 'package:diary/data/datasource/token/token_datasource.dart';
import 'package:diary/domain/repositories/token/token_repository.dart';
import 'package:diary/presentation/authentication/controllers/session_notifier.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final publicDioProvider = Provider<Dio>((ref) {
  return PublicDio().call();
});
final tokenDataSourceProvider = Provider<TokenRemoteDataSource>((ref) {
  return TokenRemoteDataSourceImpl(ref.watch(publicDioProvider));
});
final tokenRepositoryProvider = Provider<TokenRepository>((ref) {
  return TokenRepositoryImpl(
    ref.watch(tokenDataSourceProvider),
    ref.watch(exceptionsHandlerProvider),
    ref.watch(secureStorageHelperProvider),
  );
});

final authDioProvider = Provider<Dio>((ref) {
  final sessionNot = ref.watch(sessionProvider.notifier);
  final secureStorage = ref.watch(secureStorageHelperProvider);
  return AuthDio(ref.watch(tokenRepositoryProvider), sessionNot, secureStorage).call();
});
