import 'package:flutter/material.dart';

import '../core/exports.dart';

class AdaptiveDialogScreen {
  void call(BuildContext context, String text, String title) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class ConfirmActionDialog {
  Future<dynamic> showActionDialog(
    BuildContext context,
    String title,
    String message,
    List<Widget> actions, {
    double? titleWidth,
    TextStyle? titleStyle,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: Container(
            //  height: height ?? Dimensions.xxxxxxl * 3 - 23,
            decoration: BoxDecoration(
              borderRadius: Borders.b12,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: D.lg),
                        child: SizedBox(
                          width: titleWidth ?? D.xxxxxxl * 2,
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: titleStyle ?? TextStyles.robotoBold22,
                          ),
                        ),
                      ),
                    ),
                    xxsSpacer(),
                    message != ""
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: Paddings.horizontalXs,
                              child: Text(message, textAlign: TextAlign.center, style: TextStyles.robotoBold15),
                            ),
                          )
                        : const SizedBox(),
                    //
                    xsSpacer(),
                    ...actions,

                    xsSpacer(),
                  ],
                ),
                const Positioned(
                  top: D.xxxs,
                  right: D.xxxs,
                  child: CloseButton(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
