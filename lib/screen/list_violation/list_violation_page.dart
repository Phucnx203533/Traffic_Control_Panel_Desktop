import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/screen/list_violation/widgets/list_violation.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/utils/utils.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

class ListViolationPage extends StatefulWidget {
  const ListViolationPage({super.key});

  @override
  State<ListViolationPage> createState() => _ListViolationPageState();
}

class _ListViolationPageState extends State<ListViolationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Danh sách vi phạm',
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

              ListViolation()
            ],
          ),
        ),
      ),
    );
  }
}
