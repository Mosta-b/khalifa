import 'package:flutter/material.dart';

import 'generic_dialogue.dart';

Future<void> showErrorDialog(
  final BuildContext context,
  final String title,
  final String content,
) {
  return showGenericDialog<void>(
    context: context,
    title: title,
    content: content,
    optionBuilder: () => {'Ok': null},
  );
}
