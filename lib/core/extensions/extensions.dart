import 'package:flutter/foundation.dart';

import '../enums/enum.dart';

extension StringEx on String? {
  // throw Exception when in debug mode if string is null
  String get orEmpty {
    if (kDebugMode) {
      throw Exception('null value in String');
    }
    return "";
  }
}

extension MawadieExtension on Mawadie {
  String toMap() {
    return this.toString().split('.').last;
  }

  static Mawadie fromMap(String value) {
    return Mawadie.values.firstWhere(
      (element) => element.toString().split('.').last == value,
      orElse: () => Mawadie.politics, // Default value if not found
    );
  }
}
