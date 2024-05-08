import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http_auth/http_auth.dart';
import 'package:news_app_ui/components/my_textfield.dart';

class AddCamera extends StatefulWidget {
  const AddCamera({super.key});

  @override
  State<AddCamera> createState() => _AddCameraState();
}

class _AddCameraState extends State<AddCamera> {
  final cameraIp = TextEditingController();
  final district = TextEditingController();
  final httpLink = TextEditingController();
  final nameCamera = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  String errorNameCamera = "";
  String errorDistrict ="";
  String errorCameraIp="";
  String errorHttpLink = "";
  String errorUsername = "";
  String errorPassword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách camera / Thêm mới camera"),
      ),
      body:
          Row(
            children: [
              Expanded(
                  child: GridView(
                      padding: const EdgeInsets.all(25),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 500,
                          mainAxisExtent: 150,
                          childAspectRatio: 5 / 1,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1
                      ),
                      children:[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tên camera",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: HexColor("#8d8d8d"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                              onChanged: (() {

                              }),
                              controller: nameCamera,
                              hintText: "Camera A",
                              obscureText: false,
                              prefixIcon: Icon(null),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                errorNameCamera,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Địa điểm camera",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: HexColor("#8d8d8d"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                              onChanged: (() {

                              }),
                              controller: district,
                              hintText: "Thành phố A",
                              obscureText: false,
                              prefixIcon: Icon(null),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                errorDistrict,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tài khoản kết nối camera",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: HexColor("#8d8d8d"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                              onChanged: (() {

                              }),
                              controller: username,
                              hintText: "username",
                              obscureText: false,
                              prefixIcon: Icon(null),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mật khẩu",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: HexColor("#8d8d8d"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                              onChanged: (() {

                              }),
                              controller: password,
                              hintText: "123456",
                              obscureText: false,
                              prefixIcon: Icon(null),
                            ),
                          ],
                        ),

                      ]
                  )
              ),
              Expanded(
                  child: GridView(
                      padding: const EdgeInsets.all(25),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 700,
                          mainAxisExtent: 150,
                          childAspectRatio: 5 / 1,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1
                      ),
                      children:[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "RTSP Camera link",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: HexColor("#8d8d8d"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                              onChanged: (() {

                              }),
                              controller: cameraIp,
                              hintText: "rtsp://14.242.3.5",
                              obscureText: false,
                              prefixIcon: Icon(null),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                errorCameraIp,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Http Camera link",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: HexColor("#8d8d8d"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                              onChanged: (() {

                              }),
                              controller: httpLink,
                              hintText: "http://192.168.1",
                              obscureText: false,
                              prefixIcon: Icon(null),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                errorHttpLink,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                    previewCamera(username.text, password.text, httpLink.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(350,40),
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text("Kiểm tra tình trạng kết nối camera")
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                                onPressed: (){
                                  addCameratoFirebase(cameraIp.text, httpLink.text, nameCamera.text, district.text, username.text, password.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(150,40),
                                  backgroundColor: Colors.blue,
                                ),
                                child:Text("Lưu")
                            )
                          ],
                        )
                      ]
                  )
              ),

            ],
          ),


    );
  }
  void addCameratoFirebase(String rtspLink,String httpLink,String nameCamera,String district,String username,String password){
    if(validateNameCamera(nameCamera) & validateCameraIp(rtspLink) & validateDistrict(district) & validateHttpLink(httpLink)){
      try{
        showSuccessDialog(context, "Thêm camera thành công");
      }catch(e){
        showSuccessDialog(context, "Đã xảy ra lỗi trong quá trình thêm camera. \nVui lòng thử lại");
      }
    }
  }
  void previewCamera(String username,String password,String httpLink){
    if(validateHttpLink(httpLink)){
      var data;
      try {
        var client = DigestAuthClient(username, password);
        // final url = Uri.parse("http://14.241.46.150:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view");
        final url = Uri.parse(httpLink);
        client.get(url).then((r) {
              data = r.bodyBytes;
              try{
                final imagedata = Image.memory(Uint8List.fromList(data));
              }catch(e){
                  print(1111);
              }


              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Kiểm tra tình trạng kết nối camera'),
                    content:data == null ? CircularProgressIndicator():
                    Image.memory(
                        Uint8List.fromList(data)
                    ),
                  );
                },
              );
        } );
      } catch (e) {
        print(e);
      }

    }
  }
  bool validateNameCamera(String nameCamera){
    if(nameCamera.isEmpty){
      setState(() {
        errorNameCamera = "Tên camera không được để trống !";
      });
      return false;
    }
    return true;
  }
  bool validateDistrict(String district){
    if(district.isEmpty){
      setState(() {
        errorDistrict = "Địa chỉ đặt camera không được để trống !";
      });
      return false;
    }
    return true;
  }
  bool validateCameraIp(String cameraIp){
    if(cameraIp.isEmpty){
      setState(() {
        errorCameraIp = "Link rtsp camera không được để trống !";
      });
      return false;
    }
    return true;
  }
  bool validateHttpLink(String httpLink){
    if(httpLink.isEmpty){
      setState(() {
        errorHttpLink = "Link http camera không được để trống !";
      });
      return false;
    }
    return true;
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
