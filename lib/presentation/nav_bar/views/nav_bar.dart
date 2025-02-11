import 'package:diary/presentation/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

final List<Widget> _pages = [HomeScreen(), const Center(child: Text('Search Page')), ProfileScreen()];
