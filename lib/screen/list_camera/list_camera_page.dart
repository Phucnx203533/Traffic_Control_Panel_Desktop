import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/screen/list_camera//widgets/list_camera_widgets.dart';
import 'package:news_app_ui/screen/list_camera/widgets/add_camera_widget.dart';
import 'package:news_app_ui/screen/list_camera/widgets/search_header_widget.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/utils/utils.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';



class SearchPage extends StatefulWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {
  void getCamera() async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SearchHeaderWidget() ,
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false
      ),
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // CustomHeightSpacer(
              //   size: 0.04,
              // ),
              // SearchBarWidget(),
              // CustomHeightSpacer(
              //   size: 0.04,
              // ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '',
                      style: SafeGoogleFont(
                        'Mulish',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        color: Color(0xff1a434e),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCamera(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(200,50),
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.all(20),
                      ),
                      child: FittedBox(
                        child: Text(
                          "Thêm mới camera",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),

                    )
                  ],
                ),
              CustomHeightSpacer(
                size: 0.04,
              ),
              ListCamera(),

              // CustomHeightSpacer(
              //   size: 0.03,
              // ),
              // TrendingTopicWidget(
              //   name: 'Politics',
              // ),
              // CustomHeightSpacer(
              //   size: 0.02,
              // ),
              // TrendingTopicWidget(
              //   name: 'Politics',
              // ),
              // CustomHeightSpacer(
              //   size: 0.02,
              // ),
              // TrendingTopicWidget(
              //   name: 'Investment',
              // ),
              // CustomHeightSpacer(
              //   size: 0.02,
              // ),
              // TrendingTopicWidget(
              //   name: 'Business',
              // ),
              // CustomHeightSpacer(
              //   size: 0.04,
              // ),
              // Text(
              //   'Trending topic today',
              //   style: SafeGoogleFont(
              //     'Mulish',
              //     fontSize: 20,
              //     fontWeight: FontWeight.w700,
              //     height: 1.3,
              //     color: Color(0xff1a434e),
              //   ),
              // ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: myDataList.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return CardViewWidget(
              //       image: myDataList[index].image,
              //       name: myDataList[index].name,
              //       author: myDataList[index].author,
              //       onTap: () {
              //         Get.to(DetailsPage());
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
