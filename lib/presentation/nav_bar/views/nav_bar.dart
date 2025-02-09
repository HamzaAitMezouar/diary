import 'package:diary/presentation/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/views/home_page.dart';
import '../controller/navbar_provider.dart';

class NavBarScreen extends ConsumerWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentItem = ref.watch(navigationControllerProvider);
    final navigationController = ref.read(navigationControllerProvider.notifier);

    return Scaffold(
      body: _pages[currentItem.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentItem.index,
        onTap: (index) {
          navigationController.selectItem(NavBarItem.values[index]);
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
