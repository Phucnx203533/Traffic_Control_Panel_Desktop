import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app_ui/api/cameraInforApi.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/screen/home/widgets/camera_container_slider.dart';
import 'package:news_app_ui/screen/list_camera_live/widgets/camera_container.dart';
import 'package:news_app_ui/screen/list_camera_live/widgets/liveview_camera.dart';

class ListViewCamera extends StatefulWidget {
  const ListViewCamera({super.key});

  @override
  State<ListViewCamera> createState() => _ListViewCameraState();
}

class _ListViewCameraState extends State<ListViewCamera> {
  final CameraInforApi cameraInforApi = new CameraInforApi();
  List<CameraInforEntity> listCamera = [];
  Future<void> getCamera() async {
    List<CameraInforEntity> list = await cameraInforApi.getAllCamera();
    setState(() {
      listCamera = list;
    });
  }

  var reload = false;
  @override
  void initState() {
    super.initState();
    getCamera();
  }
  @override
  void dispose() {
    // Clean up your resources here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Center(
      child: Container(
          decoration: BoxDecoration(
            color: Color(0xEAEAEAEA),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: screenHeight * 0.5,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/cctv.png",
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Camera",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (listCamera.length > 0)
                  CarouselSlider.builder(
                      itemCount: listCamera.length,
                      options: CarouselOptions(
                        height: screenHeight * 0.4,
                        autoPlay: false,
                        aspectRatio: 8.0,
                        initialPage: 0,
                        viewportFraction: 1,
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int pageViewIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LiveCamera(
                                    cameraInforEntity: listCamera[index]),
                                opaque: false,
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                          child: CameraContainerSlider(listCamera[index]),
                        );
                      })
              ],
            ),
          )),
    );
  }
}
