

import 'dart:collection';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:news_app_ui/api/request.dart';

class LoginApi{
  final ApiRequest apiRequest = new ApiRequest();



  Future<Map<String,String>> login(username,password) async{
    try {

      final res = await apiRequest.dio.post("/api/v1/login",
          data: {"username": username, "password": password});
      print(res.data['data']);
      // Kiểm tra nếu yêu cầu thành công (status code 200)
      if (res.statusCode == 200) {
        final Map<String, dynamic> responseData = res.data;
        final String accessToken = res.data['data']['accessToken'];
        final String refreshToken = res.data['data']['refreshToken'];
        // Tạo một Map chứa các thông tin đã trích xuất và trả về
        final Map<String, String> loginInfo = {
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        };
        // Trả về thông tin đăng nhập
        return loginInfo;
      } else {
        // Nếu yêu cầu không thành công, xử lý theo cách phù hợp, ví dụ: ném một ngoại lệ hoặc trả về một giá trị đặc biệt
        throw Exception('Failed to login: ${res.statusCode}');
      }
    } catch (e) {
      // Xử lý các ngoại lệ trong quá trình gửi yêu cầu API
      print('Error during login: $e');
      rethrow; // Chuyển tiếp ngoại lệ để cho phép xử lý tiếp tục ở nơi gọi
    }

  }
  Future<Map<String,String>> refreshToken(refreshToken) async{
    try {
      final res = await apiRequest.dio.post("/api/v1/refreshToken",
          data: {"refreshToken": refreshToken});
      print(res.data['data']);
      // Kiểm tra nếu yêu cầu thành công (status code 200)
      if (res.statusCode == 200) {
        // Trích xuất thông tin từ phản hồi API
        final Map<String, dynamic> responseData = res.data;

        // Lấy thông tin cần thiết từ phản hồi API (ví dụ: access token, refresh token)
        final String accessToken = res.data['data']['accessToken'];
        final String refreshToken = res.data['data']['refreshToken'];

        // Tạo một Map chứa các thông tin đã trích xuất và trả về
        final Map<String, String> loginInfo = {
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        };
        // Trả về thông tin đăng nhập
        return loginInfo;
      } else {
        // Nếu yêu cầu không thành công, xử lý theo cách phù hợp, ví dụ: ném một ngoại lệ hoặc trả về một giá trị đặc biệt
        throw Exception('Failed to login: ${res.statusCode}');
      }
    } catch (e) {
      // Xử lý các ngoại lệ trong quá trình gửi yêu cầu API
      print('Error during login: $e');
      rethrow; // Chuyển tiếp ngoại lệ để cho phép xử lý tiếp tục ở nơi gọi
    }

  }
}