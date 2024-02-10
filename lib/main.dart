import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalifa/core/dialogs/error_dialogue.dart';
import 'package:khalifa/src/authentication/presentation/bloc/local_auth_bloc.dart';
import 'package:khalifa/src/authentication/presentation/views/sign_in.dart';
import 'package:khalifa/src/views/main_view.dart';
import 'package:khalifa/src/views/welcome_view.dart';

import 'core/constant/Routes/routes_manager.dart';
import 'core/services/injection_container.dart';

void main() async {
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocalAuthBloc>(
          create: (context) =>
              sl<LocalAuthBloc>()..add(const LocalAuthEventGetUser()),
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
      routes: appRoutes,
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale('ar'),
      // ],
      // locale: const Locale('ar'),
      home: const MainWidget(),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalAuthBloc, LocalAuthState>(
      listener: (context, authState) {
        if (authState.exception != null) {
          showErrorDialog(
            context,
            "Error Happened",
            "${authState.exception?.message}",
          );
        }
      },
      builder: (context, authState) {
        log("am getting this state $authState");
        if (authState is LocalAuthInitial) {
          return const WelcomePage();
        } else if (authState is LocalAuthStateLoggedOut) {
          return const SignIn();
        } else if (authState is LocalAuthStatLoggedIn) {
          return const MainView();
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}
