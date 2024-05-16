import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:news_app_ui/api/violationApi.dart';
import 'package:news_app_ui/dummy_data/violationInfor.dart';
import 'package:news_app_ui/utils/datetime_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class DetailViolation extends StatefulWidget {
  final Violation violation;
  const DetailViolation({super.key, required this.violation});

  @override
  State<DetailViolation> createState() => _DetailViolationState();
}

class _DetailViolationState extends State<DetailViolation> {
  final ViolationApi violationApi = ViolationApi();
  List<int> dataImageLicenseplate = [];
  List<int> dataImageViolation = [];
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isInitialized = false;

  Future<void> getLicenseplate() async {
    List<dynamic> tmp = await violationApi
        .getImageLicenseplate(widget.violation.nameImageLicenseplateViolation);
    print(tmp);
    setState(() {
      dataImageLicenseplate = tmp.map((e) => int.parse(e.toString())).toList();
    });
  }

  Future<void> getImageViolation() async {
    List<dynamic> tmp = await violationApi
        .getImageViolation(widget.violation.nameImageViolation);
    setState(() {
      dataImageViolation = tmp.map((e) => int.parse(e.toString())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLicenseplate();
    getImageViolation();
    getVideoViolation();
  }

  Future<void> getVideoViolation() async {
    List<dynamic> tmp = await violationApi
        .getVideoViolation(widget.violation.nameVideoViolation);
    List<int> data = tmp.map((e) => e as int).toList();
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_video.mp4');
    await tempFile.writeAsBytes(data, flush: true);
    _controller = VideoPlayerController.file(tempFile)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller?.setLooping(true);
        _controller?.play();
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết vi phạm'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Lỗi vi phạm : "),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Biến số xe : "),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Thời gian vi phạm : "),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(widget.violation.violation),
                              SizedBox(
                                height: 10,
                              ),
                              Text(widget.violation.licenseplate),
                              SizedBox(
                                height: 10,
                              ),
                              Text(DateTimeUtils.formatTimeDDMMYYHHMMSS(
                                  widget.violation.timeViolation)),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: screenWidth * 0.4,
                    child: Column(
                      children: [
                        Text("Hình ảnh biển số xe"),
                        dataImageLicenseplate.length > 0
                            ? Image.memory(
                                Uint8List.fromList(dataImageLicenseplate),
                                fit: BoxFit.scaleDown,
                              )
                            : const CircularProgressIndicator()
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: screenWidth * 0.8,
                child: Column(
                  children: [
                    Text("Hình ảnh vi phạm"),
                    SizedBox(height: 10,),
                    dataImageViolation.length > 0
                        ? Image.memory(
                            Uint8List.fromList(dataImageViolation),
                            fit: BoxFit.scaleDown,
                          )
                        : const CircularProgressIndicator()
                  ],
                )),
            Center(
              child: Text("Video vi phạm",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Center(
                child: _isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
