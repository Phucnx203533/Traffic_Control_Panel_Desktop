import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/screen/list_camera/widgets/edit_information_camera_widget.dart';

class InformationCamera extends StatefulWidget {
  final CameraInforEntity cameraInforEntity;
  InformationCamera({required this.cameraInforEntity});

  @override
  State<InformationCamera> createState() => _InformationCameraState();
}

class _InformationCameraState extends State<InformationCamera> {
  final cameraIp = TextEditingController();
  final district = TextEditingController();
  final httpLink = TextEditingController();
  final nameCamera = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
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
                        Container(
                          height: MediaQuery.of(context).size.height*0.08,
                          width: MediaQuery.of(context).size.width*0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor("#f0f3f1"),
                          ),
                          child: Center(
                            child: Text(
                              widget.cameraInforEntity.name,
                              style:  GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: HexColor("#8d8d8d"),
                                    ),
                            ),
                          )
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
                        Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor("#f0f3f1"),
                            ),
                            child: Center(
                              child: Text(
                                widget.cameraInforEntity.address,
                                style:  GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                            )
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
                        Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor("#f0f3f1"),
                            ),
                            child: Center(
                              child: Text(
                                widget.cameraInforEntity.username,
                                style:  GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                            )
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
                        Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor("#f0f3f1"),
                            ),
                            child: Center(
                              child: Text(
                                widget.cameraInforEntity.password,
                                style:  GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                            )
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
                        Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor("#f0f3f1"),
                            ),
                            child: Center(
                              child: Text(
                                widget.cameraInforEntity.link,
                                style:  GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                            )
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
                        Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor("#f0f3f1"),
                            ),
                            child: Center(
                              child: Text(
                                widget.cameraInforEntity.htttpLink,
                                style:  GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                            )
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditInformationCamera(cameraInforEntity: widget.cameraInforEntity),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(250,40),
                              backgroundColor: Colors.blue,
                            ),
                            child:Text("Chỉnh sửa thông tin camera")
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
}
