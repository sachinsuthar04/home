import 'dart:convert';
import 'package:home/vo/ErrorResponse.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url,{Map headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception(new ErrorResponse.fromJson(_decoder.convert(res)).message);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http.post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception(new ErrorResponse.fromJson(_decoder.convert(res)).message);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> put(String url,{Map headers,body}) {
    return http.put(url, body: body, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception(new ErrorResponse.fromJson(_decoder.convert(res)).message);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> uploadFilePost(http.MultipartRequest multipartRequest){
    return multipartRequest.send().then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      print(response.statusCode);
      return response;
    });
  }

}