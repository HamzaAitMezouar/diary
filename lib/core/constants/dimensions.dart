import 'package:flutter/material.dart';

//Dimension
class D {
  D._();

  static const _base = 4.0;

  /// 4
  static const xxxxs = _base;

  /// 8
  static const xxxs = 2 * _base;

  /// 12
  static const xxs = 3 * _base;

  /// 16
  static const xs = 4 * _base;

  /// 20
  static const sm = 5 * _base;

  /// 24
  static const md = 6 * _base;

  /// 28
  static const xmd = 7 * _base;

  /// 32
  static const lg = 8 * _base;

  /// 36
  static const xlg = 9 * _base;

  /// 40
  static const xl = 10 * _base;

  /// 44
  static const xxlg = 11 * _base;

  /// 48
  static const xxl = 12 * _base;

  /// 56
  static const xxxl = 14 * _base;

  /// 64
  static const xxxxl = 16 * _base;

  /// 84
  static const xxxxxl = 21 * _base;

  /// 100
  static const xxxxxxl = 25 * _base;

  /// 27 common spacing for the whole UI
  static const commonSpacing = 6.75 * _base;
}

/// 2
Widget xxxxxsSpacer() => _spacer(D.xxxxs / 2);

/// 4
Widget xxxxsSpacer() => _spacer(D.xxxxs);

/// 8
Widget xxxsSpacer() => _spacer(D.xxxs);

/// 12
Widget xxsSpacer() => _spacer(D.xxs);

/// 16
Widget xsSpacer() => _spacer(D.xs);

/// 20
Widget smSpacer() => _spacer(D.sm);

/// 24
Widget mdSpacer() => _spacer(D.md);

/// 28
Widget xmdSpacer() => _spacer(D.xmd);

/// 32
Widget lgSpacer() => _spacer(D.lg);

/// 36
Widget xlgSpacer() => _spacer(D.xlg);

/// 40
Widget xlSpacer() => _spacer(D.xl);

/// 48
Widget xxlSpacer() => _spacer(D.xxl);

/// 56
Widget xxxlSpacer() => _spacer(D.xxxl);

/// 64
Widget xxxxlSpacer() => _spacer(D.xxxxl);

//27
Widget commonSpacer() => _spacer(D.commonSpacing);

Widget _spacer(double size) => SizedBox(height: size, width: size);
