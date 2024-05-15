
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:news_app_ui/api/loginApi.dart';
import 'package:news_app_ui/api/request.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';
import 'package:news_app_ui/paintOverImageLib/image_painter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraInforApi{
  final ApiRequest request = new ApiRequest();
  
  final LoginApi loginApi = LoginApi();
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
      if (res.statusCode == 200 && res.data['code'] == "000") {
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
      }else if(res.statusCode == 401){
        loginApi.refreshToken(prefs.getString('refreshToken'));
        throw Exception('Failed to login: ${res.statusCode}');
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
      if (res.statusCode == 200 && res.data['code'] == "000") {
        print(res.data['data']);
        return res.data['data'];
      }else if(res.statusCode == 401){
        loginApi.refreshToken(prefs.getString('refreshToken'));
        throw Exception('Failed to login: ${res.statusCode}');
      } else {
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      print(e);
      return "";
    }
  }
  Future<List<dynamic>> getProvinces()async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.get("/api/v1/province/list"
          ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              }
          )
      );
      if (res.statusCode == 200 && res.data['code'] == "000") {
        print(res.data['data'].runtimeType);
        return res.data['data'];
      }else if(res.statusCode == 401){
        loginApi.refreshToken(prefs.getString('refreshToken'));
        throw Exception('Failed to login: ${res.statusCode}');
      } else {
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<Map<String,dynamic>> createNewCamera(jsonBody)async{
    Map<String,dynamic> result = {};
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.post("/api/v1/camera/create"
          ,data: jsonBody
          ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              },
          )
      );

      if (res.statusCode == 200 && res.data['code'] == "000") {
        result["isSuccess"] = true;
        result["message"] = res.data['message'];
        return result;
      }else if(res.statusCode == 401){
        loginApi.refreshToken(prefs.getString('refreshToken'));
        throw Exception('Failed to login: ${res.statusCode}');
      }
      else {
        result["isSuccess"] = false;
        result["message"] = res.data['message'];
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      print(e);
      return result;
    }
  }
  Future<Map<String,dynamic>> createRule(List<PaintInfo> data,id)async{
    Map<String,dynamic> result = {};
    List<dynamic> res = data.map((e) => e.toJson()).toList();
    dynamic jsonBody =jsonEncode(res);
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.post("/api/v1/camera/add-rule-config/${id}"
          ,data: jsonBody
          ,options: Options(
            headers:{
              "Authorization":"Bearer $accessToken"
            },
          )
      );
      print(res);
      if (res.statusCode == 200 && res.data['code'] == "000") {
        result["isSuccess"] = true;
        result["message"] = res.data['message'];
        return result;
      }else if(res.statusCode == 401){
        loginApi.refreshToken(prefs.getString('refreshToken'));
        throw Exception('Failed to login: ${res.statusCode}');
      }
      else {
        result["isSuccess"] = false;
        result["message"] = res.data['message'];
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      print(e);
      return result;
    }
  }
  Future<Map<String,dynamic>> getRuleConfig(id)async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.get("/api/v1/camera/get-rule-config/${id}"
          ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              }
          )
      );
      if (res.statusCode == 200) {
        return res.data;
      }else if(res.statusCode == 403){
        throw Exception('Failed to login: ${res.statusCode}');
      } else {
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      print(e);
      return {};
    }

  }


}