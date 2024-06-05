import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/gen/assets.gen.dart';
import 'package:news_app_ui/screen/home/widgets/service_box.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:[
        Text(
          "Dashboard",
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: HexColor("#8d8d8d"),
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>MainTabBar(1) ,
                          opaque: false,
                          transitionDuration: Duration(seconds: 0),
                        ),);
                    },
                    child: ServiceBox(
                      title: "Camera live",
                      icon: Assets.icons.icUnSelectedLive.path,
                      bgColor: Colors.green,
                    ),
                  ),
              ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>MainTabBar(2) ,
                      opaque: false,
                      transitionDuration: Duration(seconds: 0),
                    ),);
                },
                child: ServiceBox(
                  title: "Camera",
                  icon: Assets.icons.icUnselectedCamera.path,
                  bgColor: Colors.pinkAccent,
                ),
              ),
            ),

            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>MainTabBar(3) ,
                      opaque: false,
                      transitionDuration: Duration(seconds: 0),
                    ),);
                },
                child: ServiceBox(
                  title: "Cá nhân",
                  icon: Assets.icons.icUnselectedUser.path,
                  bgColor: Colors.amberAccent,
                ),
              ),
            ),
          ],
        ),
      ],
    );



  }
}
