import 'dart:convert';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:news_app_ui/api/cameraInforApi.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class AddNewCameraPage extends StatefulWidget {
  const AddNewCameraPage({super.key});

  @override
  State<AddNewCameraPage> createState() => _AddNewCameraPageState();
}

class _AddNewCameraPageState extends State<AddNewCameraPage> {
  final CameraInforApi cameraInforApi = CameraInforApi();
  late List<dynamic> provinces =[];
  late List<String> districts = [];
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final rtspStreamingLinkController = TextEditingController();
  final httpsImageLinkController = TextEditingController();
  final lngController = TextEditingController();
  final latController = TextEditingController();
  final idController =TextEditingController();
  final nameCameraController = TextEditingController();
  final addressController = TextEditingController();
  bool _validate = false;
  Future<void> getProvinces()async{
    List<dynamic> result = await cameraInforApi.getProvinces();
    setState(() {
      provinces = result;
    });
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  String? _validateLongtitude(value){
    if(value == ""){
      if(_validate){
        return "Kinh độ không được để trống";
      }
      else{
        return null ;
      }
    }else{
      try{
        if(double.parse(value) <=180.0 && double.parse(value)>=-180.0)
          return null;
      }catch(e){

      }
      return "Giá trị không hợp lệ";
    }

  }
  String? _validateLatitude(value){
    if(value == ""){
      if(_validate){
        return "Vĩ độ không được để trống";
      }
      else{
        return null ;
      }
    }else{
      try{
        if(double.parse(value) <=90.0 && double.parse(value)>=-90.0)
          return null;
      }catch(e){

      }
      return "Giá trị không hợp lệ";
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProvinces();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm mới camera'),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () async{
                String codeScanner = await FlutterBarcodeScanner.scanBarcode('#ffffff', '', false, ScanMode.QR);
                Map<String, dynamic> jsonDataQR = json.decode(codeScanner);
                setState(() {
                  idController.text = jsonDataQR['serial'];
                  nameCameraController.text = jsonDataQR['name'];
                });


            },
          ),
        ],
      ),
      body:OrientationBuilder(builder: (context, orientation) {
        return Center(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: orientation == Orientation.portrait
                ? buildPortraitLayout(context)
                : buildPortraitLayout(context),
          ),
        );
      }

      ),


    );
  }
  Widget buildPortraitLayout(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return
      SingleChildScrollView(
      child:
        Wrap(
          children: [
            SizedBox(
              width: screenWidth*0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Serial camera"),
                    SizedBox(height: 2,),
                    TextField(
                      controller: idController,
                      decoration: InputDecoration(
                        hintText: "Nhập serial camera",
                          border: OutlineInputBorder(),
                          errorText: idController.text==""&&_validate ? "Serial camera không được để trống" : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth*0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tên camera"),
                    SizedBox(height: 2,),
                    TextField(
                      controller: nameCameraController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        hintText: "Nhập tên camera",
                        errorText: nameCameraController.text==""&&_validate ? "Tên camera không được để trống" : null,

                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Địa chỉ rtsp"),
                    SizedBox(height: 2,),
                    TextField(
                      controller: rtspStreamingLinkController,

                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.preview),
                          onPressed: () {
                            // Xử lý khi nút được nhấn
                          },
                        ),
                          border: OutlineInputBorder(),
                        hintText: "Nhập địa chỉ rtsp của camera",
                        errorText: rtspStreamingLinkController.text==""&&_validate ? "Đại chỉ rtsp của camera không được để trống" : null,

                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Địa chỉ hình ảnh snapshot"),
                    SizedBox(height: 2,),
                    TextField(
                      controller: httpsImageLinkController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        hintText: "Nhập địa chỉ hình ảnh snapshot của camera",
                        errorText: httpsImageLinkController.text==""&&_validate ? "Địa chỉ hình ảnh snapshot camera không được để trống" : null,

                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth*0.3,
                      child:  Row(
                        children: [
                          Text("Vị trí"),
                          TextButton(onPressed: ()async{
                            Position localPosition = await _determinePosition();
                            setState(() {
                              latController.text = localPosition.latitude.toString();
                              lngController.text = localPosition.longitude.toString();
                            });
                          }, child: Icon(Icons.location_pin))
                        ],
                      ),
                    ),


                    SizedBox(width: 10,),
                    SizedBox(
                      width: screenWidth*0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tung độ"),
                            SizedBox(height: 2,),
                            TextField(

                              controller: lngController,
                              keyboardType: TextInputType.numberWithOptions(decimal: true), // Chỉ cho phép nhập số và dấu chấm (.)
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                hintText: "Nhập Tung độ",
                                errorText: _validateLongtitude(lngController.text)

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth*0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vĩ độ"),
                            SizedBox(height: 2,),
                            TextField(
                              controller: latController,
                              keyboardType: TextInputType.numberWithOptions(decimal: true), // Chỉ cho phép nhập số và dấu chấm (.)
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                hintText: "Nhập vĩ độ",
                                errorText: _validateLatitude(latController.text),

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth*0.3,
                      child:  Row(
                        children: [
                          Text("Địa chỉ"),
                        ],
                      ),
                    ),


                    SizedBox(width: 10,),
                    SizedBox(
                      width: screenWidth*0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Thành phố/Tỉnh Trực thuộc"),
                            SizedBox(height: 2,),
                            CustomDropdown.search(
                              borderRadius: BorderRadius.all(Radius.circular(3)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black
                              ),
                              onChanged: (value){
                                setState(() {
                                  districtController.text = '';
                                });
                                  int selectedIndex = provinces.indexWhere((element) => element['name'] == value);
                                  // setState(() {
                                  //   districts = provinces[selectedIndex]
                                  // });
                                Map<String,dynamic> tmp = provinces[selectedIndex]['districts'];
                                List<String> tmp_district =[];
                                tmp.forEach((key, value) {
                                  tmp_district.add(value['name']);
                                });
                                setState(() {
                                  districts=tmp_district;
                                });
                              },
                              errorText: cityController.text==""&&_validate ? "Lựa chọn không được để trống" : null,
                              hintText: 'Lựa chọn Thành phố/Tỉnh Trực thuộc ',
                              items: provinces.length >0?provinces.map((e) => e['name'].toString()).toList():[""],
                              controller: cityController,
                            )
                            // TextField(
                            //   decoration: InputDecoration(border: OutlineInputBorder()),
                            // )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth*0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Quận/Huyện/Thành phố"),
                            SizedBox(height: 2,),
                            CustomDropdown.search(
                              borderRadius: BorderRadius.all(Radius.circular(3)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black
                              ),
                              onChanged: (value){

                              },
                              errorText: districtController.text==""&&_validate ? "Lựa chọn không được để trống" : null,
                              hintText: 'Lựa chọn Quận/Huyện/Thành phố ',
                              items: districts.length >0?districts:[""],
                              controller: districtController,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Địa chỉ cụ thể"),
                    SizedBox(height: 2,),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        hintText: "Nhập địa chỉ cụ thể của camera"
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async{
                    setState(() {
                      _validate = true;
                    });
                    if(idController.text!=""
                        &&nameCameraController.text!=""
                        &&rtspStreamingLinkController.text!=""
                        &&httpsImageLinkController.text!=""
                        &&latController.text!=""
                        &&lngController.text!=""
                        &&cityController.text!=""
                        &&districtController.text!=""){
                          Map<String,dynamic> result = await cameraInforApi.createNewCamera({
                            "id":idController.text,
                            "name":nameCameraController.text,
                            "linkRtsp":rtspStreamingLinkController.text,
                            "linkHttpImage":httpsImageLinkController.text,
                            "lat":double.parse(latController.text),
                            "lng":double.parse(lngController.text),
                            "city":cityController.text,
                            "adminCenter":districtController.text,
                            "address":addressController.text,
                          });
                          if(result['isSuccess']){

                            PanaraInfoDialog.show(
                              context,
                              title: "Thông báo",
                              message: "Thêm mới camera thành công",
                              buttonText: "Ok",
                              onTapDismiss: () {
                                Navigator.pop(context);
                              },
                              panaraDialogType: PanaraDialogType.success,
                              barrierDismissible: false, // optional parameter (default is true)
                            );
                          }else{
                            PanaraInfoDialog.show(
                              context,
                              title: "Lỗi",
                              message: result['message'],
                              buttonText: "Okay",
                              onTapDismiss: () {
                                Navigator.pop(context);
                              },
                              panaraDialogType: PanaraDialogType.error,
                              barrierDismissible: false, // optional parameter (default is true)
                            );
                          }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Background color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    elevation: 3, // Button elevation
                  ),
                  child: Text(
                    'Thêm mới',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ),
            ),
          ],
        )
    );
  }

}
