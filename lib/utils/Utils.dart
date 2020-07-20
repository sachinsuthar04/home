import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HexColor.dart';

class Utils {
  static String ACCESS_TOKEN = "ACCESS_TOKEN";
  static String USER_ID = "USER_ID";
  static String REFUSERID = "refUserId";
  static String FIRSTNAME = "firstname";
  static String LASTNAME = "lastname";
  static String EMAIL = "email";
  static String MOBILE = "mobile";
  static String DATEOFBIRTH = "dateOfBirth";
  static String GENDER = "gender";
  static String IMAGE = "image";
  static String HEIGHT = "height";
  static String WEIGHT = "weight";
  static String DIABETICCONDITION = "diabeticCondition";
  static String FIREBASETOKEN = "firebaseToken";

  static String MEMBERS_DATA = "members_data";

  static String CURRENTUSER_DATA = "current_user_data";

  //add blood pressure data
  static String BLOODPRESSURE_HIGH = "bloodpressure_high";
  static String BLOODPRESSURE_LOW = "bloodpressure_low";
  static String BLOODPRESSURE_TIME = "bloodpressure_time";
  static String BLOODPRESSURE_DATE = "bloodpressure_date";

  //add glucoreading data
  static String GLUCO_SUGAR = "gluco_sugar";
  static String GLUCO_TYPE = "gluco_type";
  static String GLUCO_DATE = "gluco_date";

