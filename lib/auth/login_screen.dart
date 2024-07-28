import 'package:comments/Homescreen.dart';
import 'package:comments/auth/signup_screen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../utils/color_const.dart';
import '../utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  double screenHeight=0.0;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiText(
                      sTextName: "Comments",
                      dTextSize: 24.0,
                      colorOfText: kBlueColor,
                      iBoldness: 6,
                    ),
                    SizedBox(height: screenHeight / 7),
                    UiTextField(
                      hintText: "Email",
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    UiTextField(
                      hintText: "Password",
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight / 2.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200.0,
                          child: CupertinoButton(
                            color: kBlueColor,
                            child: UiText(
                              sTextName: "Login",
                              dTextSize: 18.0,
                              colorOfText: Colors.white,
                              iBoldness: 4,
                            ),
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {

                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Logging in,Please wait!!",
                                );

                                try {
                                  await authProvider.signIn(
                                    emailController.text,
                                    passwordController.text,
                                  );

                                  Navigator.of(context).pop();

                                  MotionToast.success(
                                    description: Text("Login Successful"),
                                  ).show(context);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen()),
                                  );
                                } catch (e) {

                                  Navigator.of(context).pop();

                                  MotionToast.error(
                                    description: Text("Error: $e"),
                                  ).show(context);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UiText(
                          sTextName: "New here? ",
                          dTextSize: 17.0,
                          colorOfText: Colors.black,
                          iBoldness: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                          child: UiText(
                            sTextName: "Signup",
                            dTextSize: 17.0,
                            colorOfText: kBlueColor,
                            iBoldness: 6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
