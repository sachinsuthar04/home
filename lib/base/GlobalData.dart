import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/utils/Utils.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalData with ChangeNotifier {
  var formatter = DateFormat("dd/mm/yyyy");
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  SharedPreferences _preferences;

  //gluco reading
  int _sugarReadingSelectValue = 0;
  DateTime _glucoDate = DateTime.now();
  int _timeSelectValue = 1;

  //add blood pressure data
  TimeOfDay _bloodTime = TimeOfDay.now();
  DateTime _bloodDate = DateTime.now();
  double _bloodPressureValueHigh = 1.0;
  double _bloodPressureValueLow = 1.0;


  //current user data
  String _profileUrl = "";


  String get profileUrl => _profileUrl;

  SharedPreferences get preferences => _preferences;

  int get timeSelectValue => _timeSelectValue;

  int get sugarReadingSelectValue => _sugarReadingSelectValue;


  double get bloodPressureValueHigh => _bloodPressureValueHigh;

  double get bloodPressureValueLow => _bloodPressureValueLow;

  TimeOfDay get bloodTime => _bloodTime;

  DateTime get bloodDate => _bloodDate;

  DateTime get glucoDate => _glucoDate;


  set profileUrl(String val) {
    _profileUrl = val;
    notifyListeners();
  }


  set preferences(SharedPreferences val) {
    _preferences = val;

    if (_preferences.getString(Utils.BLOODPRESSURE_LOW) != null) {
      _bloodPressureValueLow =
          double.parse(_preferences.getString(Utils.BLOODPRESSURE_LOW));
    }

    if (_preferences.getString(Utils.BLOODPRESSURE_HIGH) != null) {
      _bloodPressureValueHigh =
          double.parse(_preferences.getString(Utils.BLOODPRESSURE_HIGH));
    }

    if (_preferences.getString(Utils.BLOODPRESSURE_DATE) != null) {
      String tempDate = _preferences.getString(Utils.BLOODPRESSURE_DATE);

      _bloodDate = tempDate.contains("/")
          ? formatter.parse(tempDate)
          : dateFormat.parse(tempDate);
    }

    if (_preferences.getString(Utils.GLUCO_TYPE) != null) {
      _timeSelectValue = int.parse(_preferences.getString(Utils.GLUCO_TYPE));
    }

    if (_preferences.getString(Utils.GLUCO_SUGAR) != null) {
      _sugarReadingSelectValue =
          int.parse(_preferences.getString(Utils.GLUCO_SUGAR));
    }

    if (_preferences.getString(Utils.GLUCO_DATE) != null) {
      String tempDate = _preferences.getString(Utils.GLUCO_DATE);

      _glucoDate = tempDate.contains("/")
          ? formatter.parse(tempDate)
          : dateFormat.parse(tempDate);
    }

    notifyListeners();
  }

  set timeSelectValue(int val) {
    _timeSelectValue = val;
    notifyListeners();
  }

  set sugarReadingSelectValue(int val) {
    _sugarReadingSelectValue = val;
    notifyListeners();
  }

  set bloodPressureValueHigh(double val) {
    _bloodPressureValueHigh = val;
    notifyListeners();
  }

  set bloodPressureValueLow(double val) {
    _bloodPressureValueLow = val;
    notifyListeners();
  }

  set bloodTime(TimeOfDay val) {
    _bloodTime = val;
    notifyListeners();
  }

  set bloodDate(DateTime val) {
    _bloodDate = val;
    notifyListeners();
  }

  set glucoDate(DateTime val) {
    _glucoDate = val;
    notifyListeners();
  }

}