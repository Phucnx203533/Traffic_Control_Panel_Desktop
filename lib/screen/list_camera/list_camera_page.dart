import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/screen/list_camera/widgets/list_camera_widget.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/utils/utils.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

class ListCameraPage extends StatefulWidget {
  const ListCameraPage({super.key});

  @override
  State<ListCameraPage> createState() => _ListCameraPageState();
}

class _ListCameraPageState extends State<ListCameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Danh sách Camera',
                style: SafeGoogleFont(
                  'Mulish',
                  fontSize: 24,
                  // fontWeight: FontWeight.w100,
                  // height: 1,
                  color: HexColor("#8d8d8d"),
                ),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false),
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeightSpacer(
                size: 0.04,
              ),
              ListCamera(),
            ],
          ),
        ),
      ),
    );
  }
}
