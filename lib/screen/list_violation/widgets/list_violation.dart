import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui/dummy_data/violationInfor.dart';
import 'package:firedart/firedart.dart';
import 'package:news_app_ui/screen/list_violation/widgets/detail_video_violation.dart';
import 'package:news_app_ui/screen/list_violation/widgets/detail_violation.dart';

class ListViolation extends StatefulWidget {
  const ListViolation({super.key});

  @override
  State<ListViolation> createState() => _ListViolationState();
}

class _ListViolationState extends State<ListViolation> {
  List<ViolationInfor> listViolation = [];
  void getListViolation() async{
    listViolation =[];
    // var ref = Firestore.instance.collection('Violation');
    var ref = Firestore.instance.collection('violation');
    var docment = await ref.get();
    for(var doc in docment) {
      try {
        var data = doc.id;
        // var documentReference = Firestore.instance.collection('Violation')
        var documentReference = Firestore.instance.collection('violation')
            .document(data);
        var d = await documentReference.get();
        if(mounted){
          setState(() {
            ViolationInfor violationInfor= new ViolationInfor(
                d["violation"],
                d["type_traffic"],
                d["image_violation_link"],
                d["image_licenseplate_violation_link"],
                formatDateDDMMYYYHHMMSS(d["time"].toString()),
                d["video_violation_link"],
                d["licenseplate"],
                d["local_camera"],
                data
            );
            for(int i =0 ;i <listViolation.length;i++ ){
              if(compareViolation(listViolation[i], violationInfor)){
                listViolation.removeAt(i);
                i--;
              }
            }
            listViolation.add(violationInfor);
            listViolation.sort((a, b) => a.timeViolation.compareTo(b.timeViolation));
          });
        }

      } catch (e) {
        print(e);
      }
    }
  }
  bool compareViolation(ViolationInfor a,ViolationInfor b){
    return (a.idOnFirebase == b.idOnFirebase)
        &(a.violation == b.violation)
        &(a.licenseplate == b.licenseplate)
        &(a.videoViolationApi == b.videoViolationApi)
        &(a.imageViolationLinkApi == b.imageViolationLinkApi)
        &(a.imageLicenseplateViolationLinkApi == b.imageLicenseplateViolationLinkApi);
  }
  @override
  void initState() {
    super.initState();
    getListViolation();
    // Firestore.instance.collection('Violation').stream.listen((event) {
    Firestore.instance.collection('violation').stream.listen((event) {

      listViolation = [];
      getListViolation();
    });
    listViolation = List.from(listViolation);
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: listViolation.length,
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
                        child: Icon(Icons.warning),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        listViolation[index].violation,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.015,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Row(
                        children: [
                          Text(
                            "Camera : ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width * 0.01,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            listViolation[index].localCamera,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width * 0.01,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            "Biển số xe : ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width * 0.01,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            listViolation[index].licenseplate,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width * 0.01,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            "Thời gian vi phạm : ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width * 0.01,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            listViolation[index].timeViolation,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width * 0.01,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailViolation(violationInfor: listViolation[index]),
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
                            // var documentReference = Firestore.instance.collection('Violation').document(listViolation[index].idOnFirebase);
                            var documentReference = Firestore.instance.collection('violation').document(listViolation[index].idOnFirebase);
                            documentReference.delete();
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
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
  String formatDateDDMMYYYHHMMSS(String date){
    date = date.substring(8,10) +date.substring(4,7)+"-"+date.substring(0,4)+" "+date.substring(11,19) ;
    return date;
  }
}
