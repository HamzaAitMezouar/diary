import 'package:dio/dio.dart';

import '../../../core/constants/urls.dart';

abstract class TokenRemoteDataSource {
  Future<TokenResponse> refreshToken(String refreshToken);
}

class TokenRemoteDataSourceImpl implements TokenRemoteDataSource {
  final Dio _publicDio;

  TokenRemoteDataSourceImpl(this._publicDio);

  @override
  Future<TokenResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _publicDio.get(
        Urls.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accesstoken'];
      final newRefreshToken = response.data['refreshToken'];
      //:todo save new User

      return TokenResponse(accessToken: newAccessToken, refreshToken: newRefreshToken);
    } catch (e) {
      rethrow;
    }
  }
}

class TokenResponse {
  final String? accessToken;
  final String? refreshToken;

  TokenResponse({this.accessToken, this.refreshToken});
}
