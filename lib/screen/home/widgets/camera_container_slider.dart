import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_auth/http_auth.dart';
import 'package:news_app_ui/api/cameraInforApi.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';

class CameraContainerSlider extends StatefulWidget {
  late CameraInforEntity cameraInforEntity;

  CameraContainerSlider(this.cameraInforEntity);

  @override
  State<CameraContainerSlider> createState() => _CameraContainerSliderState();
}

class _CameraContainerSliderState extends State<CameraContainerSlider> {
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
    return dataImage == null
        ? Container(
            height: screenHeight * 0.5, // Đặt kích thước cho ảnh
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(30.0), // Đặt BorderRadius cho ảnh
              image: DecorationImage(
                image: AssetImage("assets/images/image-alt.jpg"),
                fit: BoxFit.scaleDown, // Đảm bảo ảnh không bị vỡ
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  // left: screenWidth * 0.4,
                  bottom: 0,
                  child: Text(
                    'Camera@${widget.cameraInforEntity.id}', // Thay bằng văn bản bạn muốn hiển thị
                    style: TextStyle(
                      color: Colors.white, // Màu văn bản
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: screenHeight * 0.5, // Đặt kích thước cho ảnh
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(20.0), // Đặt BorderRadius cho ảnh
              image: DecorationImage(
                image: MemoryImage(dataImage),
                fit: BoxFit.scaleDown, // Đảm bảo ảnh không bị vỡ
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  // left: screenWidth * 0.4,
                  bottom: 0,
                  child: Text(
                    'Camera@${widget.cameraInforEntity.id}', // Thay bằng văn bản bạn muốn hiển thị
                    style: TextStyle(
                      color: Colors.white, // Màu văn bản
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
