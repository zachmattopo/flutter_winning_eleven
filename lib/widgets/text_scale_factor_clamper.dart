import 'package:flutter/material.dart';

/// Provides a lower bound (always 1.0) and upper bound to the system `textScaleFactor`,
/// allowing the users to control the text size without going completely overboard.
///
/// Reference: https://iiro.dev/restricting-system-text-scale-factor/
class TextScaleFactorClamper extends StatelessWidget {
  const TextScaleFactorClamper({
    required this.child,
    this.upperBound = 1.5,
    Key? key,
  }) : super(key: key);

  final Widget child;

  /// Set upper bound to the text scale factor.
  ///
  /// If `null`, defaults to `1.5`.
  final double upperBound;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final num constrainedTextScaleFactor =
        mediaQueryData.textScaleFactor.clamp(1.0, upperBound);

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaleFactor: constrainedTextScaleFactor as double?,
      ),
      child: child,
    );
  }
}
