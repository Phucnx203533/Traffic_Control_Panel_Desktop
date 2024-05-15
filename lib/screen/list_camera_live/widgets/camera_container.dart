import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_auth/http_auth.dart';
import 'package:news_app_ui/api/cameraInforApi.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';

class CameraContainer extends StatefulWidget {
  late CameraInforEntity cameraInforEntity;

  CameraContainer(this.cameraInforEntity);

  @override
  State<CameraContainer> createState() => _CameraContainerState();
}

class _CameraContainerState extends State<CameraContainer> {
  final CameraInforApi cameraInforApi = CameraInforApi();
  var dataImage;
  Future<void> getImage() async {
    try {
      var client = DigestAuthClient('admin', 'Admin@123');
      final url = Uri.parse(widget.cameraInforEntity.htttpLink);
      client.get(url).then((r) {
        setState(() {
          dataImage = r.bodyBytes;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return
      Stack(
        alignment: Alignment.center,
        children: [
          dataImage == null
              ? Container(
            width: screenWidth*0.35, // Đặt kích thước cho ảnh
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Đặt BorderRadius cho ảnh
                    image: DecorationImage(
                      image: AssetImage("assets/images/image-alt.jpg"),
                      fit: BoxFit.scaleDown, // Đảm bảo ảnh không bị vỡ
                    ),
                  ),
                )
              : Container(
            width: screenWidth*0.35,// Đặt kích thước cho ảnh
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Đặt BorderRadius cho ảnh
                    image: DecorationImage(
                      image: MemoryImage(dataImage),
                      fit: BoxFit.scaleDown, // Đảm bảo ảnh không bị vỡ
                    ),
                  ),
                ),
          Positioned(
            bottom: screenHeight>screenWidth?screenWidth*0.05:screenHeight*0.05,
            // left: screenWidth*0.1, // Điều chỉnh vị trí ngang của văn bản
            child: Text(
              'Camera@' + widget.cameraInforEntity.id,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      );
  }
}
