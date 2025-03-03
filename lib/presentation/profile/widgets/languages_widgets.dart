import 'package:diary/core/exports.dart';
import 'package:flutter/material.dart';

class LanguagesListTile {
  LanguagesListTile._();

  static List<Widget> languagesListTiles(BuildContext context) {
    List<Widget> languages = [
      ListTile(
        onTap: () {},
        title: Text(
          "French",
          style: TextStyles.robotoBold13,
        ),
        // leading: SizedBox(height: 30, child: Image.asset(kiconLFR)),
      ),
      ListTile(
        onTap: () {},
        title: Text(
          "Arabic",
          style: TextStyles.robotoBold13,
        ),
        //  leading: SizedBox(height: 30, child: Image.asset(kiconAR)),
      ),
      ListTile(
        onTap: () {},
        title: Text(
          "English",
          style: TextStyles.robotoBold13,
        ),
        //leading: SizedBox(height: 30, child: Image.asset(kiconEn)),
      )
    ];
    return languages;
  }
}
