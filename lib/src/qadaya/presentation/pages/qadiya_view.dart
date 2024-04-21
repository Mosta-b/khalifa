import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalifa/src/qadaya/data/models/qadiya_model.dart';
import 'package:khalifa/src/qadaya/data/models/solution_model.dart';
import 'package:khalifa/src/qadaya/presentation/manager/qadiya_bloc.dart';

import '../widgets/add_solution.dart';
import '../widgets/delete_qadiya_confirmation.dart';
import '../widgets/qadiya_card.dart';

class QadiyaView extends StatelessWidget {
  final QadiyaModel qadiya;
  const QadiyaView({Key? key, required this.qadiya}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QadiyaBloc, QadiyaState>(
      builder: (context, qadayaState) {
        List<SolutionModel>? listToBuild = qadayaState.existingSolutions;
        int existingSolutions = qadayaState.existingSolutions != null
            ? 1
            : qadayaState.existingQadaya.isEmpty
                ? 1
                : qadayaState.existingQadaya.length;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(qadiya.qadiyaTitle),
            actions: [
              IconButton(
                  onPressed: () {
                    showDeleteQadiyaDialog(
                      qadiyaModel: qadiya,
                      context: context,
                      content: "سيؤدي حذفك للقضية إلى حذف جميع حلولها معها",
                      title: "هل أنت متأكد من رغبتك في حذف القضية",
                    );
                  },
                  icon: const Icon(CupertinoIcons.trash))
            ],
          ),
          body: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: existingSolutions,
            itemBuilder: (context, index) {
              if (listToBuild != null) {
                if (listToBuild.isEmpty) {
                  return const AddSolution();
                } else if (index == listToBuild.length - 1) {
                  final solution = listToBuild[index];
                  return Column(
                    children: [
                      QadiyaCard(
                        title: solution.title,
                        subTitle: solution.id,
                        onPressed: () {},
                      ),
                      const AddSolution(),
                    ],
                  );
                } else {
                  final solution = listToBuild[index];
                  return QadiyaCard(
                    title: solution.title,
                    subTitle: solution.id,
                    onPressed: () {},
                  );
                }
              } else {
                return const AddSolution();
              }
            },
          ),
        );
      },
    );
  }
}
