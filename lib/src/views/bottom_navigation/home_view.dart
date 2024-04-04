import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:khalifa/core/constant/phone/phone_size.dart';
import 'package:khalifa/core/constant/theme/app_fonts.dart';
import 'package:khalifa/core/widgets/addspace/add_height_add_width.dart';
import 'package:khalifa/src/books/presentation/bloc/books_bloc.dart';

import '../../../core/extensions/bottom_navigation_bar_provider.dart';
import '../../../core/utils/get_wisdom.dart';
import '../../../core/widgets/cards/issues_card.dart';
import '../../books/data/model/book_model.dart';
import '../../books/presentation/widgets/book_card.dart';

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
                "قضايا مستعجلة على الخليفة ان ينظر فيها",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const AddHeight(height: 20),
              SizedBox(
                height: 260,
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    IssuesCard(
                      title: "عصي اوامر الله و نبيه صلى الله عليه و سلم",
                      subTitle: "اولوية اولى",
                      onPressed: () {},
                    ),
                    IssuesCard(
                      title: "نقص ارزاق و معاناة مع الفقر",
                      subTitle: "ليس كل دول",
                      onPressed: () {},
                    ),
                    IssuesCard(
                      title: "انتشار المنافقين",
                      subTitle: "حلول ايقاف المنافقين",
                      onPressed: () {},
                    ),
                  ],
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
              Expanded(
                child: BlocBuilder<BooksBloc, BooksState>(
                  builder: (context, bookState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: bookState.books.length,
                      itemBuilder: (context, index) {
                        final BookModel book = bookState.books[index];
                        return BookCard(
                          bookModel: book,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
