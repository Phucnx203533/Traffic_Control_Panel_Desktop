
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/paintOverImageLib/image_painter.dart';
import 'package:http_auth/http_auth.dart';
import 'dart:typed_data';

import 'package:news_app_ui/paintOverImageLib/src/_controller.dart';
class SetUpCameraPage extends StatefulWidget {
  final CameraInforEntity cameraInforEntity;

  // SetUpCameraPage({
  //   Key? key,
  //   CameraInforEntity?cameraInforEntity
  // }) : super(key: key,cameraInforEntity :cameraInforEntity);
  // SetUpCameraPage({Key?key,required this.cameraInforEntity}):super(key: key,cameraInforEntity:cameraInforEntity)
  SetUpCameraPage({required this.cameraInforEntity});

  @override
  _SetUpCameraPageState createState() => _SetUpCameraPageState();
}
void getImage() async{

}
class _SetUpCameraPageState extends State<SetUpCameraPage> {
  final _imageKey = GlobalKey<ImagePainterState>();
  var data;
  Future<void> fetchImage() async {
    try {
      var client = DigestAuthClient('admin', 'Admin@123');
      // final url = Uri.parse("http://14.241.46.150:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view");
      final url = Uri.parse(widget.cameraInforEntity.htttpLink);
      client.get(url).then((r) {
        setState(() {
          data = r.bodyBytes;
        });
      } );
    } catch (e) {
      print(e);
    }
  }
  void saveImage() async {

  }
  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold                      (
      appBar: AppBar(
        title: const Text("Danh sách camera / Kẻ vẽ"),
      ),
      body:Center(
        child: data == null ? CircularProgressIndicator():
        ImagePainter.memory(
            Uint8List.fromList(data),
            key: _imageKey,
            cameraInforEntity: widget.cameraInforEntity,
        ),

      ),

    );
  }
}
