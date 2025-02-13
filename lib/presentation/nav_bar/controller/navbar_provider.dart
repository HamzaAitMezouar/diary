import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navbar_provider.g.dart';

enum NavBarItem { home, medicine, map, profile }

@riverpod
class NavigationController extends _$NavigationController {
  @override
  NavBarItem build() => NavBarItem.home;

  void selectItem(NavBarItem item) {
    state = item;
  }
}
