import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:home/base/GlobalData.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    goToHome();
    setPrefranceInit();
  }

  goToHome() async {

    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new ExactAssetImage('assets/img/splash_bg.png'),
                  fit: BoxFit.cover
              )),
          child: Center(
            child: Container(
              margin: EdgeInsets.all(80),
              child: Image.asset(
                "assets/img/splash_logo.png",
              ),
            ),
          ),
        ),
      ),
    );
  }


  void navigationPage()  async{
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    final userid = prefs.getString(Utils.USER_ID);
//    if(userid != null){
//      if(userid.length > 0){
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => BasePage(false)));
//      }else{
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => LoginScreen()));
//      }
//    }else{
//      Navigator.push(
//          context, MaterialPageRoute(builder: (context) => LoginScreen()));
//    }
  }

  Future<void> setPrefranceInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Provider.of<GlobalData>(context,listen: false).preferences = preferences;
  }

}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}