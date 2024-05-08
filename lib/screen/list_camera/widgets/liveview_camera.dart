import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:path_provider/path_provider.dart';

class LiveCamera extends StatefulWidget {
  LiveCamera({Key? key, required this.cameraInforEntity}) : super(key: key);
  final CameraInforEntity cameraInforEntity;
  @override
  State<LiveCamera> createState() => _LiveCameraState();
}

class _LiveCameraState extends State<LiveCamera> {
  Future<void> saveImageToDevice(Uint8List imageBytes) async {
    try {
      // Get the external storage directory using path_provider
      Directory? externalDir = await getExternalStorageDirectory();

      // Create a file in the external storage directory with a unique name
      String filePath = '${externalDir!.path}/image.png';
      File imageFile = File(filePath);

      // Write the image bytes to the file
      await imageFile.writeAsBytes(imageBytes);

      print('Image saved to: $filePath');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  bool _isPlay = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VlcPlayerController _vlcPlayerController =
    VlcPlayerController.network(
      widget.cameraInforEntity.rtspLink,
      options: VlcPlayerOptions(

      ),
      hwAcc: HwAcc.full,
      autoPlay: true,
    );
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    // print('link ${widget.link}');

    return Scaffold(
      appBar: AppBar(
        title: Text('camera @${widget.cameraInforEntity.id}'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              height: screenHeight*0.7,
              child: VlcPlayer(
                controller: _vlcPlayerController,
                aspectRatio: 16 / 9,
                placeholder: Center(child: CircularProgressIndicator()),
              ),
            ),
            Container(
              width: screenWidth * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_isPlay) {
                        _isPlay = false;
                        _vlcPlayerController.pause();
                      } else {
                        _isPlay = true;
                        _vlcPlayerController.play();
                      }
                    },
                    child: _isPlay
                        ? Icon(Icons.pause, size: 28, color: Colors.black)
                        : Icon(Icons.play_arrow, size: 28, color: Colors.black),
                  ),
                  TextButton(onPressed: () async{
                        Uint8List imageSnapShot = await _vlcPlayerController.takeSnapshot();
                        saveImageToDevice(imageSnapShot);
                  }
                  , child: Icon(Icons.camera_alt_rounded,size: 28, color: Colors.black))
                ],
              ),
            ),

          ],
        ),
      ),
    );

  }

}
