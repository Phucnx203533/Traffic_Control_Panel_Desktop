import 'dart:io';
import 'package:dio/dio.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class VideoViolation extends StatefulWidget {
  final String apiLink;
  const VideoViolation({super.key,required this.apiLink});

  @override
  State<VideoViolation> createState() => _VideoViolationState();
}

class _VideoViolationState extends State<VideoViolation> {
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);
  Future<void> downloadVideo(BuildContext context, String videoUrl) async {
    try {
      // Open the folder picker dialog
      final file =  DirectoryPicker()..title = 'Select a directory';
      Directory? result = file.getDirectory();
      if (file != null) {
        final String savePath = '${result!.path}/video-violation.mp4';
        final response = await http.get(Uri.parse(videoUrl));
        print(response.statusCode);
        if (response.statusCode == 200) {
          final File file = File(savePath);
          await file.writeAsBytes(response.bodyBytes);
          print("ok");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Video downloaded to $savePath')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to download video: ${response.statusCode}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No directory selected')),
        );
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    player.open(Media(widget.apiLink));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
          children: [
            SizedBox(height: 50),
            Center(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Video vi phạm", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: (){
                        downloadVideo(context, widget.apiLink);
                        showSuccessDialog(context,"Tải video thành công !");
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
                width: MediaQuery.of(context).size.width*0.6,
                height: MediaQuery.of(context).size.width*0.6 * 9.0 / 16.0,
                // Use [Video] widget to display video output.
                child: Video(controller: controller),
              ),
            )

          ]
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
