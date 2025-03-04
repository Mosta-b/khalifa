import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:khalifa/core/constant/phone/phone_size.dart';
import 'package:khalifa/core/constant/theme/app_fonts.dart';
import 'package:khalifa/core/enums/enum.dart';
import 'package:khalifa/core/widgets/addspace/add_height_add_width.dart';
import 'package:khalifa/src/qadaya/presentation/manager/qadiya_bloc.dart';

import '../../../core/extensions/bottom_navigation_bar_provider.dart';
import '../../../core/utils/get_wisdom.dart';
import '../../books/presentation/widgets/book_list.dart';
import '../../qadaya/presentation/pages/qadiya_view.dart';
import '../../qadaya/presentation/widgets/add_qadiya.dart';
import '../../qadaya/presentation/widgets/qadiya_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var islamicToday = HijriCalendar.now();
    String date =
        "${islamicToday.getDayName()}, ${islamicToday.longMonthName} ${islamicToday.hDay.toString()}, ${islamicToday.hYear} ه ";
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: double.infinity,
        height: getScreenHeight(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "صلى الله عليه و سلم",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                date,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const AddHeight(height: 20),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    image: AssetImage(
                      GetWisdom.getWisdomImages(),
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    GetWisdom.getWisdom(),
                    textAlign: TextAlign.center,
                    style: FontsManger.secondaryFontFunction().copyWith(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const AddHeight(height: 20),
              Text(
                "قضايا مستعجلة على المصلح ان ينظر فيها",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const AddHeight(height: 20),
              SizedBox(
                height: 260,
                child: BlocConsumer<QadiyaBloc, QadiyaState>(
                  listener: (context, qadayaState) {
                    if (qadayaState.exception != null) {
                      log("this happened in qadaya bloc ${qadayaState.exception}");
                    }
                  },
                  builder: (context, qadayaState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: qadayaState.existingQadaya.isEmpty
                          ? 1
                          : qadayaState.existingQadaya.length,
                      itemBuilder: (context, index) {
                        if (qadayaState.existingQadaya.isEmpty) {
                          return const AddQadiya();
                        } else if (index ==
                            qadayaState.existingQadaya.length - 1) {
                          final qadaya = qadayaState.existingQadaya[index];
                          return Column(
                            children: [
                              QadiyaCard(
                                title: qadaya.qadiyaTitle,
                                subTitle: "${qadaya.priority} اولوية ",
                                onPressed: () {
                                  context.read<QadiyaBloc>().add(
                                        QadiyaEventGetAllSolutions(
                                          qadiya: qadaya,
                                        ),
                                      );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QadiyaView(
                                        qadiya: qadaya,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const AddQadiya(),
                            ],
                          );
                        } else {
                          final qadaya = qadayaState.existingQadaya[index];
                          return QadiyaCard(
                            title: qadaya.qadiyaTitle,
                            subTitle: "${qadaya.priority} اولوية ",
                            onPressed: () {},
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              const AddHeight(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            onItemTapped(context: context, index: 2),
                        icon: const Icon(
                          CupertinoIcons.arrow_left_circle,
                        ),
                      ),
                      Text(
                        "المزيد",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Text(
                    "مكتبة المركزية",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const Expanded(
                child: BookList(
                  typeOfBooks: TypeOfBooks.all,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
