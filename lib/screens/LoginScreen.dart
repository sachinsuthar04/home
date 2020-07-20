import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/Network/ApiStateListener.dart';
import 'package:home/Network/RestDatasource.dart';
import 'package:home/utils/HexColor.dart';
import 'package:home/utils/RouteTransition/FadeRoute.dart';
import 'package:home/utils/Utils.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';



class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> implements ApiStateListener {
  RestDataSource api;

  TextEditingController phonecontroller = TextEditingController();

  Country _selectedDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode('91');


  String phoneNo = "1";
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: new WillPopScope(
            onWillPop: () async => false,
            child: Material(
                type: MaterialType.transparency,
                child: KeyboardAvoider(
                    child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage("assets/img/login_bg.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView(children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  margin: EdgeInsets.only(top: 80.0),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/img/splash_logo.png",
                                        width: 100.0,
                                        height: 100.0,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          "Log in",
                                          style: TextStyle(
                                            color: HexColor("77b2fe"),
                                            fontFamily: "PoppinsBold",
                                            fontSize: 42.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 46,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            new BorderRadius.circular(14.0),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  "assets/img/login_call.png",
                                                  height: 20,
                                                  width: 20,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: _openCountryPickerDialog,
                                                  child: _buildDialogItemField(_selectedDialogCountry)),
//                                          Padding(
//                                            padding: const EdgeInsets.all(8.0),
//                                            child: Image.asset(
//                                              "assets/img/login_flag.png",
//                                              height: 20,
//                                              width: 20,
//                                              fit: BoxFit.cover,
//                                            ),
//                                          ),
                                              Expanded(
                                                child: CupertinoTextField(
                                                  keyboardType:
                                                  TextInputType.number,
                                                  controller: phonecontroller,
                                                  cursorColor: Colors.grey,
                                                  placeholder:
                                                  "Enter Your Mobile Number.",
                                                  placeholderStyle: TextStyle(
                                                      color: Colors.black12,
                                                      fontSize: 16,
                                                      fontFamily: 'PoppinsMedium'),
                                                  maxLength: 10,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                                  style:
                                                  TextStyle(color: Colors.grey,
                                                      fontSize: 16,
                                                      fontFamily: 'PoppinsMedium'),
                                                  onChanged: (String value) {
                                                    if(value.length == 10){
                                                      FocusScope.of(context).unfocus();
                                                    }
                                                  },
                                                ),
                                              ),
                                              phoneNo.isEmpty
                                                  ? Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  "assets/img/ic_error.png",
                                                  height: 15,
                                                  width: 15,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            RichText(
                                              softWrap: true,
                                              text: TextSpan(
                                                style:
                                                TextStyle(color: Colors.grey),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                    'By processing to login, you are agreeing to our\n',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13.5,
                                                        fontFamily: 'PoppinsSemiBold'),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                      '      Terms & Conditions',
                                                      style: TextStyle(
                                                          color: HexColor("77b2fe"),
                                                          fontSize: 13.5,
                                                          fontFamily: 'PoppinsSemiBold'
                                                      ),
                                                      recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          print(
                                                              'Terms of Service"');
                                                        }),
                                                  TextSpan(
                                                      text: ' and ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 13.5,
                                                          fontFamily: 'PoppinsSemiBold')),
                                                  TextSpan(
                                                      text: 'Privacy Policy',
                                                      style: TextStyle(
                                                          color: HexColor("77b2fe"),
                                                          fontSize: 13.5,
                                                          fontFamily: 'PoppinsSemiBold'),
                                                      recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          print(
                                                              'Privacy Policy"');
                                                        }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //login button
                                Container(
                                  height: 42.0,
                                  margin:
                                  EdgeInsets.only(top: 60, left: 12, right: 12),
                                  width: MediaQuery.of(context).size.width,
                                  child: ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(14.0),
                                          side: BorderSide(
                                              color: HexColor("#77b2fe"))),
                                      onPressed: () {
                                        if (!isLoading) {
                                          LoginResetButtonPressed();
                                        }
                                      },
                                      elevation: 2,
                                      color: HexColor("#77b2fe"),
                                      textColor: Colors.white,
                                      child: isLoading
                                          ? CircularProgressIndicator(
                                        backgroundColor: Colors.white10,
                                      )
                                          : Text("Next",
                                          style: Utils.textStyleButton()),
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(right: 20, top: 14),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      RichText(
                                        softWrap: true,
                                        text: TextSpan(
                                          style: TextStyle(color: Colors.grey),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Register account.",
                                                style: TextStyle(
                                                    color: HexColor("77b2fe"),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.5),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                  Utils.showToast("Sign up screen");
//                                                    Navigator.push(
//                                                        context,
//                                                        FadeRoute(
//                                                            page: SignUpScreen()));
                                                  }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ))))),
      ),
    );
  }


  void LoginResetButtonPressed() {
    phoneNo = "+"+_selectedDialogCountry.phoneCode + phonecontroller.text;
    _selectedDialogCountry.name;
    _selectedDialogCountry.iso3Code;
    _selectedDialogCountry.isoCode;
    _selectedDialogCountry.phoneCode;
    if (phonecontroller.text.isEmpty) {
      Utils.showToast("Please enter your mobile number");
      setState(() {
        phoneNo = "";
      });
    } else if (phonecontroller.text.length != 10) {
      Utils.showToast("Please enter valid mobile number");
      setState(() {
        phoneNo = "";
      });
    } else {
      GetLogin();
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    api = new RestDataSource(this);
  }

  @override
  void onError(data) {
    setState(() {
      isLoading = false;
    });

    if (data != null) {
      Utils.showToast(data.toString().substring(10,data.toString().length - 1));
    }

  }

  @override
  void onNoNetWork(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Future<void> onSuccess(data) async {

    setState(() {
      isLoading = false;
    });

//    if (data is LoginResponse) {
//      if (data.meta.code == 1) {
//        setState(() {
//          phonecontroller.text = "";
//        });
//
//        if (data.meta.message != null) {
//          Utils.showToast(data.meta.message);
//        }
//
//        Navigator.push(
//            context, ScaleRoute(page: OTPScreen(isFromNewUser: false,loginResponse: data)));
//
//      }else{
//        if (data.meta.message != null) {
//          Utils.showToast(data.meta.message);
//        }
//      }
//    }
  }


  void GetLogin() {
    setState(() {
      isLoading = true;
    });

//    api.login(this.phoneNo);
  }

  Widget _buildDialogItem(Country country) => Wrap(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 8.0),
      Text("+${country.phoneCode}"),
      SizedBox(width: 8.0),
      Flexible(child: Text(country.name))
    ],
  );

  Widget _buildDialogItemField(Country country) => Wrap(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
    ],
  );

  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: HexColor("77b2fe")),
      child: CountryPickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: HexColor("77b2fe"),
        searchInputDecoration: InputDecoration(hintText: 'Search...'),
        isSearchable: true,
        title: Text('Select your phone code'),
        onValuePicked: (Country country) =>
            setState(() => _selectedDialogCountry = country),
        itemBuilder: _buildDialogItem,
        priorityList: [
          CountryPickerUtils.getCountryByIsoCode('IN'),
          CountryPickerUtils.getCountryByIsoCode('US'),
          CountryPickerUtils.getCountryByIsoCode('CN'),
        ],
      ),
    ),
  );

}
