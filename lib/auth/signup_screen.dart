import 'package:comments/Homescreen.dart';
import 'package:comments/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color_const.dart';
import '../utils/styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController nameController = TextEditingController();
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
                  SizedBox(height: screenHeight/9),
                  UiTextField(
                    hintText: "Name",
                    controller: nameController,
                  ),
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
                            sTextName: "Signup",
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
                        sTextName: "Already have an account? ",
                        dTextSize: 17.0,
                        colorOfText: Colors.black,
                        iBoldness: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: UiText(
                          sTextName: "Login",
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
