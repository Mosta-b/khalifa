import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/Routes/routes.dart';
import '../../core/widgets/buttons/normal_button.dart';
import '../authentication/presentation/bloc/local_auth_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalAuthBloc, LocalAuthState>(
      builder: (context, state) {
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(signInPage);
                  },
                  mainStyle: false,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
