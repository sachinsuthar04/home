import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class DashboardPage extends StatefulWidget {
  static const String id = 'switch_screen';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String uid = '';
  final DBref = FirebaseDatabase.instance.reference();

  bool isSwitched;
  bool newVal;

  void LedOn() async {
    await DBref.child(uid)
        .child("Device1")
        .child("LED_STATUS")
        .update({'DATA': 'TRUE'});
  }

  void LedOFF() async {
    await DBref.child(uid)
        .child("Device1")
        .child("LED_STATUS")
        .update({'DATA': 'FALSE'});
  }

  void getStatus() async {
    String newValue = (await FirebaseDatabase.instance
            .reference()
            .child(uid + "/Device1/LED_STATUS/DATA")
            .once())
        .value;
    print(isSwitched);
    setState(() {
      if (newValue == 'TRUE') {
        isSwitched = true;
      } else {
        isSwitched = false;
      }
    });
  }
  void _handleSwitch(bool value) async {
    if( value ) {
      await LedOn();
    } else {
      await LedOFF();
    }
    setState(() {
      isSwitched = value;
    });
  }

  getUid() {}

  @override
  void initState() {
    getStatus();
    this.uid = '';
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this.uid = val.uid;
      });
    }).catchError((e) {
      print(e);
    });
    updateshare();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('IOT DEVICE'),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[

              FlatButton(
                  onPressed: () async {
                    await getStatus();
                  },
                  child: Text('TEST STATUS')),
              FlatButton(
                  onPressed: () {
                    LedOn();
                    print('ON');
                  },
                  child: Text('LED ON')),
              FlatButton(
                  onPressed: () {
                    LedOFF();
                    print('OFF');
                  },
                  child: Text('LED OFF')),
              Switch(
                value: isSwitched,
                onChanged: (value) async {
                  await _handleSwitch(value);
                },
              ),

              new Text('You are now logged in as ${uid}'),
              new OutlineButton(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 3.0),
                child: Text('Logout'),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((action) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
            ],
          )),
    );
  }
  Widget _createSwitch(){
    if(isSwitched==null)
      return Center();
    return  Switch(
      value: isSwitched,
      onChanged: (value) {
        if (isSwitched == 'TRUE') {
          return LedOn();
        } else {
          return LedOFF();
        }
      },
    );
  }
  Future<void> updateshare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", true);
  }
}
