import 'package:diary/core/exports.dart';
import 'package:diary/domain/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'languages_widgets.dart';
import 'profile_cystom_listile.dart';

class ProfileActionsList extends StatelessWidget {
  const ProfileActionsList({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: Borders.b12),
      child: Column(
        children: [
          CustomExpandedListTile(
            user: user,
            icon: CupertinoIcons.globe,
            title: "Languages",
            children: [
              for (Widget widget in LanguagesListTile.languagesListTiles(context))
                Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: widget)
            ],
          ),
          CustomExpandedListTile(
            user: user,
            icon: CupertinoIcons.moon_stars,
            title: "DarkMode",
            trailing: const AndroidSwitchTheme(),
            children: const [],
          ),
          CustomExpandedListTile(
            user: user,
            icon: Icons.logout,
            title: "logout",
            trailing: const LogOutButton(),
            children: const [],
            onClick: () {},
          ),
        ],
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () async {}, icon: const Icon(Icons.logout));
  }
}

class AndroidSwitchTheme extends StatelessWidget {
  const AndroidSwitchTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
        activeThumbColor: Colors.grey,
        activeThumbImage: AssetImage(Assets.dark),
        inactiveThumbImage: AssetImage(Assets.light),
        inactiveTrackColor: const Color.fromARGB(255, 224, 224, 224),
        value: false,
        onChanged: (value) {});
  }
}
