import 'package:flutter/material.dart';
import 'package:news_app_ui/screen/list_camera_live//widgets/list_camera_live_widgets.dart';
import 'package:news_app_ui/screen/list_camera_live/widgets/search_header_widget.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

class ListLiveCameraPage extends StatefulWidget {
  ListLiveCameraPage({
    Key? key,
  }) : super(key: key);

  @override
  _ListLiveCameraPageState createState() => _ListLiveCameraPageState();
}

class _ListLiveCameraPageState extends State<ListLiveCameraPage> {
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
