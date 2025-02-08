import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diary/core/connection/connection.dart';
import 'package:diary/core/helpers/either_error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'errors_localization_provider.dart';

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(ref.watch(connectivityProvider));
});

final exceptionsHandlerProvider = Provider<ExceptionsHandler>((ref) {
  return ExceptionsHandler(
      localizationService: ref.watch(errosLocalizationServiceProvider), networkInfo: ref.watch(networkInfoProvider));
});
