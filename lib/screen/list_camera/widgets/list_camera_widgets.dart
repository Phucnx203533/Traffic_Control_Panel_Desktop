import 'package:dio/dio.dart';
import 'package:firedart/generated/google/firestore/v1/firestore.pbgrpc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/paintOverImageLib/image_painter.dart';
import 'package:news_app_ui/paintOverImageLib/src/widgets/_mode_widget.dart';
import 'package:news_app_ui/screen/list_camera/widgets/add_camera_widget.dart';
import 'package:news_app_ui/screen/list_camera/widgets/edit_information_camera_widget.dart';
import 'package:news_app_ui/screen/list_camera/widgets/information_camera_widget.dart';
import 'package:news_app_ui/screen/setup/setup_camera_page.dart';
import 'package:firedart/firedart.dart';
const projectId = 'traffic-control-panel-demo';

class ListCamera extends StatefulWidget {
  const ListCamera({super.key});

  @override
  State<ListCamera> createState() => _ListCameraState();
}

class _ListCameraState extends State<ListCamera> {

  List<CameraInforEntity> listCamera = [];
   var reload = false;
  Future<void> getListCamera() async{
      listCamera = [];
      var ref  =  Firestore.instance.collection('cameraIp');
     var docment = await ref.get();
     for(var doc in docment){
        try{
          var data = doc.id;
          var documentReference = await Firestore.instance.collection('cameraIp').document(data);

          var d = await documentReference.get();
          if(mounted){
            setState(() {
              CameraInforEntity cameraInforEntity = new CameraInforEntity(
                  d['namecam'],
                  d["Ipcamera"],
                  d['district'],data,d['httpLink']);

              cameraInforEntity.addPainHistory(
                  d['point_center_lane'][0],
                  d['point_center_lane'][1],
                  d['point_center_lane'][2],
                  d['point_center_lane'][3],
                  paintModes(TextDelegate()).elementAt(0).mode
                  , Colors.red, TextDelegate().centerLane);
              cameraInforEntity.addPainHistory(
                  d['point_right_lane'][0],
                  d['point_right_lane'][1],
                  d['point_right_lane'][2],
                  d['point_right_lane'][3],
                  paintModes(TextDelegate()).elementAt(1).mode
                  , Colors.blue, TextDelegate().rightLane);
              cameraInforEntity.addPainHistory(
                  d['point_left_lane'][0],
                  d['point_left_lane'][1],
                  d['point_left_lane'][2],
                  d['point_left_lane'][3],
                  paintModes(TextDelegate()).elementAt(2).mode
                  , Colors.yellow, TextDelegate().leftLane);
              cameraInforEntity.addPainHistory(
                  d['point_center_direct'][0],
                  d['point_center_direct'][1],
                  d['point_center_direct'][2],
                  d['point_center_direct'][3],
                  paintModes(TextDelegate()).elementAt(3).mode
                  , Colors.red, TextDelegate().centerDirect);
              cameraInforEntity.addPainHistory(
                  d['point_right_direct'][0],
                  d['point_right_direct'][1],
                  d['point_right_direct'][2],
                  d['point_right_direct'][3],
                  paintModes(TextDelegate()).elementAt(4).mode
                  , Colors.blue, TextDelegate().rightDirect);
              cameraInforEntity.addPainHistory(
                  d['point_left_direct'][0],
                  d['point_left_direct'][1],
                  d['point_left_direct'][2],
                  d['point_left_direct'][3],
                  paintModes(TextDelegate()).elementAt(5).mode
                  , Colors.yellow, TextDelegate().leftDirect);
              cameraInforEntity.addPainHistory(
                  d['point_rect_lane'][0],
                  d['point_rect_lane'][1],
                  d['point_rect_lane'][2],
                  d['point_rect_lane'][3],
                  paintModes(TextDelegate()).elementAt(6).mode
                  , Colors.white, TextDelegate().recRedlight);
              for(int i =0 ;i < listCamera.length;i++){
                  if(compareCameraInfo(listCamera[i], cameraInforEntity)){
                      listCamera.removeAt(i);
                      i--;
                  }
              }
              listCamera.add(cameraInforEntity);
            });
          }
        }catch(e){
          print(e);
        }
       }
  }
  bool compareCameraInfo(CameraInforEntity cam1,CameraInforEntity cam2){
      return (cam1.username == cam2.username)
      &(cam1.idOnFirebase == cam2.idOnFirebase)
      &(cam1.name == cam2.name)
        &(cam1.link == cam2.link)
        &(cam1.address == cam2.address)
        &(cam1.htttpLink == cam2.htttpLink)
      ;

  }


  Future<void> reloadCamera()async{
    getListCamera();
    listCamera=[];
    Firestore.instance.collection('cameraIp').stream.listen((event) {
      getListCamera();
    });


  }
    @override
    void initState() {
      super.initState();
        // reloadCamera();

      Firestore.instance.collection('cameraIp').stream.listen((event) {
        listCamera = [];
        getListCamera();
      });
      getListCamera();

    }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: listCamera.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 10, crossAxisCount: 1, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return Container(
            height: 50.0,
            // color: Colors.grey,
            decoration: BoxDecoration(
                color: const Color(0xffF7F7F7),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)),
                        height: 55,
                        width: 55,
                        child: Icon(Icons.camera),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        listCamera[index].name,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.015,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        listCamera[index].address,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width * 0.01,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InformationCamera(cameraInforEntity: listCamera[index]),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(40,40),
                            backgroundColor: Colors.black26,
                          ),
                          child: Icon(
                            Icons.info_rounded,
                            color: Colors.white,
                          )
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: (){
                            var documentReference = Firestore.instance.collection('cameraIp').document(listCamera[index].idOnFirebase);
                            documentReference.delete();
                            // getListCamera();
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(40,40),
                            backgroundColor: Colors.black26,
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          )
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetUpCameraPage(cameraInforEntity: listCamera[index]),
                              ),
                            );

                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(40,40),
                            backgroundColor: Colors.black26,
                          ),
                          child: Icon(
                            Icons.draw,
                            color: Colors.white,
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
