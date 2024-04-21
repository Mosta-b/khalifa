import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();
Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder,
}) {
  final options = optionBuilder();
  return showCupertinoModalPopup(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.withOpacity(0.2),
        child: CupertinoAlertDialog(
          // backgroundColor: Colors.white,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            textAlign: TextAlign.center,
            content,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          // icon: Icon(icon, size: 50),
          // iconColor: iconColor,
          actions: options.keys.map(
            (optionTitle) {
              final value = options[optionTitle];
              return Center(
                child: TextButton(
                    onPressed: () {
                      if (value != null) {
                        Navigator.of(context).pop(value);
                      } else {
                        Navigator.of(context).maybePop();
                      }
                    },
                    child: Text(optionTitle)),
              );
            },
          ).toList(),
        ),
      );
    },
  );
}
