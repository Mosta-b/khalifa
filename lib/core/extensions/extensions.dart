import 'package:flutter/foundation.dart';

extension StringEx on String? {
  // throw Exception when in debug mode if string is null
  String get orEmpty {
    if (kDebugMode) {
      throw Exception('null value in String');
    }
    return "";
  }
}
