import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui/api/cameraInforApi.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/screen/list_camera/widgets/camera_container.dart';
import 'package:news_app_ui/screen/list_camera/widgets/liveview_camera.dart';

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
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: screenWidth * 0.95,
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
                    SizedBox(width: 10),
                    Icon(
                      Icons.check_circle, // Sử dụng biểu tượng chấm hoặc biểu tượng khác tương tự
                      color: Colors.green , // Màu của biểu tượng
                      size: 12, // Kích thước của biểu tượng
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    itemCount: (listCamera.length % 2 == 0)
                        ? (listCamera.length ~/ 2)
                        : ((listCamera.length / 2).ceil()).toInt(),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4,
                            crossAxisCount: 1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      if ((index + 1) * 2 < listCamera.length) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
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
                                child: CameraContainer(listCamera[index * 2])),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
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
                              child: CameraContainer(listCamera[index * 2 + 1]),
                            )
                          ],
                        );
                      } else if (listCamera.length % 2 == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
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
                                child: CameraContainer(listCamera[index * 2])),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
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
                                child:
                                    CameraContainer(listCamera[index * 2 + 1])),
                          ],
                        );
                      } else {
                        print(index);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
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
                                child: CameraContainer(listCamera[index * 2])),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Xử lý sự kiện khi nút được nhấn
                                print("Button pressed!");
                              },
                              child: Container(
                                width:
                                    screenWidth * 0.4, // Đặt kích thước cho ảnh
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Đặt BorderRadius cho ảnh
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
                // GridView.builder(
                //     itemCount: listCamera.length + 1,
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             childAspectRatio: 1.5,
                //             crossAxisCount: 2,
                //             mainAxisSpacing: 10,
                //             crossAxisSpacing: 10),
                //     itemBuilder: (context, index) {
                //       if (index < listCamera.length) {
                //         // Hiển thị CameraContainer cho các phần tử trong danh sách
                //
                //             return GestureDetector(
                //               onTap: () {
                //                 Navigator.push(
                //                   context,
                //                   PageRouteBuilder(
                //                     pageBuilder: (_, __, ___) => LiveCamera(
                //                         cameraInforEntity: listCamera[index]),
                //                     opaque: false,
                //                     transitionDuration: Duration(seconds: 0),
                //                   ),
                //                 );
                //               },
                //               child: CameraContainer(listCamera[index])
                //
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
