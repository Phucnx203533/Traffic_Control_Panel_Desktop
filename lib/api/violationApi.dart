

import 'package:dio/dio.dart';
import 'package:news_app_ui/api/request.dart';
import 'package:news_app_ui/dummy_data/violationInfor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViolationApi{
  final ApiRequest request = ApiRequest();
  
  
  
  Future<List<Violation>> getListViolation(id) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.get("/api/v1/violation/list?id=${id}"
          ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              }
          )
      );
      if (res.statusCode == 200 && res.data['code'] == "000") {
        final Map<String, dynamic> map = res.data;
        final List<dynamic> responseData = map['data'];
        List<Violation> list = responseData.map((e) => Violation.fromJson(e)).toList();
        return list;
      }else if(res.statusCode == 401){
        throw Exception('Failed to login: ${res.statusCode}');
      } else {
        // Nếu yêu cầu không thành công, xử lý theo cách phù hợp, ví dụ: ném một ngoại lệ hoặc trả về một giá trị đặc biệt
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      return [];
    }
  }

  Future<List<dynamic>> getImageLicenseplate(String nameImage)async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.get("/api/v1/violation/imageLicenseplate?name=${nameImage}"
          ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              }
          )
      );
      if (res.statusCode == 200 && res.data['code'] == "000") {
        final Map<String, dynamic> map = res.data;
       List<dynamic> list = map['data'];

        return list;
      }else if(res.statusCode == 401){
        throw Exception('Failed to login: ${res.statusCode}');
      } else {
        // Nếu yêu cầu không thành công, xử lý theo cách phù hợp, ví dụ: ném một ngoại lệ hoặc trả về một giá trị đặc biệt
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      return [];
    }
  }
  Future<List<dynamic>> getImageViolation(String nameImage)async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.get("/api/v1/violation/imageViolation?name=${nameImage}"
          ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              }
          )
      );
      if (res.statusCode == 200 && res.data['code'] == "000") {
        final Map<String, dynamic> map = res.data;
        List<dynamic> list = map['data'];
        return list;
      }else if(res.statusCode == 401){
        throw Exception('Failed to login: ${res.statusCode}');
      } else {
        // Nếu yêu cầu không thành công, xử lý theo cách phù hợp, ví dụ: ném một ngoại lệ hoặc trả về một giá trị đặc biệt
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      return [];
    }
  }
  Future<List<dynamic>> getVideoViolation(String nameImage)async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      final res = await request.dio.get("/api/v1/violation/videoViolation?name=${nameImage}"
          ,options: Options(
              headers:{
                "Authorization":"Bearer $accessToken"
              }
          )
      );
      if (res.statusCode == 200 && res.data['code'] == "000") {
        final Map<String, dynamic> map = res.data;
        List<dynamic> list = map['data'];
        return list;
      }else if(res.statusCode == 401){
        throw Exception('Failed to login: ${res.statusCode}');
      } else {
        // Nếu yêu cầu không thành công, xử lý theo cách phù hợp, ví dụ: ném một ngoại lệ hoặc trả về một giá trị đặc biệt
        throw Exception('Failed to login: ${res.statusCode}');
      }
    }catch(e){
      return [];
    }
  }
}