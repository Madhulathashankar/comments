import 'package:comments/Homescreen.dart';
import 'package:comments/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    screenHeight=MediaQuery.of(context).size.height;
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20,40, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiText(
                    sTextName: "Comments",
                    dTextSize: 24.0,
                    colorOfText: kBlueColor,
                    iBoldness: 6,
                  ),
                  SizedBox(height: screenHeight/7),
                  UiTextField(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  UiTextField(
                    hintText: "Password",
                    controller: passwordController,
                  ),
                  SizedBox(height: screenHeight/2.5),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
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
    );
  }
}
