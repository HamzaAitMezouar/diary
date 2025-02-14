import 'package:diary/core/constants/app_colors.dart';
import 'package:diary/core/constants/border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exports.dart';
import '../controller/add_reminder_provider/add_reminder_provider.dart';

class DropdownWithWrap extends ConsumerStatefulWidget {
  const DropdownWithWrap({super.key});

  @override
  DropdownWithWrapState createState() => DropdownWithWrapState();
}

class DropdownWithWrapState extends ConsumerState<DropdownWithWrap> {
  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool isDropdownOpen = false;

  void toggleDropdown() {
    if (isDropdownOpen) {
      closeDropdown();
    } else {
      openDropdown();
    }
  }

  List<String> medTypes = [
    Assets.pill,
    Assets.spray,
    Assets.inhaller,
    Assets.oxygen,
    Assets.nasal,
    Assets.lotion,
    Assets.injection,
    Assets.drop,
    Assets.syrop,
    Assets.bandage,
  ];
  void openDropdown() {
    overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      isDropdownOpen = true;
    });
  }

  void closeDropdown() {
    overlayEntry?.remove();
    overlayEntry = null;
    setState(() {
      isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(-200, 40), // Position below button
          child: Material(
            elevation: 4,
            borderRadius: Borders.b12,
            color: AppColors.backgroundColor,
            child: Padding(
              padding: Paddings.allXxxxs,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: List.generate(medTypes.length, (index) {
                  return GestureDetector(
                      onTap: () {
                        ref.read(medicineReminderProvider.notifier).changeIcon(medTypes[index]);
                        closeDropdown();
                      },
                      child: Container(
                        width: D.xl,
                        height: D.xl,
                        padding: const EdgeInsets.all(8),
                        decoration:
                            BoxDecoration(color: AppColors.sofGrey, borderRadius: Borders.b12, boxShadow: const [
                          BoxShadow(
                            color: AppColors.grey,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(1, 1),
                          ),
                        ]),
                        child: Center(
                          child: Image.asset(medTypes[index], width: D.xmd, height: D.xmd, fit: BoxFit.cover),
                        ),
                      ));
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reminderState = ref.watch(medicineReminderProvider);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: AppColors.sofGrey, borderRadius: Borders.b12, boxShadow: const [
        BoxShadow(
          color: AppColors.grey,
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(1, 1),
        ),
      ]),
      child: Center(
        child: CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: toggleDropdown,
            child: Image.asset(reminderState.icon, width: 30, height: 30, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
