import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/core/helpers/either_error_handler.dart';
import 'package:diary/data/datasource/token/token_datasource.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/helpers/secure_storage_helper.dart';

abstract class TokenRepository {
  Future<Either<Failure, TokenResponse>> refreshToken();
}

class TokenRepositoryImpl extends TokenRepository {
  final TokenRemoteDataSource _dataSource;
  final ExceptionsHandler _exceptionsHandler;
  final SecureStorageHelper _storageHelper;
  TokenRepositoryImpl(this._dataSource, this._exceptionsHandler, this._storageHelper);
  @override
  Future<Either<Failure, TokenResponse>> refreshToken() async {
    try {
      String? refreshToken = await _storageHelper.getRefreshToken();

      if (refreshToken == null) return Left(CacheFailure(errorMessage: "Something went wrong"));
      TokenResponse response =
          await _exceptionsHandler.dioExceptionsHandler(() => _dataSource.refreshToken(refreshToken));
      return Right(response);
    } on CustomException catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
