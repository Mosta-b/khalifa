import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalifa/core/services/auth_validator.dart';
import 'package:khalifa/core/widgets/addspace/add_height_add_width.dart';
import 'package:khalifa/core/widgets/buttons/normal_button.dart';

import '../../../../core/constant/theme/app_fonts.dart';
import '../bloc/local_auth_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passwordText = TextEditingController();
  final _signInForm = GlobalKey<FormState>();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool obscureText = true;

  @override
  void dispose() {
    _emailText.dispose();
    _passwordText.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalAuthBloc, LocalAuthState>(
      builder: (context, state) {
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
              child: Form(
                key: _signInForm,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Text(
                          "معلومات طالب التزكية",
                          style: FontsManger.secondaryFontFunction(
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      ),
                      const AddHeight(height: 90),
                      SizedBox(
                        height: 90,
                        child: TextFormField(
                          controller: _emailText,
                          focusNode: emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          onTapOutside: (event) {
                            emailFocus.unfocus();
                          },
                          onEditingComplete: () {
                            passwordFocus.requestFocus();
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(width: .1),
                            ),
                            counterText: "سيقبل ايميل الصحيح فقط",
                            suffix: IconButton(
                              icon: const Icon(CupertinoIcons.xmark_circle),
                              onPressed: () {
                                _emailText.clear();
                              },
                            ),
                          ),
                          validator: (value) {
                            return HandleValidation()
                                .isValidEmail(value?.replaceAll(" ", ""));
                          },
                        ),
                      ),
                      const AddHeight(height: 20),
                      SizedBox(
                        height: 90,
                        child: TextFormField(
                          controller: _passwordText,
                          onTapOutside: (event) {
                            passwordFocus.unfocus();
                          },
                          obscureText: obscureText,
                          focusNode: passwordFocus,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(width: .1),
                            ),
                            counterText: "سيقبل الكود المتعلق بالتطبيق فقط",
                            suffix: IconButton(
                              icon: Icon(
                                obscureText
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            return HandleValidation()
                                .validatePassword(value?.replaceAll(" ", ""));
                          },
                        ),
                      ),
                      const AddHeight(height: 150),
                      NormalButton(
                        title: "تاكد من المعلومات",
                        onPressed: () {
                          if (_signInForm.currentState!.validate()) {
                            context.read<LocalAuthBloc>().add(
                                  LocalAuthEventSignUp(
                                    email: _emailText.text,
                                    password: _passwordText.text,
                                  ),
                                );
                          }
                        },
                        mainStyle: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