  //add oxy result data
  static String OXY_SPO = "oxy_spo";
  static String OXY_PR = "oxy_pr";
  static String OXY_PI = "oxy_pi";
  static String OXY_DATE = "oxy_date";

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.blue,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1);
  }

  static void showLogoutDialog(context, String message) {
    Utils.showToast("This account is login from another device");
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () {},
        child: AlertDialog(
          title: new Text("OlympTrade"),
          content: new Text(
            message,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () async => {
//                await SharedPreferences.getInstance().then((prefs){
//                  Navigator.pop(context);
//                  prefs.clear();//clear login data
//                  Navigator.push(context, SlideRightRoute(page: LoginScreen()));
//                }),
                //goto login screen clear all data from app
              },
            ),
          ],
        ),
      ),
    );
  }

  static navigateToSubPage(context, StatefulWidget nameOfScreen) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => nameOfScreen));
  }

  static void saveDataToPrefString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    prefs.getString('name');
  }

  static void saveDataToPrefBoolen(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static void saveDataToPrefInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int> getDataToPrefInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<String> getDataToPrefString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static void ClearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Widget getTextView(
      String hintText,
      TextEditingController controller,
      int keyboardType,
      bool isAutoFocus,
      bool actionNext,
      ValueChanged<Null> onChanged) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType == 1
          ? TextInputType.number
          : keyboardType == 2
              ? TextInputType.visiblePassword
              : TextInputType.text,
      autofocus: isAutoFocus,
      textInputAction: actionNext ? TextInputAction.go : TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          labelText: hintText),
      onChanged: onChanged,
    );
  }

  static Widget textField(String hintText, int keyboardType, bool isAutoFocus,
      bool actionNext, ValueChanged<Null> onChanged) {
    return TextField(
      keyboardType: keyboardType == 1
          ? TextInputType.number
          : keyboardType == 2
              ? TextInputType.visiblePassword
              : TextInputType.text,
      autofocus: isAutoFocus,
      textInputAction: actionNext ? TextInputAction.go : TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          labelText: hintText),
      onChanged: onChanged,
    );
  }

  static void simpleShowDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text('Dialog Title'),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('user@example.com'),
            onTap: () => Navigator.pop(context, 'user@example.com'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('user2@gmail.com'),
            onTap: () => Navigator.pop(context, 'user2@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Add account'),
            onTap: () => Navigator.pop(context, 'Add account'),
          ),
        ],
      ),
    );
  }

  void showDialogs(context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
              title: Text('how are you!'),
              content: Text(('good!.')),
              insetAnimationDuration: Duration(seconds: 2),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("no"),
                  onPressed: () => {},
                ),
                CupertinoDialogAction(child: Text("yes"), onPressed: () => {}),
              ],
            ));
  }

  static String timePickerDialog(BuildContext context, TimeOfDay initTime) {
    String tempTime;
    showTimePicker(
      context: context,
      initialTime: initTime,
    ).then<TimeOfDay>((TimeOfDay value) {
      tempTime = value.toString();
      return value;
    });
    return tempTime;
  }

  static String datePickerDialog(BuildContext context, DateTime firstDate) {
    String tempDate;
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime.now(),
    ).then<DateTime>((DateTime value) {
      tempDate = value.toString();
      return value;
    });
    return tempDate;
  }

  static void showAleartDialog(BuildContext context, String title, String msg) {
    bool tempBool = false;

    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: new Text(title),
        content: new Text(
          msg,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => {tempBool = false},
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () => tempBool = true,
          ),
        ],
      ),
    );
  }

  static void ShowLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 120,
            width: 80,
            decoration: BoxDecoration(
              color: HexColor("#2C416A"),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new CircularProgressIndicator(),
                new Text("Loading please wait..",
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<bool> isNetWorkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  static TextStyle textStyleNormal18() {
    return TextStyle(color: Colors.white, fontSize: 18.0, height: 1.2);
  }

  static TextStyle textStyleButton() {
    return TextStyle(
        color: Colors.white, fontSize: 18.0, fontFamily: 'PoppinsExtraBold');
  }

  static TextStyle textStyleNormal10ThemeColor(String color, double size) {
    return TextStyle(color: HexColor(color), fontSize: size, height: 1.0);
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String getA1C(double data) {
    if (data > 1 && data < 39) {
      if (data ~/ 2 >= 19) {
        return "3";
      }
      return "3.5";
    } else if (data > 38 && data < 69) {
      if (data ~/ 2 >= 15.5) {
        return "4.5";
      }
      return "4";
    } else if (data > 67 && data < 98) {
      if (data ~/ 2 >= 15.5) {
        return "5.5";
      }
      return "5";
    } else if (data > 97 && data < 127) {
      if (data ~/ 2 >= 15) {
        return "6.5";
      }
      return "6";
    } else if (data > 126 && data < 153) {
      if (data ~/ 2 >= 13.5) {
        return "7.5";
      }
      return "7";
    } else if (data > 152 && data < 184) {
      if (data ~/ 2 >= 16) {
        return "8.5";
      }
      return "8";
    } else if (data > 183 && data < 213) {
      if (data ~/ 2 >= 15) {
        return "9.5";
      }
      return "9";
    } else if (data > 212 && data < 241) {
      if (data ~/ 2 >= 14.5) {
        return "10.5";
      }
      return "10";
    } else if (data > 240 && data < 270) {
      if (data ~/ 2 >= 15) {
        return "11.5";
      }
      return "11";
    } else if (data > 269 && data < 299) {
      if (data ~/ 2 >= 15) {
        return "12.5";
      }
      return "12";
    } else if (data > 298 && data < 327) {
      if (data ~/ 2 >= 14.5) {
        return "13.5";
      }
      return "13";
    } else if (data > 326 && data < 356) {
      if (data ~/ 2 >= 15) {
        return "14.5";
      }
      return "14";
    }else{
      return "14";
    }
  }

  static TextStyle textStyleNormal16() {
    return TextStyle(color: Colors.white, fontSize: 16.0, height: 1.2);
  }

  static TextStyle textStyleNormal14() {
    return TextStyle(color: Colors.white, fontSize: 14.0, height: 1.2);
  }

  static TextStyle textStyleNormal11() {
    return TextStyle(color: Colors.white, fontSize: 10.0, height: 1.2);
  }

  static TextStyle textStyleNormal() {
    return TextStyle(color: Colors.white, fontSize: 20.0);
  }

  static TextStyle linkStyleNoraml() {
    TextStyle(color: HexColor("77b2fe"));
  }

  static TextStyle textStyleBig() {
    return TextStyle(color: Colors.white, fontSize: 40.0);
  }

  static TextStyle textStyleCopyRight() {
    return TextStyle(
        color: Colors.white, fontSize: 12.0, decoration: TextDecoration.none);
  }

  static String setVirtualValue(String str) {
    if (str != null) {
      var strnewbalance = "";
      if (str.contains(".")) {
        var arrstr = str.split(".");
        if (arrstr.length > 1) {
          if (arrstr[1].length > 1) {
            strnewbalance = arrstr[0] + "." + arrstr[1].substring(0, 2);
          }
        }
      }

      if (strnewbalance.length > 0) {
        return strnewbalance;
      } else {
        return str;
      }
    }
  }

  // ignore: non_constant_identifier_names
  static double DEG2RAD = pi / 180.0;

  // ignore: non_constant_identifier_names
  static double FLOAT_EPSILON = 1.4E-45;

  // ignore: non_constant_identifier_names
  static double FDEG2RAD = (pi / 180);

  static double getLineHeight1(TextPainter paint) {
    return getLineHeight2(paint);
  }

  static double getLineHeight2(TextPainter paint) {
    paint.layout();
    return paint.height;
  }

  static double getLineSpacing1(TextPainter paint) {
    return getLineSpacing2(paint);
  }

  static double getLineSpacing2(TextPainter paint) {
    // todo return fontMetrics.ascent - fontMetrics.top + fontMetrics.bottom;
    paint.layout();
    return paint.height * 0.5;
  }

  static int getDecimals(double number) {
    double i = roundToNextSignificant(number);
    if (i.isInfinite || i == 0.0) return 0;

    return (-log(i) / ln10).ceil().toInt() + 2;
  }

  static double roundToNextSignificant(double number) {
    if (number.isInfinite || number.isNaN || number == 0.0) return 0;

    final double d =
        (log(number < 0 ? -number : number) / ln10).ceil().toDouble();
    final int pw = 1 - d.toInt();
    final double magnitude = pow(10.0, pw);
    final int shifted = (number * magnitude).round();
    return shifted / magnitude;
  }

  static double getNormalizedAngle(double angle) {
    while (angle < 0.0) angle += 360.0;

    return angle % 360.0;
  }

  static double optimizeScale(double scale) {
//    return scale > 1.1 ? 1.0 : scale;
    return scale;
  }
}
