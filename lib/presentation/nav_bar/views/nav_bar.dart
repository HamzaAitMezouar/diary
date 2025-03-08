import 'dart:developer';

import 'package:diary/presentation/cart/controllers/cart_notifier.dart';
import 'package:diary/presentation/map/views/map_screen.dart';
import 'package:diary/presentation/medicine/views/medicine.dart';
import 'package:diary/presentation/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/DI/socket_provider.dart';
import '../../../core/exports.dart';
import '../../../widgets/custom_long_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/expired_session_dialog.dart';
import '../../../widgets/info_diaog.dart';
import '../../authentication/controllers/auth_notifier.dart';
import '../../authentication/controllers/auth_state.dart';
import '../../authentication/controllers/session_notifier.dart';
import '../../authentication/views/authentication.dart';
import '../../home/views/home_page.dart';
import '../controller/navbar_provider.dart';

class NavBarScreen extends ConsumerWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen(authNotifierProvider, (previous, next) {
    //   log("iiiiiiiiiiiiiiiiiin");

    //   // if (next is Authenticated && next.user.name == null) {
    //   //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //   //     try {
    //   //       ConfirmActionDialog().showActionDialog(
    //   //         context,
    //   //         "Add name",
    //   //         "Please enter your name",
    //   //         [
    //   //           Padding(
    //   //             padding: Paddings.allXs,
    //   //             child: CustomTextField(controller: TextEditingController(), hintText: "Name"),
    //   //           ),
    //   //           CustomButton(onTap: () {}, title: "Enter"),
    //   //         ],
    //   //       );
    //   //     } catch (e) {
    //   //       log("Dialog Error: ${e.toString()}");
    //   //     }
    //   //   });
    //   // }
    // });
    ref.watch(cartProvider);
    final currentItem = ref.watch(navigationControllerProvider);
    ref.listen(sessionProvider, (previous, next) {
      if (next == true) {
        showBarModalBottomSheet(
            context: context,
            builder: (context) {
              return const AuthenticationScreen();
            });
      }
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
        selectedItemColor: Theme.of(context).textTheme.labelLarge?.color,
        unselectedItemColor: Theme.of(context).textTheme.labelLarge?.color,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.home,
              height: D.md,
              color: Theme.of(context).textTheme.labelLarge?.color,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.drug,
              height: D.md,
              color: Theme.of(context).textTheme.labelLarge?.color,
            ),
            label: 'Medicine',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.map,
              color: Theme.of(context).textTheme.labelLarge?.color,
              height: D.md,
            ),
            label: 'Pharmacy',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.profile,
              color: Theme.of(context).textTheme.labelLarge?.color,
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
