import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  /// Sets the primary color of the whole app.
  /// Currently set to `Colors.deepPurple` to resemble BT main color.
  static MaterialColor get appColor => Colors.deepPurple;

  /// Formats the [DateTime] object to `yyyy-MM-dd` string format.
  static String formatYYYYMMDD(DateTime dateTime) {
    final dateFilterDateFormat = DateFormat('yyyy-MM-dd');
    return dateFilterDateFormat.format(dateTime);
  }
}
