import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/get_divider_color.dart';
import 'add_qadiya_dialog.dart';

class AddQadiya extends StatelessWidget {
  const AddQadiya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
        side: BorderSide(color: Theme.of(context).primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: IntrinsicHeight(
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "اضف قضية جديدة",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              VerticalDivider(
                color: getDividerColor(context: context),
              ),
              IconButton(
                onPressed: () {
                  showAddQadiyaDialog(context: context);
                },
                icon: const Icon(
                  CupertinoIcons.plus_rectangle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
