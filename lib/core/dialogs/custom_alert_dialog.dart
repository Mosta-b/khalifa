import 'package:flutter/cupertino.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String positiveButtonText;
  final String negativeButtonText;
  final VoidCallback onPositivePressed;
  final VoidCallback? onNegativePressed;
  final bool leftDefaultAction;
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.positiveButtonText,
    required this.negativeButtonText,
    required this.onPositivePressed,
    this.onNegativePressed,
    this.leftDefaultAction = false,
  });

  @override
  Widget build(BuildContext context) {
    if (onNegativePressed != null) {
      return CupertinoAlertDialog(
        title: Center(child: Text(title)),
        content: Text(content, textAlign: TextAlign.center),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: leftDefaultAction,
            onPressed: onNegativePressed,
            child: Text(negativeButtonText),
          ),
          CupertinoDialogAction(
            isDefaultAction: leftDefaultAction ? false : true,
            onPressed: onPositivePressed,
            child: Text(positiveButtonText),
          )
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: Center(child: Text(title)),
        content: Text(content, textAlign: TextAlign.center),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onPositivePressed,
            child: Text(positiveButtonText),
          )
        ],
      );
    }
  }
}
