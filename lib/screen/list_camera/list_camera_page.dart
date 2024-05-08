import 'package:flutter/material.dart';
import 'package:news_app_ui/screen/list_camera//widgets/list_camera_widgets.dart';
import 'package:news_app_ui/screen/list_camera/widgets/search_header_widget.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SearchHeaderWidget(),
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
