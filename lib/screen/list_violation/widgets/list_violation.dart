import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui/api/cameraInforApi.dart';
import 'package:news_app_ui/api/violationApi.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/dummy_data/violationInfor.dart';
import 'package:news_app_ui/screen/list_violation/widgets/element_violation.dart';
import 'package:news_app_ui/utils/utils.dart';

class ListViolation extends StatefulWidget {
  const ListViolation({super.key});

  @override
  State<ListViolation> createState() => _ListViolationState();
}

class _ListViolationState extends State<ListViolation> {
  final searchController = TextEditingController();
  final idCameraController = TextEditingController();
  final CameraInforApi cameraInforApi = CameraInforApi();
  final ViolationApi violationApi = ViolationApi();
  List<CameraInforEntity> listCamera = [];

  List<Violation> listViolation = [];
  Future<void> getCamera() async {
    List<CameraInforEntity> list = await cameraInforApi.getAllCamera();
    setState(() {
      listCamera = list;
    });

  }
  Future<void> getViolation()async{
    List<Violation> tmp_listViolation = await violationApi.getListViolation(idCameraController.text);
    setState(() {
      listViolation = tmp_listViolation;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCamera();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.clear();
    idCameraController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Column(children: [
      Container(
        width: screenWidth,
        height: 40,
        decoration: BoxDecoration(color: Color.fromRGBO(246, 246, 246, 1.0)),
        child:GestureDetector(
          onTap: (){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text("Chọn camera"),
                      content: SingleChildScrollView(
                        child: Wrap(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomDropdown.search(
                                        items: listCamera.length>0?listCamera.map((e) => e.id).toList():[""],
                                        hintText: "Chọn camera",
                                        controller: idCameraController)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () async{
                            if (idCameraController.text.isNotEmpty) {
                              await getViolation();
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          child:  Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                "assets/icons/ic_diaphragm.png",
                scale: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(idCameraController.text==""?"camera":"camera : "+idCameraController.text,
                  style: SafeGoogleFont(
                    'Mulish',
                    fontSize: 20,
                    // fontWeight: FontWeight.w100,
                    // height: 1,
                  )),


            ],
          ),
        )

      ),
      TextField(
        controller: searchController,
        decoration: InputDecoration(
            hintText: "Nhập thông tin tìm kiếm vi phạm",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {

              },
            )),
      ),
      SizedBox(height: 10,),
      ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: listViolation.length,
        itemBuilder: (BuildContext context, int index) {
          return  ElementViolation(violation: listViolation[index]);
        },
      ),

    ]);

  }
}
