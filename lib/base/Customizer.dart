import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'GlobalData.dart';

class Customizer extends StatefulWidget {
  @override
  _CustomizerState createState() => _CustomizerState();
}

class _CustomizerState extends State<Customizer> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        onWillPop: () async => false,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<GlobalData>(
              create: (context) => GlobalData(),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: _themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
            },
          ),
        ));
  }

}
