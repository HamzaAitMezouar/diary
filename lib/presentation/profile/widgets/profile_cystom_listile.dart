import 'package:diary/core/exports.dart';
import 'package:diary/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomExpandedListTile extends StatelessWidget {
  const CustomExpandedListTile(
      {super.key,
      required this.user,
      required this.children,
      required this.icon,
      this.onClick,
      this.trailing,
      required this.title});

  final UserEntity user;
  final String title;
  final List<Widget> children;
  final IconData icon;
  final Widget? trailing;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: trailing,
      onExpansionChanged: (value) {
        if (onClick != null) {
          onClick!();
        }
      },

      tilePadding: const EdgeInsets.symmetric(horizontal: 30),
      leading: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: Borders.b12,
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 158, 11, 0), Color.fromRGBO(255, 67, 53, 1)]),
        ),
        child: Icon(
          icon,
        ),
      ),

      title: Text(
        title,
        style: GoogleFonts.aBeeZee(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: children,
      // trailing: Icon(
      //   Icons.arrow_forward_ios_sharp,
      //   color: context.textColor,
      // ),
    );
  }
}
