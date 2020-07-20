import 'package:connectivity/connectivity.dart';


//todo api listener with network opetion :) cool.
abstract class ApiStateListener{
  void onSuccess(dynamic data);
  void onError(dynamic data);
  void onNoNetWork(ConnectivityResult result);
}