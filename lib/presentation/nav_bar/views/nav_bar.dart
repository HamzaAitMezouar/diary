import 'package:diary/core/constants/assets.dart';
import 'package:diary/presentation/map/views/map_screen.dart';
import 'package:diary/presentation/medicine/views/medicine.dart';
import 'package:diary/presentation/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exports.dart';
import '../../../widgets/expired_session_dialog.dart';
import '../../authentication/controllers/session_notifier.dart';
import '../../home/views/home_page.dart';
import '../controller/navbar_provider.dart';

class NavBarScreen extends ConsumerWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentItem = ref.watch(navigationControllerProvider);
    ref.listen(sessionProvider, (previous, next) {
      if (next == true) ExpiredSessionDialog()(context, ref);
    });
    return Scaffold(
      body: _pages[currentItem.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentItem.index,
        onTap: (index) {
          ref.read(navigationControllerProvider.notifier).selectItem(NavBarItem.values[index]);
        },
        selectedLabelStyle: TextStyles.roboto13.copyWith(fontSize: 11),
        unselectedLabelStyle: TextStyles.roboto13.copyWith(fontSize: 11),
        selectedItemColor: AppColors.superDark,
        unselectedItemColor: AppColors.superDark,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.home,
              height: D.md,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.drugs,
              height: D.md,
            ),
            label: 'Medicine',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.map,
              height: D.md,
            ),
            label: 'Pharmacy',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.profile,
              height: D.md,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

const List<Widget> _pages = [HomeScreen(), MedicineScreen(), MapScreen(), ProfileScreen()];
