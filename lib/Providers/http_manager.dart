import 'package:dio/dio.dart';
import 'package:salon_vendor/Providers/constants.dart';


class HttpManager {
  //A free API for artificial intelligence answers
  final String _BASEURL = 'http://api.qingyunke.com/api.php';
  final int _CONNECTTIMEOUT = 5000;
  final int _RECEIVETIMEOUT = 3000;

  //Singleton mode
  static Dio _dio;
  BaseOptions _options;

  //Singleton mode, create an instance only once
  static Dio getInstance() {

      _dio = Dio();

      _dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) {
            print(options.uri.toString());
            //options.headers.addAll(Constants.HEADER);
            return handler.next(options);
          }
          ,
          onResponse: (response, handler) {
            print(response.data.toString());

            return handler.next(response);

          },
          onError: (DioError e, handler) {
            print('error ' + e.message);

            return handler.next(e);

          }
      ));

      return _dio;

  }

}
