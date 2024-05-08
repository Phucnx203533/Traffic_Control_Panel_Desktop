import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app_ui/api/cameraInforApi.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/screen/home/widgets/camera_container_slider.dart';
import 'package:news_app_ui/screen/list_camera/widgets/camera_container.dart';
import 'package:news_app_ui/screen/list_camera/widgets/liveview_camera.dart';

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
            height: screenHeight*0.5,
            padding: EdgeInsets.all(10),
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

                CarouselSlider.builder(
                  itemCount: listCamera.length,
                  options: CarouselOptions(
                    height: screenHeight*0.4,
                    autoPlay: false,
                    aspectRatio: 8.0,
                    initialPage: 0,
                    viewportFraction: 1,
                  ),
                  itemBuilder: (BuildContext context, int index, int pageViewIndex){
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
                    }
                )
                // GridView.builder(
                //     itemCount: listCamera.length + 1,
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     gridDelegate:
                //     const SliverGridDelegateWithFixedCrossAxisCount(
                //         childAspectRatio: 3,
                //         crossAxisCount: 2,
                //         mainAxisSpacing: 40,
                //         crossAxisSpacing: 10),
                //     itemBuilder: (context, index) {
                //       if (index < listCamera.length) {
                //         // Hiển thị CameraContainer cho các phần tử trong danh sách
                //         return GestureDetector(
                //           onTap: () {
                //             Navigator.push(
                //               context,
                //               PageRouteBuilder(
                //                 pageBuilder: (_, __, ___) => LiveCamera(
                //                     cameraInforEntity: listCamera[index]),
                //                 opaque: false,
                //                 transitionDuration: Duration(seconds: 0),
                //               ),
                //             );
                //           },
                //           child: CameraContainer(listCamera[index]),
                //         );
                //       } else {
                //         // Hiển thị nút ở vị trí index thứ 5
                //         return GestureDetector(
                //           onTap: () {
                //             // Xử lý sự kiện khi nút được nhấn
                //             print("Button pressed!");
                //           },
                //           child: Container(
                //             width: screenWidth * 0.3, // Đặt kích thước cho ảnh
                //             decoration: BoxDecoration(
                //               borderRadius:
                //               BorderRadius.circular(20.0), // Đặt BorderRadius cho ảnh
                //               image: DecorationImage(
                //                 image: AssetImage("assets/images/add-camera.png"),
                //                 fit: BoxFit.cover, // Đảm bảo ảnh không bị vỡ
                //               ),
                //             ),
                //           ),
                //         );
                //       }
                //     }),
              ],
            )));
  }
}
