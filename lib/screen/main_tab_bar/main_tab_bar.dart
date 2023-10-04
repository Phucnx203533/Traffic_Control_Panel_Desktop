import 'package:flutter/material.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/screen/home/home_page.dart';
import 'package:news_app_ui/screen/list_violation/list_violation_page.dart';
import 'package:news_app_ui/screen/list_camera//list_camera_page.dart';
import 'package:news_app_ui/screen/setup/setup_camera_page.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';
import '../page/page.dart';
import 'widgets/bottom_icon_widget.dart';

class MainTabBar extends StatefulWidget {
  // const MainTabBar({Key? key}) : super(key: key);
  final int page ;
  MainTabBar(this.page);

  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  int pageIndex  = 0;
  @override
  void initState() {
    super.initState();
    // reloadCamera();
    pageIndex = widget.page;

  }
  final pages = [
    HomePage(),
    SearchPage(),
    ListViolationPage(),
    SamplePage(
      title: 'Profile Page',
    ),
    SetUpCameraPage(cameraInforEntity: new CameraInforEntity("", "", "","",""))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[pageIndex],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Theme.of(context).bottomAppBarColor,
        margin: const EdgeInsets.only(top: 2, right: 0, left: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            BottomIconWidget(
              title: '',
              iconName:  pageIndex == 0 ?  Assets.icons.icSelectedHome.path: Assets.icons.icUnselectedHome.path,
              iconColor: pageIndex == 0
                  ? Theme.of(context).primaryColor
                  : AppColors.gray,
              tap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
            ),

            BottomIconWidget(
              title: '',
              iconName:  pageIndex == 1 ?  Assets.icons.icSelectedCamera.path: Assets.icons.icUnselectedCamera.path,
              iconColor: pageIndex == 1
                  ? Theme.of(context).primaryColor
                  : AppColors.gray,
              tap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
            ),

            BottomIconWidget(
              title: '',
              iconName:  pageIndex == 2 ?  Assets.icons.icSelectedListViolation.path: Assets.icons.icUnselectedListViolation.path,
              iconColor: pageIndex == 2
                  ? Theme.of(context).primaryColor
                  : AppColors.gray,
              tap: () {
                setState(() {
                  pageIndex = 2;
                });
              },
            ),


            BottomIconWidget(
              title: '',
              iconName:  pageIndex == 3 ?  Assets.icons.icSelectedUser.path: Assets.icons.icUnselectedUser.path,
              iconColor: pageIndex == 3
                  ? Theme.of(context).primaryColor
                  : AppColors.gray,
              tap: () {
                setState(() {
                  pageIndex = 3;
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
