import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalifa/src/qadaya/data/models/qadiya_model.dart';
import 'package:khalifa/src/qadaya/presentation/manager/qadiya_bloc.dart';

import '../../../../core/services/qadiaya_validator.dart';
import '../../../../core/utils/get_divider_color.dart';

Future<void> showAddQadiyaDialog({required BuildContext context}) {
  return showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      final qadiya = GlobalKey<FormState>();
      final TextEditingController number = TextEditingController();
      final TextEditingController title = TextEditingController();
      return CupertinoAlertDialog(
        title: const Text("أعط الاسم ورقم الأولوية للقضية"),
        content: Form(
          key: qadiya,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CupertinoTextFormFieldRow(
                textDirection: TextDirection.rtl,
                placeholder: "الرقم",
                controller: number,
                style: TextStyle(
                  color: getDividerColor(context: context),
                ),
                validator: (value) {
                  return value != null
                      ? HandleQadiayaValidation().validateNumber(value)
                      : "can't add no number";
                },
                textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
              ),
              // const AddHeight(height: 5),
              Divider(
                color: getDividerColor(context: context),
                endIndent: 25,
                indent: 25,
              ),
              // const AddHeight(height: 5),
              CupertinoTextFormFieldRow(
                textDirection: TextDirection.rtl,
                placeholder: "الاسم",
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
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("تأكيد"),
            onPressed: () {
              if (qadiya.currentState!.validate()) {
                final QadiyaModel qadiya = QadiyaModel(
                  qadiyaTitle: title.text.trim(),
                  priority: int.parse(number.text),
                );
                context
                    .read<QadiyaBloc>()
                    .add(QadiyaEventAddNewQadiya(qadiya: qadiya));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
