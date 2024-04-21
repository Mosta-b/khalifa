import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalifa/src/qadaya/data/models/qadiya_model.dart';

import '../../../../core/dialogs/generic_dialogue.dart';
import '../manager/qadiya_bloc.dart';

Future<void> showDeleteQadiyaDialog({
  required BuildContext context,
  required String title,
  required String content,
  required QadiyaModel qadiyaModel,
}) {
  return showGenericDialog<void>(
    context: context,
    title: title,
    content: content,
    optionBuilder: () => {
      'خروج': () => Navigator.of(context).pop(),
      'تاكيد': () => context
          .read<QadiyaBloc>()
          .add(QadiyaEventDeleteQadiya(qadiya: qadiyaModel)),
    },
  );
}
