import 'package:comments/Homescreen.dart';
import 'package:comments/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../utils/color_const.dart';
import '../utils/styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

   double screenHeight=0.0;

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
                    SizedBox(height: screenHeight / 9),
                    UiTextField(
                      hintText: "Name",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
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
                    SizedBox(height: screenHeight / 3.5),
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
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                try {
                                  await authProvider.signUp(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  MotionToast.success(
                                    description: Text("Successfully created the account"),
                                  ).show(context);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen()),
                                  );
                                } catch (e) {
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
      ),
    );
  }

}
