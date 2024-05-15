import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_app_ui/api/cameraInforApi.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/screen/list_camera/widgets/add_new_camera.dart';
import 'package:news_app_ui/screen/list_camera/widgets/element_camera_container.dart';
import 'package:news_app_ui/utils/utils.dart';

class ListCamera extends StatefulWidget {
  const ListCamera({super.key});

  @override
  State<ListCamera> createState() => _ListCameraState();
}

class _ListCameraState extends State<ListCamera> {
  final CameraInforApi cameraInforApi = new CameraInforApi();
  List<CameraInforEntity> listCamera = [];
  Future<void> getCamera() async {
    List<CameraInforEntity> list = await cameraInforApi.getAllCamera();
    setState(() {
      listCamera = list;
    });
  }

  @override
  void initState() {
    super.initState();
    getCamera();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Column(
      children: [
        Container(
          width: screenWidth,
          height: 40,
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1.0)
          ),
          child: Row(
            children: [
              SizedBox(width: 10,),
              Image.asset("assets/icons/ic_diaphragm.png",scale: 16,),
              SizedBox(width: 10,),
              Text("camera",style: SafeGoogleFont(
                'Mulish',
                fontSize: 20,
                // fontWeight: FontWeight.w100,
                // height: 1,

              )),
              Spacer(),

              IconButton(
                icon: Icon(Icons.add_circle_outline),
                tooltip: 'Thêm camera',
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>AddNewCameraPage() ,
                  opaque: false,
                  transitionDuration: Duration(seconds: 0),
                  ),);
                },
              )


            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: listCamera.length,
          itemBuilder: (BuildContext context, int index) {
            return  ElementCameraContainer(cameraInforEntity: listCamera[index]);
          },
        ),

      ],
    );
  }
}
