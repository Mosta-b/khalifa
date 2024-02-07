import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalifa/core/widgets/buttons/normal_button.dart';
import 'package:khalifa/src/authentication/presentation/bloc/local_auth_bloc.dart';

import 'core/services/injection_container.dart';

void main() async {
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocalAuthBloc>(
          create: (context) => sl<LocalAuthBloc>(),
        ),
      ],
      child: const Khalifa(),
    ),
  );
}

class Khalifa extends StatelessWidget {
  const Khalifa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'khalifa Main',
      theme: FlexThemeData.light(
        scheme: FlexScheme.greenM3,
        textTheme: GoogleFonts.notoSansArabicTextTheme(),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.greenM3,
        textTheme: GoogleFonts.notoSansArabicTextTheme(),
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/white_mosque.jpg",
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: NormalButton(
              title: "ادخل المجلس",
              onPressed: () {},
              mainStyle: false,
            ),
          ),
        ),
      ),
    );
  }
}
