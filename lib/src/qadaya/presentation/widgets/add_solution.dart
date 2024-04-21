import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/get_divider_color.dart';
import 'add_solution_dialog.dart';

class AddSolution extends StatelessWidget {
  const AddSolution({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
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
                "اضف حل جديد",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              VerticalDivider(
                color: getDividerColor(context: context),
              ),
              IconButton(
                onPressed: () {
                  showAddSolutionDialog(context: context);
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
