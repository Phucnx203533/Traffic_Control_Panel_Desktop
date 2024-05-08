
import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:news_app_ui/api/request.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraInforApi{
  final ApiRequest request = new ApiRequest();
  FutureOr<List<CameraInforEntity>> getAllCamera() async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
        final res = await request.dio.get("/api/v1/camera/list"
            ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              }
            )
        );
      if (res.statusCode == 200) {
        final Map<String, dynamic> map = res.data;
        final List<dynamic> responseData = map['data'];
        List<CameraInforEntity> list =[];

        responseData.forEach((element) {
          Map<String,dynamic> m = element;
          CameraInforEntity result = CameraInforEntity(" ", " ", " "," "," "," "," ", " ", 0,0,0," ","");
          result.id = m["id"];
          result.name = m["name"];
          result.rtspLink = m["linkRtsp"];
          result.htttpLink = m["linkHttpImage"];
          result.lat = m['lat'];
          result.lng = m['lng'];
          result.status = m['status'];
          result.address = m['address'];
          result.city = m['city'];
          result.districts = m['adminCenter'];
          list.add(result);
        });


        // Trả về thông tin đăng nhập
        return list;
      } else {
        // Nếu yêu cầu không thành công, xử lý theo cách phù hợp, ví dụ: ném một ngoại lệ hoặc trả về một giá trị đặc biệt
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      return [];
    }
  }

  Future<String> getImage(cameraId) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.get("/api/v1/image/"+cameraId
          ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              }
          )
      );
      print(res);
      if (res.statusCode == 200) {
        print(res.data['data']);
        return res.data['data'].toString();
      } else {
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      print(e);
      return "";
    }
  }

}