



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/screen/setup/setup_camera_page.dart';
import 'package:news_app_ui/utils/utils.dart';

class ElementCameraContainer extends StatelessWidget {
  final CameraInforEntity cameraInforEntity;
  const ElementCameraContainer({super.key,required this.cameraInforEntity});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => SetUpCameraPage(cameraInforEntity: cameraInforEntity),
            opaque: false,
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
      child: Container(
      width: screenWidth,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromRGBO(218, 218, 218, 1.0)
      ),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Image.asset("assets/icons/ic_cctv.png",scale: 20,),
          SizedBox(width: 10,),
          Text("camera@${cameraInforEntity.id}",
            style: SafeGoogleFont(
              'Mulish',
              fontSize: 16,
              // fontWeight: FontWeight.w100,
              // height: 1,
              color: HexColor("#ffffff"),
            ),)
        ],
      ),
    ),
    );
  }
}
