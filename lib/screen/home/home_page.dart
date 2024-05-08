import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/screen/details/details_page.dart';
import 'package:news_app_ui/screen/home/widgets/dashboard_widget.dart';
import 'package:news_app_ui/screen/home/widgets/list_view_camera.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

import '../../../utils/utils.dart';
import '../../dummy_data/dummy_data.dart';
import '../../gen/assets.gen.dart';
import 'widgets/card_view_widget.dart';
import 'widgets/home_header_widget.dart';
import 'widgets/horizontal_category_list.dart';
import 'widgets/round_icon_button_widget.dart';
import 'widgets/top_slider_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
          child: Column(
            children: [
              const HomeHeaderWidget(),
              const CustomHeightSpacer(
                size: 0.04,
              ),
              Dashboard(),
              Column(
                children: [
                  SizedBox(height: 10,),
                  ListViewCamera(),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}









