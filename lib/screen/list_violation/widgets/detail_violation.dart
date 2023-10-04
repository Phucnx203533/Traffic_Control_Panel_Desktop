import 'dart:developer';
import 'dart:io';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui/dummy_data/violationInfor.dart';
import 'package:news_app_ui/paintOverImageLib/image_painter.dart';
import 'package:news_app_ui/screen/list_violation/widgets/detail_infor_violation.dart';
import 'package:news_app_ui/screen/list_violation/widgets/detail_video_violation.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
class DetailViolation extends StatefulWidget {
  final ViolationInfor violationInfor;


  DetailViolation({required this.violationInfor});

  @override
  State<DetailViolation> createState() => _DetailViolationState();
}

class _DetailViolationState extends State<DetailViolation> {
  final _imageKey = GlobalKey<ImagePainterState>();
  // late final player = Player();
  final Player player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);
  bool isValid = true;
  bool isLicenseplateValid  = false ;
  Future<void> downloadVideo(BuildContext context, String videoUrl) async {
    try {
      // Open the folder picker dialog
      final file =  DirectoryPicker()..title = 'Select a directory';
      Directory? result = file.getDirectory();
      if (file != null) {
        final String savePath = '${result!.path}/video-violation-${widget.violationInfor.licenseplate}-${widget.violationInfor.violation}.mp4';
        final response = await http.get(Uri.parse(videoUrl));
        if (response.statusCode == 200) {
          final File file = File(savePath);
          await file.writeAsBytes(response.bodyBytes);
          showSuccessDialog(context,"Tải video thành công !");
        } else {
          showSuccessDialog(context,"Đã xảy ra lỗi trong quá trình tải video. \nVui lòng thử lại !");
        }
      } else {
        showSuccessDialog(context,"Chưa chọn folder lưu trữ !");
      }
    } catch (e) {
      print(e);
    }
  }
  void validateVideoLink() async{
    final res = await http.get(Uri.parse(widget.violationInfor.videoViolationApi));
    final resImageLicenseplate = await http.get(Uri.parse(widget.violationInfor.imageLicenseplateViolationLinkApi));
    if(res.statusCode == 200){
      print("successs");
      player.open(Media(widget.violationInfor.videoViolationApi));

    }
    else{
      setState(() {
          isValid = false;
      });
    }
    if(resImageLicenseplate.statusCode == 200){
        setState(() {
            isLicenseplateValid = true;
        });
    }
    else{
        
    }
  }
  @override
  void initState() {
    super.initState();
    validateVideoLink();
    // print(Media(widget.violationInfor.videoViolationApi));
    // openMedia();
    // player.open(Media(widget.violationInfor.videoViolationApi))
    // try {
    //   player.open(Media(widget.violationInfor.videoViolationApi)).timeout(Duration(seconds: 1)); // Ví dụ: Tăng thời gian chờ lên 10 giây.
    //
    // } catch (error) {
    //   print('Error occurred: $error');
    //   // Xử lý lỗi ở đây, ví dụ: hiển thị thông báo cho người dùng.
    // }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    TextStyle infoTitleStyle = TextStyle(
        color: Colors.black45,
        fontSize: 16,
        fontWeight: FontWeight.bold);
    TextStyle infoTextStyle =
    TextStyle(color: Colors.black45, fontSize: 16);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách vi phạm / Chi tiết"),
      ),
      body:Center(
        child:ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                    elevation: 50,
                    shadowColor: Colors.black,
                    color: Colors.white70,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin chi tiết ',
                              style: infoTitleStyle,
                            ),
                            DetailInfor("Lỗi vi phạm : ", widget.violationInfor.violation),
                            Padding(padding: EdgeInsets.only(top: 3)),
                            DetailInfor("Loại phương tiện : ", widget.violationInfor.typeTraffic),
                            Padding(padding: EdgeInsets.only(top: 3)),
                            DetailInfor("Biển số xe vi phạm : ", widget.violationInfor.licenseplate),
                            Padding(padding: EdgeInsets.only(top: 3)),
                            DetailInfor("Thời gian vi phạm : ", widget.violationInfor.timeViolation),
                            Padding(padding: EdgeInsets.only(top: 3)),
                            DetailInfor("Camera ghi nhận : ", widget.violationInfor.localCamera),
                            Padding(padding: EdgeInsets.only(top: 3)),
                          ]
                      ),

                    )
                ),
                Card(
                    elevation: 50,
                    shadowColor: Colors.black,
                    color: Colors.white70,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Hình ảnh biển số xe ',
                              style: infoTitleStyle,
                            ),
                            isLicenseplateValid?
                            Image.network(widget.violationInfor.imageLicenseplateViolationLinkApi)
                            :Text("Chưa có hình ảnh biển số ! \nĐang thử lại..."),
                          ]
                      ),

                    )
                ),
              ],
            ),
            Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.white70,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hình ảnh vi phạm ',
                          style: infoTitleStyle,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              widget.violationInfor.imageViolationLinkApi,
                              width: MediaQuery.of(context).size.width*0.7,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image has fully loaded
                                  return child;
                                } else {
                                  // Image is still loading, display a progress indicator
                                  return CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  );
                                }
                              },
                            )
                          ],
                        ) ,
                      ]
                  ),

                )
            ),
            Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.white70,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Center(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Video vi phạm", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                            SizedBox(width: 20,),
                            ElevatedButton(
                                onPressed: (){
                                  downloadVideo(context, widget.violationInfor.videoViolationApi);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(40,40),
                                ),
                                child: Icon(
                                  Icons.download,
                                  color: Colors.white,
                                )
                            )
                          ],
                        ),

                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.8,
                          height: MediaQuery.of(context).size.width*0.8 * 9.0 / 16.0,
                          // Use [Video] widget to display video output.
                          child: isValid ? Video(
                              controller: controller
                          ) : Text("Không hiển thị được video !"),
                          // child: Text("Không hiển thị được video !"),
                        ),
                      )
                    ],
                  )

                )
            ),

          ],
        )

      ),

    );
  }
  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
