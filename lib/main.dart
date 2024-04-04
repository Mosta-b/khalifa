import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalifa/core/dialogs/error_dialogue.dart';
import 'package:khalifa/src/authentication/presentation/bloc/local_auth_bloc.dart';
import 'package:khalifa/src/authentication/presentation/views/sign_in.dart';
import 'package:khalifa/src/books/presentation/bloc/books_bloc.dart';
import 'package:khalifa/src/views/main_view.dart';
import 'package:khalifa/src/views/welcome_view.dart';
import 'package:provider/provider.dart';

import 'core/constant/Routes/routes_manager.dart';
import 'core/extensions/bottom_navigation_bar_provider.dart';
import 'core/services/injection_container.dart';

void main() async {
  await init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocalAuthBloc>(
          create: (context) =>
              sl<LocalAuthBloc>()..add(const LocalAuthEventGetUser()),
        ),
        BlocProvider<BooksBloc>(
          create: (context) => sl<BooksBloc>()..add(BooksEventGetAllBooks()),
        ),
      ],
      child: ChangeNotifierProvider<BottomNavBarProvider>(
        create: (context) => BottomNavBarProvider(),
        child: const Khalifa(),
      ),
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
          return BlocConsumer<BooksBloc, BooksState>(
            listener: (context, bookState) {
              if (bookState.exception != null) {
                showErrorDialog(
                  context,
                  "Error Happened",
                  "${authState.exception?.message}",
                );
              }
            },
            builder: (context, state) {
              return const MainView();
            },
          );
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}
