import 'dart:collection';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/api/loginApi.dart';
import 'package:news_app_ui/components/my_button.dart';
import 'package:news_app_ui/components/my_textfield.dart';
import 'package:dio/dio.dart';
import 'package:news_app_ui/main.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBodyScreen extends StatefulWidget {
  const LoginBodyScreen({super.key});

  @override
  State<LoginBodyScreen> createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginApi loginApi = new LoginApi();
  void signUserIn() async {
    try {
      if(validate(emailController.text,passwordController.text)){
          final SharedPreferences prefs = await _prefs;
          user.name = "Test";
          Map<String, String> result = new HashMap();
          result =
          await loginApi.login(emailController.text, passwordController.text);
          result.forEach((key, value) {
            prefs.setString(key, value);
          });
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MainTabBar(0)));
      }

    } catch (e) {
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

  String _errorUsernameMessage = "";
  String _errorPasswordMessage = "";
  bool validate(String username,String password){
    if(username.isEmpty && password.isEmpty){
      setState(() {
        _errorUsernameMessage= "Tên đăng nhập không được để trống";
        _errorPasswordMessage= "Mật khẩu không được để trống";
      });

      return false;
    }
    if(username.isEmpty){
      setState(() {
        _errorUsernameMessage= "Tên đăng nhập không được để trống";
        _errorPasswordMessage = "";
      });
      return false;
    }
    if(password.isEmpty){
        setState(() {
          _errorUsernameMessage = "";
          _errorPasswordMessage= "Mật khẩu không được để trống";
        });
        return false;
    }
    return true;
  }
  bool validateUsername(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorUsernameMessage= "Tên đăng nhập không được để trống";
      });
      return false;
    } else {
      setState(() {
        _errorUsernameMessage = "";
      });
      return true;
    }
  }
  bool validatePassword(String val){
    if (val.isEmpty) {
      setState(() {
        _errorPasswordMessage= "Mật khẩu không được để trống";
      });
      return false;
    } else {
      setState(() {
        _errorPasswordMessage = "";
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;
    return  Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: HexColor("#1A434E"),
          body: OrientationBuilder(builder: (context, orientation) {
            return Center(
              child: SizedBox(
                height: heightScreen,
                width: widthScreen,
                child: orientation == Orientation.portrait
                    ? buildPortraitLayout(context)
                    : buildLandscapeLayout(context),
              ),
            );
          }

          ),
    );
  }

  Widget buildPortraitLayout(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;
    return
      Center(
        child:
        Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
                Expanded(
                    child:  Container(
                      margin: EdgeInsets.only(
                        top: 30
                      ),
                      // height: heightScreen*0.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: HexColor("#ffffff"),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),

                        ),


                      ),
                      child:
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                          child: SingleChildScrollView(
                            child:Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Đăng nhập hệ thống",
                                    style: GoogleFonts.poppins(
                                      fontSize: widthScreen*0.05,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor("#4f4f4f"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tên đăng nhập",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: HexColor("#8d8d8d"),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        MyTextField(

                                          controller: emailController,
                                          hintText: "Vui lòng tên đăng nhâp",
                                          obscureText: false,
                                          prefixIcon: const Icon(Icons.person),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Text(
                                            _errorUsernameMessage,
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
                                          "Mật khẩu",
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
                                            validatePassword(passwordController.text);
                                          }),
                                          controller: passwordController,
                                          hintText: "Vui lòng nhập mật khẩu",
                                          obscureText: true,
                                          prefixIcon: const Icon(Icons.lock_outline),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Text(
                                            _errorPasswordMessage,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  MyButton(
                                    onPressed: signUserIn,
                                    buttonText: 'Đăng nhập',
                                  ),
                                ],
                              ),
                            ) ,
                          )

                    ),
                )
                )
          ],
        )
    );
  }

  Widget buildLandscapeLayout(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;
    return
     Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Stack(
              //   children: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 30
                    ),
                    height: heightScreen*0.8,
                    width: widthScreen*0.5,
                    decoration: BoxDecoration(
                      color: HexColor("#ffffff"),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child:
                        SingleChildScrollView(
                          child: Center(
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Đăng nhập hệ thống",
                                  style: GoogleFonts.poppins(
                                    fontSize: widthScreen*0.03,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#4f4f4f"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Tên đăng nhập",
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
                                              validateUsername(emailController.text);
                                            }),
                                            controller: emailController,
                                            hintText: "Vui lòng điền tên đăng nhập",
                                            obscureText: false,
                                            prefixIcon: const Icon(Icons.person),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                            child: Text(
                                              _errorUsernameMessage,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),


                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mật khẩu",
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
                                              validatePassword(passwordController.text);
                                            }),
                                            controller: passwordController,
                                            hintText: "Vui lòng nhập mật khẩu",
                                            obscureText: true,
                                            prefixIcon: const Icon(Icons.lock_outline),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                            child: Text(
                                              _errorPasswordMessage,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      MyButton(
                                        onPressed: signUserIn,
                                        buttonText: 'Đăng nhập',
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                    ),
                  ),
              ),


            ],
          ),
      );

  }
}
