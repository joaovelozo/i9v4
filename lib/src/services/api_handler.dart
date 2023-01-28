import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDio {
  var _dio;
  CustomDio() {
    _dio = Dio();
  }
  CustomDio.withAuthentication() {
    _dio = Dio();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));
  }
  Dio get instance => _dio;

  void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    options.headers['Autorization'] = token;
  }

  void _onResponse(Response e, ResponseInterceptorHandler handler) {}

  DioError _onError(DioError e, ErrorInterceptorHandler handler) {
    return e;
  }
}
