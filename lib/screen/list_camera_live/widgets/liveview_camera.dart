import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _isRecording = false;
  bool _isFullScreen = false;
  bool _isShowFunction = true;
  late Directory? _libraryDir;
  late VlcPlayerController _vlcPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initController();
    _vlcPlayerController = VlcPlayerController.network(
      widget.cameraInforEntity.rtspLink,
      options: VlcPlayerOptions(),
      hwAcc: HwAcc.full,
      autoPlay: true,
    );
  }

  Future<void> _initController() async {
    _libraryDir = await getExternalStorageDirectory();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    // print('link ${widget.link}');

    return GestureDetector(
        onTap: () {
          if (_isFullScreen) {
            setState(() {
              _isShowFunction = true;
            });
          }
          // Start a timer to hide the widget after 3 seconds
          Timer(Duration(seconds: 3), () {
            setState(() {
              if (_isFullScreen) {
                _isShowFunction = false;
              }
            });
          });
        },
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text('camera @${widget.cameraInforEntity.id}'),
              ),
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: _isFullScreen ? 0 : 100,
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        height:
                            _isFullScreen ? screenHeight : screenHeight * 0.7,
                        child: VlcPlayer(
                          controller: _vlcPlayerController,
                          aspectRatio: 16 / 9,
                          placeholder:
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ],
                  )),
            ),
            if (_isShowFunction)
              Positioned.fill(
                top: _isFullScreen
                    ? screenHeight - 50
                    : (110 + screenHeight * 0.7),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          width:
                             screenWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_isFullScreen ? 0 : 20)),
                              color: Color.fromRGBO(
                                  229, 229, 229, _isFullScreen ? 0.2 : 0.6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (_isPlay) {
                                    _vlcPlayerController.pause();
                                  } else {
                                    _vlcPlayerController.play();
                                  }
                                  setState(() {
                                    _isPlay = !_isPlay;
                                  });
                                },
                                child: _isPlay
                                    ? Icon(Icons.pause,
                                        size: 28,
                                        color: _isFullScreen
                                            ? Colors.white
                                            : Colors.black)
                                    : Icon(Icons.play_arrow,
                                        size: 28,
                                        color: _isFullScreen
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    Uint8List imageSnapShot =
                                        await _vlcPlayerController
                                            .takeSnapshot();
                                    saveImageToDevice(imageSnapShot);
                                  },
                                  child: Icon(Icons.camera_alt_rounded,
                                      size: 28,
                                      color: _isFullScreen
                                          ? Colors.white
                                          : Colors.black)),
                              TextButton(
                                  onPressed: () async {
                                    if (!_isRecording) {
                                      await _vlcPlayerController.startRecording(
                                          '${_libraryDir!.path}');
                                    } else {
                                      await _vlcPlayerController
                                          .stopRecording();
                                    }
                                    setState(() {
                                      _isRecording = !_isRecording;
                                    });
                                  },
                                  child: _isRecording
                                      ? Icon(
                                          MdiIcons.recordRec,
                                          color: Colors.red,
                                          size: 32,
                                        )
                                      : Icon(MdiIcons.recordRec,
                                          color: _isFullScreen
                                              ? Colors.white
                                              : Colors.black,
                                          size: 32)),
                              Link(
                                  uri: Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query=${widget.cameraInforEntity.lat},${widget.cameraInforEntity.lng}'),
                                  target: LinkTarget.defaultTarget,
                                  builder: (context, openLink) => TextButton(
                                      onPressed: openLink,
                                      child: Icon(
                                        Icons.location_pin,
                                        color: _isFullScreen
                                            ? Colors.white
                                            : Colors.black,
                                        size: 28,
                                      ))),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isFullScreen = !_isFullScreen;
                                      _isShowFunction = !_isFullScreen;
                                    });
                                  },
                                  child: Icon(
                                    Icons.fullscreen,
                                    size: 28,
                                    color: _isFullScreen
                                        ? Colors.white
                                        : Colors.black,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            if (_isShowFunction && _isFullScreen)
              Positioned.fill(
                  bottom: screenHeight-100,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isFullScreen = false;
                            });
                          },
                          child: Icon(Icons.arrow_back_ios_sharp,
                              size: 20, color: Colors.white)),
                      SizedBox(width: 5,),
                      Text(
                        'camera @${widget.cameraInforEntity.id}',
                        style: TextStyle(
                            color: Color.fromRGBO(252, 252, 252, 0.65),
                            fontSize: 14
                        ),
                      ),
                    ],
                  )),
          ],
        ));
  }
}
