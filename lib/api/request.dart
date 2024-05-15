


import 'package:dio/dio.dart';

class ApiRequest{
  final dio = Dio(BaseOptions(
    baseUrl: 'http://10.136.214.79:8080',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 20)
  )); // With default `Options`.
}