import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/main.dart';
import 'package:news_app_ui/screen/login/widgets/auth_page.dart';
import 'package:news_app_ui/screen/profile/widgets/profile_widget.dart';
import 'package:news_app_ui/screen/profile/widgets/support_center_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("accessToken");
    prefs.remove("refreshToken");
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => AuthPage(),
        opaque: false,
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 20, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/ic_user.png",
                  width: 36,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  user.name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#8d8d8d")),
                )
              ],
            ),
          ),


          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
          child: Column(
            children: [
              SupportCenterHelp(),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  logout();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Màu nền của nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),

                    ),
                    side: BorderSide(width: 1, color: Color.fromRGBO(108, 108, 108, 1)),
                    minimumSize: Size(screenWidth, 50)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout,
                        color: HexColor("#8d8d8d")), // Icon đăng xuất
                    SizedBox(width: 5), // Khoảng cách giữa icon và văn bản
                    Text(
                      'Đăng Xuất',
                      style:
                          TextStyle(color: HexColor("#8d8d8d"), fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
