import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khalifa/core/widgets/addspace/add_height_add_width.dart';
import 'package:khalifa/core/widgets/buttons/normal_button.dart';

import '../../../../core/constant/theme/app_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();

  @override
  void dispose() {
    emailText.dispose();
    passwordText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/white_mosque.jpg",
            ),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Text(
                    "معلومات طالب التزكية",
                    style: FontsManger.secondaryFontFunction(
                      textStyle:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                  ),
                ),
                const AddHeight(height: 90),
                SizedBox(
                  height: 80,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: .1),
                      ),
                      counterText: "سيقبل ايميل الصحيح فقط",
                      suffix: IconButton(
                        icon: const Icon(CupertinoIcons.xmark_circle),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const AddHeight(height: 20),
                SizedBox(
                  height: 80,
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: .1),
                      ),
                      counterText: "سيقبل الكود المتعلق بالتطبيق فقط",
                      suffix: IconButton(
                        icon: const Icon(CupertinoIcons.xmark_circle),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const AddHeight(height: 150),
                NormalButton(
                  title: "تاكد من المعلومات",
                  onPressed: () {},
                  mainStyle: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
