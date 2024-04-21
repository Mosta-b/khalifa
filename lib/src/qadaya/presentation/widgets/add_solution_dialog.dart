import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/enum.dart';
import '../../../../core/services/qadiaya_validator.dart';
import '../../../../core/utils/get_divider_color.dart';

Future<void> showAddSolutionDialog({required BuildContext context}) {
  return showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      final qadiya = GlobalKey<FormState>();
      Mawadie selectedMawadie = Mawadie.society;
      final TextEditingController title = TextEditingController();
      return CupertinoAlertDialog(
        title: const Text("اضافة حل"),
        content: Form(
          key: qadiya,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CupertinoTextFormFieldRow(
                textDirection: TextDirection.rtl,
                placeholder: "العنوان",
                controller: title,
                textAlign: TextAlign.end,
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: getDividerColor(context: context),
                ),
                validator: (value) {
                  return value != null
                      ? HandleQadiayaValidation().validateArabicText(value)
                      : "can't no title";
                },
              ),
              Divider(
                color: getDividerColor(context: context),
                endIndent: 25,
                indent: 25,
              ),
              SizedBox(
                height: 60,
                width: 290,
                child: SegmentedButton<Mawadie>(
                  style: const ButtonStyle(
                    textStyle: MaterialStatePropertyAll<TextStyle>(
                        TextStyle(fontSize: 10)),
                    padding: MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.all(0),
                    ),
                  ),
                  segments: const <ButtonSegment<Mawadie>>[
                    ButtonSegment<Mawadie>(
                        value: Mawadie.history,
                        label: Text('History'),
                        icon: Icon(Icons.book)),
                    ButtonSegment<Mawadie>(
                        value: Mawadie.politics,
                        label: Text('Politics'),
                        icon: Icon(Icons.poll_outlined)),
                    ButtonSegment<Mawadie>(
                        value: Mawadie.culture,
                        label: Text('Culture'),
                        icon: Icon(Icons.ramen_dining)),
                    ButtonSegment<Mawadie>(
                        value: Mawadie.society,
                        label: Text('Society'),
                        icon: Icon(CupertinoIcons.person_3)),
                  ],
                  selected: <Mawadie>{selectedMawadie},
                  emptySelectionAllowed: true,
                  multiSelectionEnabled: true,
                  onSelectionChanged: (Set<Mawadie> newSelection) {
                    selectedMawadie = newSelection.first;
                    // setState(() {
                    //   // By default there is only a single segment that can be
                    //   // selected at one time, so its value is always the first
                    //   // item in the selected set.
                    //   calendarView = newSelection.first;
                    // });
                  },
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("تأكيد"),
            onPressed: () {},
          ),
        ],
      );
    },
  );
}
