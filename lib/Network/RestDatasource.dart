import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:home/utils/NetworkUtil.dart';
import 'package:home/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'ApiStateListener.dart';

//todo create by PARTH PITRODA:)
class RestDataSource {
  NetworkUtil _netUtil = new NetworkUtil();
  ApiStateListener _apiStateListener;

  RestDataSource(this._apiStateListener);

  static final BASE_URL = "http://3.21.247.136/Backend/api/v1/";
  static final LOGIN_URL = BASE_URL + "login";
  static final SIGN_UP = BASE_URL + "sign-up";


  Future<bool> _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      Utils.showToast("Please check your internet connection!..");
      _apiStateListener.onNoNetWork(result);
      return false;
    } else if (result == ConnectivityResult.mobile) {
      return true;
    } else if (result == ConnectivityResult.wifi) {
      return true;
    }
  }
}
