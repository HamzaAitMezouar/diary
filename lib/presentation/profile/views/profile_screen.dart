import 'dart:developer';
import 'package:image_cropper/image_cropper.dart';
import 'package:diary/core/exports.dart';
import 'package:diary/domain/entities/language.dart';
import 'package:diary/domain/entities/location_entity.dart';
import 'package:diary/domain/entities/user_entity.dart';
import 'package:diary/presentation/authentication/controllers/auth_state.dart';
import 'package:diary/widgets/custom_text_field.dart';
import 'package:diary/widgets/info_diaog.dart';
import 'package:diary/widgets/loading_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/custom_long_button.dart';
import '../../authentication/controllers/auth_notifier.dart';
import '../../authentication/views/authentication.dart';
import '../widgets/profile_action_list.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authNotifierProvider);

    if (authState is AuthInitial) return const SettingsLoading();
    if (authState is Authenticated) {
      return SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  xlSpacer(),
                  Column(
                    children: [
                      Stack(
                        children: [
                          _profileImageWidget(context, authState.user),
                          _uploadProfileImageIcon(authState.user, context, ref)
                        ],
                      ),
                    ],
                  ),
                  _userNameWidget(authState.user),
                  ProfileActionsList(
                    user: authState.user,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return const AuthenticationScreen();
  }
}

Positioned _uploadProfileImageIcon(UserEntity user, BuildContext context, WidgetRef ref) {
  return Positioned(
    bottom: 0,
    right: 0,
    child: IconButton(
        onPressed: () async {
          ref.read(authNotifierProvider.notifier).uploadImage();
        },
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Icon(
            CupertinoIcons.camera,
          ),
        )),
  );
}

GestureDetector _profileImageWidget(BuildContext context, UserEntity user) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      //   return PhotoHero(
      //     photo: "$baseUrl/${state.imagePath}",
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //   );
      // }));
    },
    child: Container(
      alignment: Alignment.center,
      height: 140,
      width: 140,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: Borders.b12,
          image: DecorationImage(
              image: user.image == null
                  ? AssetImage(Assets.avatarholder)
                  : NetworkImage(user.image!) as ImageProvider<Object>,
              fit: BoxFit.cover)),
      // child: Visibility(
      //     visible: imagestate is LoadingImagedState,
      //     child: const Center(
      //       child: CircularProgressIndicator(),
      //     )),
    ),
  );
}

Padding _userNameWidget(UserEntity user) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(
      user.name ?? "",
      style: TextStyles.robotoBold13,
    ),
  );
}
