import 'package:flutter/material.dart';
import 'package:khalifa/core/constant/theme/app_fonts.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.mainStyle = true,
  });

  final String title;
  final Function() onPressed;

  final bool mainStyle;

  @override
  Widget build(BuildContext context) {
    final textTheme =
        mainStyle ? FontsManger.mainFont : FontsManger.secondaryFont;
    return ElevatedButton(
      style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(200)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: textTheme,
      ),
    );
  }
}
