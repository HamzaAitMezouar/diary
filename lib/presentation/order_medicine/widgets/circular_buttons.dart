import 'package:flutter/material.dart';

import '../../../core/exports.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: Borders.b50),
        elevation: 5,
        child: Center(child: Padding(padding: Paddings.allXxxxs, child: child)));
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
        right: D.xxxs,
        top: D.xxxxl + 2,
        height: D.xl,
        width: D.xl,
        child: CircularButton(
          child: Icon(Icons.share_outlined),
        ));
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
        right: D.xxxs,
        top: D.xmd,
        height: D.xl,
        width: D.xl,
        child: CircularButton(
          child: Icon(Icons.favorite_border),
        ));
  }
}
