import 'package:diary/core/DI/dio_provider.dart';
import 'package:diary/core/DI/exception_handler_provider.dart';
import 'package:diary/data/datasource/authentication/authentication_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/authentication/authentication_repository.dart';
import '../../../domain/usecases/authentication/logout_case.dart';
import '../../../domain/usecases/authentication/request_otp_case.dart';
import '../../../domain/usecases/authentication/resend_otp_case.dart';
import '../../../domain/usecases/authentication/social_media_login_case.dart';
import '../../../domain/usecases/authentication/verify_otp_case.dart';

final authDatasourceProvider = Provider<AuthenticationDatasource>(
  (ref) => AuthenticationDatasourceImpl(ref.watch(publicDioProvider), ref.watch(exceptionsHandlerProvider)),
);
final authRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    remoteDataSource: ref.watch(authDatasourceProvider),
  ),
);

final requestOtpUseCaseProvider = Provider<RequestOtpUseCase>(
  (ref) => RequestOtpUseCase(ref.watch(authRepositoryProvider)),
);

final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>(
  (ref) => VerifyOtpUseCase(ref.watch(authRepositoryProvider)),
);

final resendOtpUseCaseProvider = Provider<ResendOtpUseCase>(
  (ref) => ResendOtpUseCase(ref.watch(authRepositoryProvider)),
);

final socialMediaLoginUseCaseProvider = Provider<SocialMediaLoginUseCase>(
  (ref) => SocialMediaLoginUseCase(ref.watch(authRepositoryProvider)),
);

final logoutUseCaseProvider = Provider<LogOutUseCase>(
  (ref) => LogOutUseCase(ref.watch(authRepositoryProvider)),
);
