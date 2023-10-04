import 'package:flutter/material.dart';
import 'package:news_app_ui/screen/login/login.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_bar.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return const MainTabBar();
      //     } else {
      //       return const LoginScreen();
      //     }
      //   },
      // ),
      body: Center(
        child: LoginScreen(),
      ),
    );
  }
}