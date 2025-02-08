import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routes/router.dart';

final goRouterProviderProvider = Provider<GoRouterProvider>((ref) {
  return GoRouterProvider();
});
