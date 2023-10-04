import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/components/my_button.dart';
import 'package:news_app_ui/components/my_textfield.dart';
import 'package:dio/dio.dart';
import 'package:news_app_ui/main.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_bar.dart';
import 'package:firedart/firedart.dart';


class LoginBodyScreen extends StatefulWidget {
  const LoginBodyScreen({super.key});

  @override
  State<LoginBodyScreen> createState() => _LoginBodyScreenState();
}
const apiKey = 'AIzaSyBB_0XDdanNZda-vryRhwar0RwwDOQ-7Tc';
const projectId = 'traffic-control-panel-demo';
class _LoginBodyScreenState extends State<LoginBodyScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn() async {
    final dio = Dio();
    // final response = await  dio.get('https://v1.nocodeapi.com/phuc203533/fbsdk/rsKNGrHGFHBOTDYr/firestore/allDocuments?collectionName=account&whereQuery=email,==,'+emailController.text);
    try{
      // print(121);
      // // FirebaseAuth.initialize(apiKey, VolatileStore());
      const email = 'admin@gmail.com';
      const password = 'Abc@1234';
      // const email = '1@gmail.com';
      // const password = '123456';
      var auth = FirebaseAuth.instance;
      // Monitor sign-in state
      // auth.signInState.listen((state) => print("Signed ${state ? "in" : "out"}"));
      // Sign in with user credentials
      await auth.signIn(email, password);

      // Get user object
      var users = await auth.getUser();
      var ref = Firestore.instance.collection('account').document(users.email.toString());
      var d = await ref.get();
      user.name = d['name'];

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MainTabBar(0)
        ));
      // }
    }catch(e){
      print(e);
      showErrorMessage("Tài khoản mật khẩu không chính xác");
    }
  }
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }
  String _errorMessage = "";
  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email không được để trống";
      });
      } else if (!EmailValidator.validate(val, true)) {
        setState(() {
          _errorMessage = "Email không đúng định dạng! Vui lòng thử lại";
        });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#1A434E"),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
          shrinkWrap: true,
          reverse: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 535,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: HexColor("#ffffff"),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Đăng nhập hệ thống",
                              style: GoogleFonts.poppins(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#4f4f4f"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyTextField(
                                    onChanged: (() {
                                      validateEmail(emailController.text);
                                    }),
                                    controller: emailController,
                                    hintText: "traffic@gmail.com",
                                    obscureText: false,
                                    prefixIcon: const Icon(Icons.mail_outline),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Text(
                                      _errorMessage,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Password",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyTextField(
                                    controller: passwordController,
                                    hintText: "**************",
                                    obscureText: true,
                                    prefixIcon: const Icon(Icons.lock_outline),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MyButton(
                                    onPressed: signUserIn,
                                    buttonText: 'Đăng nhập',
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  // Padding(
                                  //   padding:
                                  //   const EdgeInsets.fromLTRB(35, 0, 0, 0),
                                  //   child: Row(
                                  //     children: [
                                  //       Text("Don't have an account?",
                                  //           style: GoogleFonts.poppins(
                                  //             fontSize: 15,
                                  //             color: HexColor("#8d8d8d"),
                                  //           )),
                                  //       // TextButton(
                                  //       //   child: Text(
                                  //       //     "Sign Up",
                                  //       //     style: GoogleFonts.poppins(
                                  //       //       fontSize: 15,
                                  //       //       color: HexColor("#44564a"),
                                  //       //     ),
                                  //       //   ),
                                  //       //   onPressed: () => Navigator.push(
                                  //       //     context,
                                  //       //     MaterialPageRoute(
                                  //       //       builder: (context) =>
                                  //       //       const SignUpScreen(),
                                  //       //     ),
                                  //       //   ),
                                  //       // ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Transform.translate(
                    //   offset: const Offset(0, -253),
                    //   child: Image.asset(
                    //     'assets/Images/plants2.png',
                    //     scale: 1.5,
                    //     width: double.infinity,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}