import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/gen/assets.gen.dart';
import 'package:news_app_ui/screen/home/widgets/service_box.dart';
import 'package:news_app_ui/screen/list_camera/widgets/list_camera_widgets.dart';
import 'package:news_app_ui/screen/list_violation/widgets/list_violation.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_bar.dart';
import 'package:news_app_ui/utils/utils.dart';

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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MainTabBar(1)
                      ));
                    },
                    child: ServiceBox(
                      title: "Danh sách camera",
                      icon: Assets.icons.icUnselectedCamera.path,
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MainTabBar(2)
                  ));
                },
                child: ServiceBox(
                  title: "Danh sách vi phạm",
                  icon: Assets.icons.icUnselectedListViolation.path,
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
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.info,
                    showCloseIcon: true,
                    title: 'Thông báo',
                    desc:
                    'Tính năng đang phát triển, sẽ giới thiệu đến quý khách trong thời gian tới!',
                    btnOkOnPress: () {
                    },
                    // btnOkIcon: Icons.cancel,
                    onDismissCallback: (type) {
                    },
                  ).show();
                },
                child: ServiceBox(
                  title: "Thống kê",
                  icon: Assets.icons.icUnselectedCamera.path,
                  bgColor: Colors.lightBlue,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.info,
                    showCloseIcon: true,
                    title: 'Thông báo',
                    desc:
                    'Tính năng đang phát triển, sẽ giới thiệu đến quý khách trong thời gian tới!',
                    btnOkOnPress: () {
                    },
                    // btnOkIcon: Icons.cancel,
                    onDismissCallback: (type) {
                    },
                  ).show();
                },
                child: ServiceBox(
                  title: "Danh sách camera",
                  icon: Assets.icons.icUnselectedCamera.path,
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
