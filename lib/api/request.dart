


import 'package:dio/dio.dart';

class ApiRequest{
  final dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 20)
  )); // With default `Options`.
}